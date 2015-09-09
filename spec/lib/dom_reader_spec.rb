require 'spec_helper'

describe DOMReader do
	let(:html){File.read('test.html')}
	let(:d){DOMReader.new(html)}

	before do
		d
	end

	describe '#initialize' do
		it 'accepts string of an HTML document as input' do
			expect do
				DOMReader.new(html)
			end.to_not raise_error
		end
	end

	describe '#document' do
		it 'returns the origin string of the HTML document' do
			expect(d.document).to eq(html)
		end
	end

	describe '#doctype' do
		it 'returns the DOCTYPE from the HTML string' do
			expect(d.doctype).to_not eq('<!doctype>')
		end
	end

	describe '#root' do
		it 'returns a Tag' do
			expect(d.root).to be_an_instance_of(Tag)
		end

		it 'returns a Tag with an element of html' do
			expect(d.root.element).to eq('html')
		end
	end

	describe '#build' do
		it 'builds the document tree' do
			expect(html.gsub(/\s/, '')).to eq(d.render.gsub(/\s/, ''))
		end
	end

	describe '#render' do
		it 'returns the document tree rendered to a string' do
			expect(d.render).to be_kind_of(String)
		end
	end

	describe '#stats' do
		it 'returns statistics about the given node' do
			expect(d.stats).to be_kind_of(Hash)
		end
	end

	describe '#search_by' do
		it 'allows search by key value pair' do
			expect(d.search_by(:text, 'One h1')[0]).to be_an_instance_of(Tag)
		end
	end

	describe '#search_children' do
		it 'searchs the tree under a given node' do
			d.search_children(d.root, :element, 'li').each do |i|
				expect(i.element).to eq('li')
			end
		end
	end

	describe '#search_ancestors' do
		it 'searchs the children of a given node' do
			expect(d.search_ancestors(d.root, :element, 'head')[0]).to be_an_instance_of(Tag)
		end
	end
end

