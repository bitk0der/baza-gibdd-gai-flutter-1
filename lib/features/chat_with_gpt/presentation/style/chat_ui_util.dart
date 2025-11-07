import 'package:flutter/services.dart';

class ChatUiUtil {
  static String monthName(int number) {
    switch (number) {
      case 1:
        return "Январь";
      case 2:
        return "Февраль";
      case 3:
        return "Март";
      case 4:
        return "Апрель";
      case 5:
        return "Май";
      case 6:
        return "Июнь";
      case 7:
        return "Июль";
      case 8:
        return "Август";
      case 9:
        return "Сентябрь";
      case 10:
        return "Октябрь";
      case 11:
        return "Ноябрь";
      case 12:
        return "Декабрь";
      default:
        return "";
    }
  }

  static String generateYearPlural(int count) {
    return (count % 10 == 1 && count != 11)
        ? "год"
        : (count % 10 >= 2 &&
                count % 10 <= 4 &&
                !(count % 100 >= 12 && count % 100 <= 14))
            ? "года"
            : "лет";
  }

  static String prepareNumber(String number) {
    if (number.length > 3 && number.length < 7) {
      return "${number.substring(0, number.length - 3)} ${number.substring(number.length - 3)}";
    } else if (number.length >= 7 && number.length < 10) {
      return "${number.substring(0, number.length - 6)} ${number.substring(number.length - 6, number.length - 3)} ${number.substring(number.length - 3)}";
    } else if (number.length >= 10) {
      return "${number.substring(0, number.length - 9)} ${number.substring(number.length - 9, number.length - 6)} ${number.substring(number.length - 6, number.length - 3)} ${number.substring(number.length - 3)}";
    }
    return number;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class FloatingPointNumberTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    if (newValue.text.replaceFirst(".", "").contains(".")) {
      return oldValue;
    }
    String result = newValue.text.replaceAll(",", '.');
    result = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    if (result.length == 2 && !result.contains(".")) {
      return TextEditingValue(
        text: "$result.",
        selection: TextSelection(
          baseOffset: newValue.selection.baseOffset + 1 < result.length + 1
              ? newValue.selection.baseOffset + 1
              : result.length + 1,
          extentOffset: newValue.selection.extentOffset + 1 < result.length + 1
              ? newValue.selection.extentOffset + 1
              : result.length + 1,
        ),
      );
    }
    return TextEditingValue(
      text: result,
      selection: TextSelection(
        baseOffset: newValue.selection.baseOffset < result.length
            ? newValue.selection.baseOffset
            : result.length,
        extentOffset: newValue.selection.extentOffset < result.length
            ? newValue.selection.extentOffset
            : result.length,
      ),
    );
  }
}

class LongNumberTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
      );
    }
    String number = newValue.text.replaceAll(RegExp(r'[^\d]'), "");
    String text = newValue.text;
    int offset = newValue.selection.baseOffset;
    if (number.length < 10) {
      if (number.length > 3 && number.length < 7) {
        text =
            "${number.substring(0, number.length - 3)} ${number.substring(number.length - 3)}";
        if (offset == newValue.text.length) offset++;
      } else if (number.length >= 7 && number.length < 10) {
        text =
            "${number.substring(0, number.length - 6)} ${number.substring(number.length - 6, number.length - 3)} ${number.substring(number.length - 3)}";
        if (offset == newValue.text.length) offset++;
      }
    }
    if (offset >= text.length) offset = text.length;
    return TextEditingValue(
      text: text,
      selection: TextSelection(
        baseOffset: offset,
        extentOffset: offset,
      ),
    );
  }
}
