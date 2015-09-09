class Tag < Struct.new(:element, :attributes, :children, :parent)
	def id
		attributes[:id]
	end

	def classes
		attributes[:class]
	end

	def query(key, value)
		result = nil
		case key
		when :element
			result = self if value == element
		when :text
			result = self unless children.select {|c| c == value}.empty?
		else
			result = self if attributes[key] == value
		end
		result
	end

	def stats(results={})
		results[:total_descendents] = 0 unless results[:total_descendents]
		results[element.to_sym] = 0 unless results[element.to_sym]
		results[element.to_sym] += 1
		return if children.empty?
		children.each do |child|
			results[:total_descendents] += 1
			child.stats(results) if child.is_a?(Tag)
		end
	end

	def to_s
		tag = "<#{element}"
		attributes.each do |key, value|
			tag += " #{key}=\"#{value}\""
		end
		if self_closing?
			tag += '/>'
		else
			tag += '>'
			children.each do |child|
				tag += child.to_s
			end
			tag += "</#{element}>"
		end
	end

	def closing_tag?(str)
		"</#{element}>" == str
	end

	def self_closing?
		!!"<#{element}>".match(SELF_CLOSING_TAG)
	end

	def self.create_attributes_from(str)
		matches = str.scan(ATTRIBUTE).map {|i| i[0]}
		attributes = {}
		matches.each do |i|
			a = i.split('=')
			key = a[0]
			value = a[1].gsub(/["'\\]/, '')
			attributes[key.to_sym] = value
		end
		attributes
	end

	def self.create_tag_from(matches)
		element = matches[1]
		attributes = Tag.create_attributes_from(matches[2])
		children = []
		children << matches[6] if matches[6]
		Tag.new(element, attributes, children)
	end
end
