## [2.4.0]
* Support flutter v1.20, the v2.2.4-flutter-1.20 is now sync with v2.4.0.
* Add new feature. We can now add corner on AppBars's background.

## [2.3.0]
* Add convex button widget.

## [2.2.5+1]

* fix format issue.
```
lib/src/bar.dart is not formatted according to dartfmt
To format your files run: dartfmt -w .
```

## [2.2.5]

* Bug fix [#67](https://github.com/hacktons/convex_bottom_bar/issues/67)

## [2.2.4-flutter-1.20]
* support the flutter v1.20
* fix: overflow property of stack deprecated [#60](https://github.com/hacktons/convex_bottom_bar/pull/60)

## [2.2.4]
* Polish internal style, avoid reanimate when AppBar rebuild.

## [2.2.3]

* Bug fix [#59](https://github.com/hacktons/convex_bottom_bar/issues/59)
* Bug fix: default index not match with DefaultTabController.

## [2.2.2]
* Fix activate index when appbar is not working with controller;
* Dispose AnimationController when is dirty;

## [2.2.1]
* Support RTL;

## [2.2.0]

* Add new API to hook internal styles. Checkout `StyleProvider` for details;
* Provide configuration to hide Text widget when label is empty;

## [2.1.1]

* Fix ChipBuilder missing issue;
* Polish ci test;

## [2.1.0+1]

* Document all the public APIs;
 
## [2.1.0]

* Add controller for Appbar to change tab index programmaticlly;
* Support with framework's DefaultTabController and TabController;
* Enable access to the ConvexAppBarState;
* Fix active tab position when using even menus;

## [2.0.3]

* Fix hitTest for active tab;

## [2.0.2]

* Add new config parameter for initial active index;

## [2.0.1]

* Update usage instructions in README.md；
* Add new test cases to improve the code coverage;
* Bug fix;

## [2.0.0]

* Support badge on tab item;
* Constructor update, rename the builder;
* Bug fix;

## [1.4.1]

* Add titled style;
* Remove some redundant widget layers;

## [1.4.0]

* Add flip style;
* Add textIn style;

## [1.3.1+1]

* Bug fix: activate icon is not working in some style;
* Improvement: enable image with/without color blend;
 
## [1.3.1]

* Support gradient background;
* Tab item are generic type, both `IconData` and `Widget` can be used;

## [1.3.0]

* Add new tab style;
* Support animated tab transition；

## [1.2.0]

* Support iPhoneX' safe area at bottom edge. [#issues/7](https://github.com/hacktons/convex_bottom_bar/issues/7)

## [1.1.0]

* Add elevation attribute.

## [1.0.2+1]

* Documentation fixes.

## [1.0.2]

* Fix maintenance suggestions to get higher score

## [0.0.1]

* Publish the packages to pub.dev

