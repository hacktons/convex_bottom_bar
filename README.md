# convex_bottom_bar

This package extends the official BottomAppBar to display a convex tab, example can be preview as bellow.

> Currently the BottomApp can only display a notch FAB with app bar, sometimes we need a convex FAB.

![Screenshot](doc/Screenshot_1571041912.png)

## How to use
Follow the steps to setup `Scaffold` with custom attributes:
1. add FAB with `floatingActionButton`
2. center the FAB with `floatingActionButtonLocation`
3. setup App Bar by `bottomNavigationBar`

### Add FAB
Display the FAB as a Container which contains Icon & Label

```dart
floatingActionButton: GestureDetector(
  onTap: () => _onItemTapped(INDEX_PUBLISH),
  child: Container(
    width: 60,
    height: 80,
    padding: EdgeInsets.only(bottom: 2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(Icons.add, size: 50, color: convexColor),
        Text('Publish', style: TextStyle(color: convexColor)),
      ],
    ),
  ),
)
```
### Center the FAB
Make the FAB center in BottomApp

```dart
floatingActionButtonLocation: ExtendLocation.centerDocked,
```
### Setup App Bar

```dart
bottomNavigationBar: ConvexAppBar.builder(
  count: 5,
  builder: (BuildContext context, int index) {
    var data = _navigationItems[index];
    var color = _selected == index ? Colors.red : Colors.black;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
        child: Container(
           height: 50,
           padding: EdgeInsets.only(bottom: 2),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               Icon(data.icon, color: color),
               Text(data.title, style: TextStyle(color: color))
             ],
           )));
    }),
```

## Example
For more detail, please refer to the [example](example) project

## Help

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
