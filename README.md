![preview](doc/preview.png)

# convex_bottom_bar|[中文](README-zh.md)

This package extends the official BottomAppBar to display a convex tab, example can be preview as bellow.

> Currently the BottomAppBar can only display a notch FAB with app bar, sometimes we need a convex FAB.

![Screenshot](doc/Screenshot_1571041912.png)

**Install Demo** [app-release.apk](doc/app-release.apk)

## How to use
To use ConvexAppBar, follow these steps to setup `Scaffold`:
1. add FAB with `floatingActionButton`
2. center the FAB with `floatingActionButtonLocation`
3. setup App Bar by `bottomNavigationBar`

The `ConvexAppBar` has to two constructors, the `ConvexAppBar()` will use default layout to simplify the tab creation.
 
```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Default ConvexAppBar'),
  ),
  body: Center(
    child: Text('TAB $_selectedIndex', style: TextStyle(fontSize: 20)),
  ),
  floatingActionButton: ConvexAppBar.fab(
    text: 'Publish',
    active: _selectedIndex == INDEX_PUBLISH,
    activeColor: ACTIVE_COLOR,
    color: NORMAL_COLOR,
    onTap: () => onTabSelected(INDEX_PUBLISH),
  ),
  floatingActionButtonLocation: ConvexAppBar.centerDocked,
  bottomNavigationBar: ConvexAppBar(
    items: TAB_ITEMS,
    index: _selectedIndex,
    activeColor: ACTIVE_COLOR,
    color: NORMAL_COLOR,
    onTap: onTabSelected,
  ),
)
```

### Custom
If the default style does not match with your situation， try with `ConvexAppBar.builder()`, which allow you to custom nearly all the tab features.

```dart
Scaffold(
  appBar: AppBar(title: const Text('Custom ConvexAppBar')),
  body: paletteBody(),
  floatingActionButton: GestureDetector(
    onTap: () => _onItemTapped(INDEX_PUBLISH),
    child: fabContent(convexColor),
  ),
  floatingActionButtonLocation: ConvexAppBar.centerDocked,
  bottomNavigationBar: ConvexAppBar.builder(
      count: 5,
      backgroundColor: _tabBackgroundColor,
      builder: (BuildContext context, int index) {
        var data = _navigationItems[index];
        var color = _currentIndex == index ? Colors.white : Colors.white60;
        return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: tabContent(data, color));
      }),
);
```

## Example
For more detail, please refer to the [example](example) project

## Help

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
