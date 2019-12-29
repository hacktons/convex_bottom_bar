// copy of _ChoiceValue from flutter gallery
class ChoiceValue<T> {
  const ChoiceValue({this.value, this.title, this.label});

  final T value;
  final String title;
  final String label; // For the Semantics widget that contains title

  @override
  String toString() => '$runtimeType("$title")';
}
