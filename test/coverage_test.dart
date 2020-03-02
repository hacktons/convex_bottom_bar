import 'package:flutter_test/flutter_test.dart';
import 'package:pana_html/pana_html.dart' as pana;

void main(){
  test('Test pana with strict mode', () async {
    var result = await pana.evaluate(['--no-web', '--strict']);
    expect(result != null, true);
    expect(result.success, true, reason: 'pana score < 100');
  }, timeout: Timeout(Duration(minutes: 3)));

}