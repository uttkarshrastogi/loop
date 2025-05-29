import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TempScreen extends StatelessWidget {
  static const routeName = '/TempScreen';
  final List<String> fontNames = [
    'Inter', 'Manrope', 'Poppins', 'Sora', 'Work Sans',
    'Lexend', 'Space Grotesk', 'Rubik', 'Raleway',
    'Nunito', 'Urbanist', 'DM Sans', 'Quicksand', 'Montserrat', 'Be Vietnam Pro'
  ];

   TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Font Playground")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: fontNames.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final fontName = fontNames[index];
          final font = getFont(fontName);

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fontName, style: font.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  "This is a heading using $fontName",
                  style: font.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  "This is a sample paragraph. We’re testing how $fontName handles large blocks of text in a clean and readable way.",
                  style: font.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Type here...',
                    labelStyle: font.copyWith(fontSize: 14),
                    border: const OutlineInputBorder(),
                  ),
                  style: font.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextStyle getFont(String fontName) {
    switch (fontName) {
      case 'Inter':
        return GoogleFonts.inter();
      case 'Manrope':
        return GoogleFonts.manrope();
      case 'Poppins':
        return GoogleFonts.poppins();
      case 'Sora':
        return GoogleFonts.sora();
      case 'Work Sans':
        return GoogleFonts.workSans();
      case 'Lexend':
        return GoogleFonts.lexend();
      case 'Space Grotesk':
        return GoogleFonts.spaceGrotesk();
      case 'Rubik':
        return GoogleFonts.rubik();
      case 'Raleway':
        return GoogleFonts.raleway();
      case 'Nunito':
        return GoogleFonts.nunito();
      case 'Urbanist':
        return GoogleFonts.urbanist();
      case 'DM Sans':
        return GoogleFonts.dmSans();
      case 'Quicksand':
        return GoogleFonts.quicksand();
      case 'Montserrat':
        return GoogleFonts.montserrat();
      case 'Be Vietnam Pro':
        return GoogleFonts.beVietnamPro();
      default:
        return GoogleFonts.inter(); // fallback
    }
  }
}
