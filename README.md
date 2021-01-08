# Web Area

[![Language][swift-shield]][swift-url]
[![check][check-shield]][check-url]

![template](https://github.com/mesopelagique/form-detail-WebArea/raw/doc/template.gif)

## How to integrate

* To use a detail form template, the first thing you'll need to do is create a YourDatabase.4dbase/Resources/Mobile/form/detail folder.
* Then drop the detail form folder into it.

For instance

```bash
cd YourDatabase.4dbase/Resources/Mobile/form/detail
git clone https://github.com/mesopelagique/form-detail-WebArea.git WebArea
```

## How to use it

In project editor choose this template and drop a field which contains

* an absolute URL 
  * ex: `https://developer.4d.com/`
* or a relative URL to the 4d web server 
  * ex: `/4DAction/AnHTTPSharedMethod`
* or html string
  * ex: `<h1>Hello World</h1>`

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[swift-shield]: http://img.shields.io/badge/language-swift-orange.svg?style=flat
[swift-url]: https://developer.apple.com/swift/
[check-shield]: https://github.com/mesopelagique/form-detail-WebArea/workflows/%E2%9C%85%20check/badge.svg
[check-url]: https://github.com/mesopelagique/form-detail-WebArea/actions?query=workflow%3A%22%E2%9C%85+check%22
