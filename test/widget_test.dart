import 'package:flutter_test/flutter_test.dart';
import 'package:todolistapps/main.dart';

void main() {
  testWidgets('Aplikasi To-Do Mahasiswa smoke test', (WidgetTester tester) async {
    // Memuat aplikasi.
    await tester.pumpWidget(const MyApp());

    // Memverifikasi bahwa judul aplikasi muncul di layar.
    expect(find.text('📚 To-Do Mahasiswa'), findsOneWidget);

    // Memverifikasi bahwa navigasi bawah (navbar) muncul.
    expect(find.text('Home'), findsOneWidget);
  });
}
