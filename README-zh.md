# convex_bottom_bar|[English](README.md)

`convex_bottom_bar`扩展包基于Flutter的BottomAppBar，实现了对凸起Tab的支持，预览效果如下图所示。

> 当前BottomAppBar默认的效果只能实现凹口的FAB，很多时候设计要求的是凸起F效果。

![Screenshot](doc/Screenshot_1571041912.png)

**安装Demo** [app-release.apk](doc/app-release.apk)

## 使用
执行以下步骤，完成对`Scaffold`的个性化配置：
1. 添加FAB按钮
2. 使FAB居中展示
3. 添加AppBar按钮

The `ConvexAppBar` 提供了两个构造器, 利用`ConvexAppBar()`将使用内置的TAB布局，这可以可以简化Tab创建。
 
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

### 自定义TAB
如果默认效果不满足你的需求，尝试用 `ConvexAppBar.builder()` 来自定义整个TAB的排版。

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

## 示例
完整代码请参考示例工程[example](example)。

## 帮助

查阅[Flutter在线文档](https://flutter.dev/docs)上手Flutter开发。
