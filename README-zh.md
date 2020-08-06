![preview](doc/preview.png)

语言: [English](README.md)|[简体中文](README-zh.md)
# convex_bottom_bar

[![Pub](https://img.shields.io/pub/v/convex_bottom_bar.svg)](https://pub.dartlang.org/packages/convex_bottom_bar)
[![github](https://img.shields.io/badge/platform-flutter-ff69b4.svg)](https://github.com/hacktons/convex_bottom_bar)
[![Codemagic build status](https://api.codemagic.io/apps/5db10f597d3edb001a6ede16/5db10f597d3edb001a6ede15/status_badge.svg)](https://codemagic.io/apps/5db10f597d3edb001a6ede16/5db10f597d3edb001a6ede15/latest_build)
[![Coverage Status](https://coveralls.io/repos/github/hacktons/convex_bottom_bar/badge.svg)](https://coveralls.io/github/hacktons/convex_bottom_bar)

<a href="https://flutter.dev/docs/development/packages-and-plugins/favorites">
<img height="128" src="https://github.com/hacktons/convex_bottom_bar/raw/master/doc/flutter-favorite.png">
</a>

**convex_bottom_bar 现在是一个 [Flutter Favorite](https://flutter.dev/docs/development/packages-and-plugins/favorites) 插件库!**

官方的BottomAppBar只能显示带有凹形FAB的导航栏，有时我们需要凸形FAB。 ConvexAppBar的开发受BottomAppBar和NotchShape的实现启发。

可以在[https://appbar.codemagic.app](https://appbar.codemagic.app)上找到在线示例。

以下是一些支持的预定义样式：
|            **fixed**             |            **react**             |
| :------------------------------: | :------------------------------: |
|    ![](doc/appbar-fixed.gif)     |    ![](doc/appbar-react.gif)     |
|         **fixedCircle**          |         **reactCircle**       |
| ![](doc/appbar-fixed-circle.gif) | ![](doc/appbar-react-circle.gif) |
|            **flip**              |          **titled**          |
|       ![](doc/appbar-flip.gif)   |    ![](doc/appbar-titled.gif)    |
|            **textIn**            |   **tab image**          |
| ![](doc/appbar-textIn.gif)  |    ![](doc/appbar-image.gif)    |
|      **gradient backgound**    |      **badge chip**         |
|   ![](doc/appbar-gradient.gif)   |    ![](doc/appbar-badge.gif)    |


## 快速上手

通常ConvexAppBar可以通过设置bottomNavigationBar与Scaffold一起使用。

ConvexAppBar具有两个构造函数，ConvexAppBar()将使用默认样式来简化选项卡的创建。

将此添加到您程序包的pubspec.yaml文件中，注意使用最新版本[![Pub](https://img.shields.io/pub/v/convex_bottom_bar.svg)](https://pub.dartlang.org/packages/convex_bottom_bar):

```yaml
dependencies:
  convex_bottom_bar: ^latest_version
```

```dart
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

Scaffold(
  bottomNavigationBar: ConvexAppBar(
    items: [
      TabItem(icon: Icons.home, title: 'Home'),
      TabItem(icon: Icons.map, title: 'Discovery'),
      TabItem(icon: Icons.add, title: 'Add'),
      TabItem(icon: Icons.message, title: 'Message'),
      TabItem(icon: Icons.people, title: 'Profile'),
    ],
    initialActiveIndex: 2,//optional, default as 0
    onTap: (int i) => print('click index=$i'),
  )
);
```

如果你只需要一个单独的按钮，不妨试试 `ConvexButton`.

![button](https://github.com/hacktons/convex_bottom_bar/raw/stable/doc/appbar-single-shape.png)

```dart
Scaffold(
  appBar: AppBar(title: const Text('ConvexButton Example')),
  body: Center(child: Text('count $count')),
  bottomNavigationBar: ConvexButton.fab(
    onTap: () => setState(() => count++),
  ),
);
```

## 功能

* 提供多种内部样式
* 能够更改AppBar的主题
* 提供Builder API以自定义新样式
* 在AppBar上添加徽章
* 支持优雅的过渡动画
* 提供Hook API来重载一些内部样式
* RTL布局支持

## Table of contents

- [角标](#角标)

- [主题](#主题)

- [自定义样例](#自定义样例)

- [样式重载](#样式重载)

- [RTL支持](#RTL支持)

- [常见问题](#常见问题)

- [贡献](#贡献)

## 角标
如果需要在TAB上添加徽章/角标，请使用`ConvexAppBar.badge`来构建。
[![badge demo](doc/badge-demo-preview.gif)](doc/badge-demo.mp4 "badge demo")

```dart
ConvexAppBar.badge({0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},
  items: [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(icon: Icons.add, title: 'Add'),
  ],
  onTap: (int i) => print('click index=$i'),
);
```

`badge()`方法接受一个角标数组； 角标是带有选项卡项的映射，每个条目的值可以是String，IconData，Color或Widget。

## 主题
AppBar默认使用内置样式，您可能需要为其设置主题。 以下是一些支持的属性：

![](doc/appbar-theming.png)

| Attributes      | Description                           |
| --------------- | ------------------------------------- |
| backgroundColor | AppBar 背景                     |
| gradient        | 渐变属性，可以覆盖backgroundColor|
| height          | AppBar 高度                         |
| color           | icon/text 的颜色值                   |
| activeColor     | icon/text 的**选中态**颜色值 |
| curveSize       | 凸形大小             |
| top   | 凸形到AppBar上边缘的距离 |
| style | 支持的样式: **fixed, fixedCircle, react, reactCircle**, ... |
| chipBuilder | 角标构造器builder,  **ConvexAppBar.badge**会使用默认样式 |

![](doc/appbar-demo.gif)

## 自定义样例

如果默认样式与您的情况不符，请尝试使用`ConvexAppBar.builder()`，它可以让您自定义几乎所有TAB样式。
```dart
Scaffold(
  bottomNavigationBar: ConvexAppBar.builder(
    count: 5,
    backgroundColor: Colors.blue,
    style: TabStyle.fixed,
    itemBuilder: Builder(),
  )
);

/*user defined class*/
class Builder extends DelegateBuilder {
  @override
  Widget build(BuildContext context, int index, bool active) {
    return Text('TAB $index');
  }
}
```

完整的自定义示例可以在[example](example)中找到。

## 样式重载
重载Tab内置样式。 该API与`ConvexAppBar.builder`不同，为了满足您可能需要更新选项卡样式而不定义新的选项卡样式。
**温馨提示:**  
则此Hook能力是有限的，如果您提供的尺寸与内部样式不匹配，并且可能导致`overflow broken`。

```dart
StyleProvider(
  style: Style(),
  child: ConvexAppBar(
    initialActiveIndex: 1,
    height: 50,
    top: -30,
    curveSize: 100,
    style: TabStyle.fixedCircle,
    items: [
      TabItem(icon: Icons.link),
      TabItem(icon: Icons.import_contacts),
      TabItem(title: "2020", icon: Icons.work),
    ],
    backgroundColor: _tabBackgroundColor,
  ),
)
class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 20, color: color);
  }
}
```

## RTL支持
RTL的内部适配，如果你配置了Directionality，将自动支持ltf和rtl两种布局风格。
```dart
Directionality(
  textDirection: TextDirection.rtl,
  child: Scaffold(body:ConvexAppBar(/*TODO ...*/)),
)
```
## 常见问题

* [动态修改选中的TAB](doc/issue-change-active-tab-index.md)
* [如何给TAB添加图片而不是ICON](doc/issue-image-for-actionitem.md)
* [如何移除AppBar的边缘阴影](doc/issue-remove-elevation.md) 

## 贡献
如您在使用过程中有新功能建议或者遇到问题，请移步至[issue tracker](https://github.com/hacktons/convex_bottom_bar/issues)提交。