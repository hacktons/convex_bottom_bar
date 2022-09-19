/*
 *  Copyright 2020 chaobinwu89@gmail.com
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

// copy of _ChoiceValue from flutter gallery
class ChoiceValue<T> {
  const ChoiceValue(
      {required this.value, required this.title, required this.label});

  final T value;
  final String title;
  final String label; // For the Semantics widget that contains title

  @override
  String toString() => '$runtimeType("$title")';
}
