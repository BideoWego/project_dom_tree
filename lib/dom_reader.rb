require_relative 'regex.rb'
require_relative 'tag.rb'

class DOMReader

  # Document is writeable
	attr_accessor :document

  # Doctype and root
  # are read only
	attr_reader :doctype, :root

  # Initialize the document
  # if passed
	def initialize(document=nil)
		self.document = document if document
	end


  # Set new document and build
	def document=(value)
		@document = value
		build
	end


  # Build the document from the
  # given text
	def build
		text_strings = @document.split(ANGLE_BRACKETS)
		html_tokens = @document.scan(ANGLE_BRACKETS)

		@doctype = html_tokens[0]

		parse(html_tokens, text_strings)

		@root
	end

  def parse(html_tokens, text_strings)
    i = 1
    token = html_tokens[i]
    matches = token.match(OPENING_TAG)
    @root = node = Tag.create_tag_from(matches)
    i += 1
    until (token.match(ROOT_CLOSING))
      token = html_tokens[i]
      text = text_strings[i + 1]
      child = nil
      if (matches = token.match(TAG))                ||
         (matches = token.match(SELF_CLOSING_TAG))
        child = Tag.create_tag_from(matches)
        child.parent = node
        node.children << child
      elsif (matches = token.match(OPENING_TAG))
        child = Tag.create_tag_from(matches)
        node.children << child
        child.parent = node
        node = child
      elsif node.closing_tag?(token)
        node = node.parent
      end
      node.children << text unless text.strip.empty?
      i += 1
    end
  end

	def render
		"#{@doctype}#{@root}"
	end

	def stats(node=nil)
		node = node || @root
		results = {}
		results[:element] = node.element
		results[:attributes] = node.attributes
		node.stats(results)
		results
	end

	def search_by(key, value)
		results = []
		results << @root if @root.query(key, value)
		search_children(@root, key, value, results)
	end

	def search_children(node, key, value, results=[])
		if node.query(key, value)
			results << node
			return
		end
		node.children.each do |child|
			search_children(child, key, value, results) if child.is_a?(Tag)
		end
		results
	end

	def search_ancestors(node, key, value)
		results = []
		node.children.each do |child|
			if child.is_a?(Tag)
				results << child if child.query(key, value)
			end
		end
		results
	end
end







