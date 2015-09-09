require 'spec_helper'

describe Tag do
	let(:t){Tag.new('html', {:id => 'root', :class => 'foo bar baz'}, [])}

	describe '#id' do
		it 'returns the id of the tag' do
			expect(t.id).to eq('root')
		end
	end

	describe '#classes' do
		it 'returns the classes of the tag' do
			expect(t.classes).to eq('foo bar baz')
		end
	end

	describe '#query' do
		it 'returns self when the key value pair matches the state of the tag' do
			expect(t.query(:element, 'html')).to eq(t)
		end
	end

	describe '#stats' do
		it 'appends info to the given hash about the tag' do
			results = {}
			t.stats(results)
			expect(results[:total_descendents]).to eq(0)
			expect(results[:html]).to eq(1)
		end
	end

	describe '#to_s' do
		it 'returns a rendered string of the tag and all children' do
			title = Tag.new('title', {}, [])
			title.children << 'Hello World!'
			head = Tag.new('head', {}, [])
			head.children << title
			t.children << head
			expect(t.to_s).to eq("<html id=\"root\" class=\"foo bar baz\"><head><title>Hello World!</title></head></html>")
		end
	end

	describe '#closing_tag?' do
		it 'returns true if the given string is the closing tag for the element' do
			expect(t.closing_tag?('</html>')).to eq(true)
		end

		it 'returns false if the given string is not the closing tag for the element' do
			expect(t.closing_tag?('</head>')).to eq(false)
		end
	end

	describe '#self_closing?' do
		it 'returns false if the tag is not self closing' do
			expect(t.self_closing?).to eq(false)
		end

		it 'returns true if the tag is self closing' do
			expect(Tag.new('img').self_closing?).to eq(true)
		end
	end

	describe '#create_attributes_from' do
		it 'returns a hash of attributes from the given string' do
			str = 'id="foo" class="foo bar baz"'
			expect(Tag.create_attributes_from(str)).to eq({:id=>"foo", :class=>"foo bar baz"})
		end
	end

	describe '#create_tag_from' do
		it 'returns a tag struct from the given match data' do
			matches = '<br>'.match(SELF_CLOSING_TAG)
			expect(Tag.create_tag_from(matches)).to be_an_instance_of(Tag)
		end
	end
end



