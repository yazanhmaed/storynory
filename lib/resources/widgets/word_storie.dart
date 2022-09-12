import 'package:flutter/material.dart';

class WordSelect extends StatefulWidget {
  final String text;
  final Function(String word, int? index)? onWordTapped;
  final bool highlight;
  final Color? highlightColor;
  final String alphabets;
  final TextStyle? style;
  final TextDirection textDirection;
  final bool selectable;
  const WordSelect(
      {Key? key,
      required this.text,
      this.onWordTapped,
      this.highlight = true,
      this.highlightColor,
      this.alphabets = '[a-zA-Z]',
      this.style,
      this.selectable = true,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  @override
  _WordSelectState createState() => _WordSelectState();
}

class _WordSelectState extends State<WordSelect> {
  int? selectedWordIndex;
  Color? highlightColor;
  @override
  void initState() {
    selectedWordIndex = -1;
    if (widget.highlightColor == null) {
      highlightColor = Colors.pink.withOpacity(0.3);
    } else {
      highlightColor = widget.highlightColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> wordList = widget.text
        .replaceAll(RegExp(r'(\n)+'), "#")
        .trim()
        .split(RegExp(r'\s|(?<=#)'));
    return widget.selectable
        ? SelectableText.rich(
            TextSpan(
              children: [
                for (int i = 0; i < wordList.length; i++)
                  TextSpan(
                    children: [
                      TextSpan(
                        text: wordList[i].replaceAll("#", ""),
                        style: TextStyle(
                            backgroundColor:
                                selectedWordIndex == i && widget.highlight
                                    ? highlightColor
                                    : Colors.transparent),
                      ),
                      wordList[i].contains("#")
                          ? const TextSpan(text: "\n\n")
                          : const TextSpan(text: " "),
                    ],
                  )
                // generateSpans()
              ],
            ),
            style: widget.style ?? const TextStyle(),
            textDirection: widget.textDirection,
          )
        : Text.rich(
            TextSpan(
              children: [
                for (int i = 0; i < wordList.length; i++)
                  TextSpan(
                    children: [
                      TextSpan(
                        text: wordList[i].replaceAll("#", ""),
                        style: TextStyle(
                            backgroundColor:
                                selectedWordIndex == i && widget.highlight
                                    ? highlightColor
                                    : Colors.transparent),
                      ),
                      wordList[i].contains("#")
                          ? const TextSpan(text: "\n\n")
                          : const TextSpan(text: " "),
                    ],
                  )
                // generateSpans()
              ],
            ),
            style: widget.style ?? const TextStyle(),
            textDirection: widget.textDirection,
          );
  }
}
