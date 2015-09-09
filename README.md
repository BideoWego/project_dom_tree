# project_dom_tree
Like leaves on the wind

## Bideo Wego

### Usage

1. Make your way to IRB within the project root directory

	```
	$ cd to/this/directory
	$ irb
	```

1. Read the HTML file

	```ruby
	html = File.read('test.html')
	```

1. Pass the returned string to the `DOMReader`

	- NOTE: this will automatically build the tree from the string

	```ruby
	d = DOMReader.new(html)
	```

1. Want a quick way to verify the rendered output is the same as the HTML string?

	```ruby
	html.gsub(/\s/, '') == d.render.gsub(/\s/, '')
	```

1. Render the tree to a string

	```ruby
	puts d.render
	```

1. Search for nodes by `:element`, `:text`, or an attribute

	```ruby
	d.search_by(:element, 'html')
	d.search_by(:text, 'One h1')
	d.search_by(:id, 'main-area')
	d.search_by(:class, 'top-div')
	```

1. Search all the descendents of a node with `#search_children`

	```ruby
	d.search_children(d.root, :element, 'li')
	```

1. Search only direct children of a node with `#search_ancestors`

	```ruby
	d.search_ancestors(d.root, :element, 'head')
	```

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)
