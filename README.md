# epubinfo [![Continuous Integration](https://secure.travis-ci.org/chdorner/epubinfo.png?branch=master)](http://travis-ci.org/chdorner/epubinfo) [![Dependencies](https://gemnasium.com/chdorner/epubinfo.png)](http://gemnasium.com/chdorner/epubinfo)

Extracts metadata information from EPUB files. Supports EPUB2 and EPUB3 formats.

## Usage

```ruby
require 'epubinfo'
EPUBInfo.get('path/to/epub/file.epub')
```

Which returns a `EPUBInfo::Models::Book` instance, please refer to the [API documentation](http://rubydoc.info/gems/epubinfo/frames) from here on

## Changelog

**0.4.0** *July 31, 2012*

* Added Book#cover method for extracting covers from epubs

**0.3.6** *June 18, 2012*

* Upgraded rubyzip dependency to version 0.9.9 for more robust zip handling

**0.3.5** *June 17, 2012*

* Reading out path of root document is more robust (removing XML namespaces)

**0.3.4** *June 1, 2012*

* Default value for titles (empty array)
* Code refactorings

*For older versions compare commits with git.*

## Contributing to epubinfo
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Christof Dorner. See LICENSE.txt for
further details.

