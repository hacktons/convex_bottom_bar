---
name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

## Notice for Stack compile error
```
* Replace all Stack.overflow to Stack.clipBehavior. 
* The removal of [Stack.overflow][https://api.flutter.dev/flutter/widgets/Stack/overflow.html] is not a good idea, and the Flutter team has noticed that it would take time to remove all the usage without breaking Google.
Since the overflow has been removed in 1.20 and be rolled back now(perhaps 1.22? not for sure). It's hard to say when it will be removed again, so just replace all overflow with clipBehavior.
```
---

> Please search the [issue list](https://github.com/hacktons/convex_bottom_bar/issues) and [FAQ list](https://github.com/hacktons/convex_bottom_bar#faq) before opening any issues!!

**Describe the bug**

A clear and concise description of what the bug is.

**Environment details**

Paste the flutter environment detail.
```
flutter doctor
flutter --version
```
Paste the package version.
```
dependencies:
  convex_bottom_bar: x.y.z
```

**To Reproduce**

Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**

A clear and concise description of what you expected to happen.

**Screenshots**

If applicable, add screenshots to help explain your problem.

**Additional context**

Add any other context about the problem here.
