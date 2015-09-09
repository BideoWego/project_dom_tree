require 'spec_helper'

describe 'HTML regexes' do
	describe 'DOCTYPE' do
		it 'matches an HTML5 doctype' do
			expect('<!DOCTYPE html>'.match(DOCTYPE)).to_not eq(nil)
		end
	end

	describe 'ROOT' do
		it 'matches the document root' do
			expect('<html><head><title>Hello</title></head><body></body></html>'.match(ROOT)).to_not eq(nil)
		end
	end

	describe 'ROOT_OPENING' do
		it 'matches the open tag of the HTML root' do
			expect('<html>'.match(ROOT_OPENING)).to_not eq(nil)
		end
	end

	describe 'ROOT_CLOSING' do
		it 'matches the close tag of the HTML root' do
			expect('</html>'.match(ROOT_CLOSING)).to_not eq(nil)
		end
	end

	describe 'ANGLE_BRACKETS' do
		it 'matches anything in angle brackets' do
			expect('<anything>'.match(ANGLE_BRACKETS)).to_not eq(nil)
		end
	end

	describe 'ATTRIBUTE' do
		it 'matches a single HTML element attribute' do
			expect('class="foo bar baz"'.match(ATTRIBUTE)).to_not eq(nil)
		end
	end

	describe 'OPENING_TAG' do
		it 'matches any opening tag' do
			expect('<h1>'.match(OPENING_TAG)).to_not eq(nil)
		end
	end

	describe 'CLOSING_TAG' do
		it 'match any closing tag' do
			expect('</div>'.match(CLOSING_TAG)).to_not eq(nil)
		end
	end

	describe 'TAG' do
		it 'matches any tag that opens and closes on the same line' do
			expect('<p>Hello</p>'.match(TAG)).to_not eq(nil)
		end
	end

	describe 'SELF_CLOSING_TAG' do
		it 'matches any self closing tag' do
			expect('<br/>'.match(SELF_CLOSING_TAG)).to_not eq(nil)
		end
	end
end