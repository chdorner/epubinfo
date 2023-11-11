# MOVED TO CODEBERG - [codeberg.org/chdorner/epubinfo](https://codeberg.org/chdorner/epubinfo)

# epubinfo [![Continuous Integration](https://secure.travis-ci.org/chdorner/epubinfo.png?branch=master)](http://travis-ci.org/chdorner/epubinfo)
Extracts metadata information from EPUB files. Supports EPUB2 and EPUB3 formats.

## Usage

```ruby
require 'epubinfo'
EPUBInfo.get('path/to/epub/file.epub')
```

Which returns a `EPUBInfo::Models::Book` instance, please refer to the [API documentation](http://rubydoc.info/gems/epubinfo/frames) from here on

## Changelog

**0.4.4** *October 20, 2014*

* Updated `rubyzip` dependency to 1.0. (by [johankok](https://github.com/johankok))

If you cannot upgrade to `rubyzip` 1.0, use version *0.4.3* of this gem in your project.

**0.4.3** *September 12, 2013*

* Made cover detection more robust by escaping the CSS selectors (by [versapub](https://github.com/versapub))

**0.4.2** *August 16, 2013*

* Improved cover detection for EPUB3 (by [takahashim](https://github.com/takahashim))
* Improved cover detection for EPUB2 (by [cyrret](https://github.com/cyrret))

**0.4.1** *February 15, 2013*

* Added Book#version to get EPUB version of the file (by [takahashim](https://github.com/takahashim))
* Added support for modified_date in Book#dates (by [takahashim](https://github.com/takahashim))

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

