/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
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

import 'package:flutter_test/flutter_test.dart';
import 'package:pana_html/pana_html.dart' as pana;

void main() {
  test('Test pana with strict mode', () async {
    var result = await pana.evaluate(['--no-web', '--strict']);
    expect(result != null, true);
    expect(result.success, true, reason: 'pana score < 100');
  }, timeout: Timeout(Duration(minutes: 10)));
}
