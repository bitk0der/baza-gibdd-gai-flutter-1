import 'dart:convert';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UiUtil {
  static String getlogoUrl(String url) {
    Uri uri = Uri.parse(url);
    String? imageParam = uri.queryParameters['image'];
    if (imageParam != null) {
      return utf8.decode(base64.decode(imageParam));
    } else {
      return url;
    }
  }

  static bool isDatePassed(String dateStr, [DateTime? comparisonDate]) {
    // Преобразуем строку в объект DateTime
    DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateTime inputDate = dateFormat.parse(dateStr);

    // Получаем текущую дату
    DateTime currentDate = comparisonDate ?? DateTime.now();

    if (comparisonDate != null) {
      return inputDate.isAfter(currentDate);
    }
    return inputDate.isBefore(currentDate);
  }

  static final phoneFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  static final birthdayFormatter = MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  static final passportFormatter = MaskTextInputFormatter(
      mask: '## ## ######', filter: {"#": RegExp(r'[0-9]')});
  static final vyFormatter = MaskTextInputFormatter(
      mask: '##** ######',
      filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[0-9А-Яа-я]')});
  static final snilsFormatter = MaskTextInputFormatter(
      mask: '###-###-### ##', filter: {"#": RegExp(r'[0-9]')});
  static final internationalPassportFormatter = MaskTextInputFormatter(
      mask: '## #######', filter: {"#": RegExp(r'[0-9]')});
  static final stsFormatter = MaskTextInputFormatter(
    mask: '## ** ######',
    filter: {
      "#": RegExp(r'[0-9]'),
      "*": RegExp(r'[0-9укенхваросмтУКЕНХВАРОСМТ]'),
    },
  );

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

  static String generateYearPlural(int count) {
    return (count % 10 == 1 && count != 11)
        ? "год"
        : (count % 10 >= 2 &&
                count % 10 <= 4 &&
                !(count % 100 >= 12 && count % 100 <= 14))
            ? "года"
            : "лет";
  }

  static String? Function(String?) getSimpleValidator(String? regExp) {
    return (value) {
      // Фамилия, имя, отчество, регион (только буквы)
      if (value == null || value.isEmpty) {
        return "*обязательное поле для заполнения";
      }
      if (!RegExp(regExp ?? r'^[А-Яа-яЁё\s\-]+$').hasMatch(value)) {
        return getErrorText(regExp);
      }
      return null;
    };
  }

  static List<String> checkPatentRegExp = [
    r'^(Патент|Разрешение на работу)$',
    r'^\d{1,2}$',
    r'^.{1,11}$',
    r'^[А-Я]{1,2}$',
    r'^.{1,11}$',
    r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$',
    r'[0-9A-Za-zА-Яа-яЁё]+',
  ];

  static List<String> checkDepartRegExp = [
    r'[a-zA-Z-\s]',
    r'[a-zA-Z-\s]',
    r'[0-9A-Za-zА-Яа-яЁё]+',
    r'[0-9A-Za-zА-Яа-яЁё]+',
    r'[0-9A-Za-zА-Яа-яЁё]+',
    r'^(Мужской|Женский)$',
    r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$',
    '',
  ];

  static List<String> checkFaceRegExp = [
    r'^.{4,}$',
    r'^\d{4}$',
    r'^\d{2}$',
    r'^\d{2}$',
    r'^.{4,}$',
    r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$',
  ];

  static String getErrorText(String? regExp) {
    if (regExp == r'^\d{1,2}$') return "Допустимы цифры не более 2";
    if (regExp == r'^[А-Я]{1,2}$') {
      return "Только русские заглавные буквы (1-2 символа)";
    }
    if (regExp == r'^.{1,11}$') return "Длина от 1 до 11 символов";
    if (regExp == '[0-9A-Za-zА-Яа-яЁё]+') {
      return "Буквы и цифры (русские или латинские)";
    }
    if (regExp == r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$') {
      return "Введена неккоректная дата";
    }
    if (regExp == r'^.{4,}$') {
      return "Минимум 4 символа";
    }
    if (regExp == r'^\d{2}$') {
      return "2 цифры";
    }
    if (regExp == r'^\d{4}$') {
      return "4 цифры";
    }
    return "Допустимы только буквы";
  }

  static String getNegativeResultTitle(
      bool? typeCheck, String? workPermission) {
    switch (typeCheck) {
      case true:
        return 'Находится в реестре контролируемых лиц';
      case false:
        return 'Обнаружены основания, препятствующих въезду на территорию РФ, по линии МВД России';
      case null:
        return '${workPermission ?? 'Патент'} с введенными реквизитами не найден в базе данных МВД России';
    }
  }

  static String getPositiveResultTitle(
      bool? typeCheck, String? workPermission) {
    switch (typeCheck) {
      case true:
        return 'Отсутствует в реестре контролируемых лиц';
      case false:
        return 'Оснований, препятствующих въезду на территорию РФ, по линии МВД России на данный момент не обнаружено';
      case null:
        return '${workPermission ?? 'Патент'} с введенными реквизитами найден в базе данных МВД России';
    }
  }

  static Color docTypeColor(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.taxes:
        return ColorStyles.docTypesColors[0];
      case SubscriptionType.trials:
        return ColorStyles.docTypesColors[1];
      case SubscriptionType.fsspTrials:
        return ColorStyles.docTypesColors[1];
      default:
        return ColorStyles.docTypesColors[2];
    }
  }

  static String generateFullName(UserData userData) {
    String result = '${userData.lastName} ${userData.firstName}';
    if (userData.secondName != null && userData.secondName!.isNotEmpty) {
      result += ' ${userData.secondName!}';
    }
    return result;
  }

  static String docTypeString(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.taxes:
        return "ФНС";
      case SubscriptionType.trials:
        return "ФССП";
      case SubscriptionType.fsspTrials:
        return "ФССП";
      default:
        return "ГИБДД задолженности";
    }
  }

  static bool checkDate(String dateStr) {
    try {
      // Пытаемся распарсить строку в формат "дд.мм.гггг"
      DateFormat dateFormat = DateFormat('dd.MM.yyyy');
      dateFormat
          .parseStrict(dateStr); // Используем parseStrict для строгой проверки
      return true; // Если строка корректна, возвращаем true
    } catch (e) {
      return false; // Если ошибка при разборе строки, значит, дата некорректна
    }
  }

  static String generatePaymentPlural(int count) {
    return (count % 10 == 1 && count % 100 != 11)
        ? "начисление"
        : (count % 10 >= 2 &&
                count % 10 <= 4 &&
                (count % 100 < 10 || count % 100 >= 20))
            ? "начисления"
            : "начислений";
  }

  static String invoicesCountPlural(int count) {
    return (count % 10 == 1 && count % 100 != 11)
        ? "задолженность"
        : (count % 10 >= 2 &&
                count % 10 <= 4 &&
                (count % 100 < 10 || count % 100 >= 20))
            ? "задолженности"
            : "задолженностей";
  }

/*   static String generateFullName(UserData userData) {
    String result = '${userData.lastName} ${userData.firstName}';
    if (userData.secondName != null && userData.secondName!.isNotEmpty)
      result += ' ' + userData.secondName!;
    return result;
  } */

  static String formatDate(DateTime date) {
    String day;
    String month;
    String year = date.year.toString();
    if (date.day < 10) {
      day = "0${date.day}";
    } else {
      day = "${date.day}";
    }
    if (date.month < 10) {
      month = "0${date.month}";
    } else {
      month = "${date.month}";
    }
    return "$day.$month.$year";
  }

  static String prepareSum(double sum) {
    String result = "";
    if (sum % 1 == 0) {
      result = sum.toStringAsFixed(0);
    } else {
      result = sum.toStringAsFixed(2);
    }
    result = result.replaceAll(".", ",");
    return "$result ₽";
  }

  static String formatSts(String text) {
    if (checkSts(text)) {
      return text;
    } else {
      try {
        final textWithoutSpaces = text.replaceAll(" ", "");
        return "${textWithoutSpaces.substring(0, 2)} ${textWithoutSpaces.substring(2, 4)} ${textWithoutSpaces.substring(4)}";
      } catch (e) {
        Logger().e(e);
        return text;
      }
    }
  }

  static String formatVy(String text) {
    if (checkVy(text)) {
      return text;
    } else {
      try {
        final textWithoutSpaces = text.replaceAll(" ", "");
        return "${textWithoutSpaces.substring(0, 4)} ${textWithoutSpaces.substring(4)}";
      } catch (e) {
        Logger().e(e);
        return text;
      }
    }
  }

  static String formatPasport(String text) {
    if (checkPasport(text)) {
      return text;
    } else {
      try {
        final textWithoutSpaces = text.replaceAll(" ", "");
        return "${textWithoutSpaces.substring(0, 2)} ${textWithoutSpaces.substring(2, 4)} ${textWithoutSpaces.substring(4)}";
      } catch (e) {
        Logger().e(e);
        return text;
      }
    }
  }

  static String formatSnils(String text) {
    if (checkSnils(text)) {
      return text;
    } else {
      try {
        String textWithoutSpaces = text.replaceAll(" ", "");
        textWithoutSpaces = textWithoutSpaces.replaceAll("-", "");
        return "${textWithoutSpaces.substring(0, 3)}-${textWithoutSpaces.substring(3, 6)}-${textWithoutSpaces.substring(6, 9)} ${textWithoutSpaces.substring(9)}";
      } catch (e) {
        Logger().e(e);
        return text;
      }
    }
  }

  static bool checkSts(String text) {
    return RegExp(r"\d{2} [\dукенхваросмтУКЕНХВАРОСМТ]{2} \d{6}$")
        .hasMatch(text);
  }

  static bool checkVy(String text) {
    return RegExp(r"^\d{2}[\dА-Яа-я]{2}\s\d{6}$").hasMatch(text);
  }

  static bool checkSnils(String text) {
    return RegExp(r"^\d{3}-\d{3}-\d{3}\s\d{2}$").hasMatch(text);
  }

  static bool checkInn(String text) {
    return RegExp(r"^\d{10,12}$").hasMatch(text);
  }

  static bool checkPasport(String text) {
    return RegExp(r"^\d{2}\s\d{2}\s\d{6}$").hasMatch(text);
  }

  static bool checkInternationalPassport(String text) {
    return RegExp(r"^\d{2}\s\d{7}$").hasMatch(text);
  }

  static bool checkBirthCertificate(String text) {
    return RegExp(r"^[I,V,X]{1,3}[А-Я]{2}\d{6}$").hasMatch(text);
  }

  static bool checkPhone(String text) {
    return RegExp(r"^\+7\s\(\d{3}\)\s\d{3}-\d{2}-\d{2}$").hasMatch(text);
  }

  static String translit(String text) {
    String result = "";
    for (int i = 0; i < text.length; i++) {
      switch (text[i].toUpperCase()) {
        case ("A"):
          result += "А";
          break;
        case ("B"):
          result += "В";
          break;
        case ("E"):
          result += "Е";
          break;
        case ("K"):
          result += "К";
          break;
        case ("M"):
          result += "М";
          break;
        case ("H"):
          result += "Н";
          break;
        case ("O"):
          result += "О";
          break;
        case ("P"):
          result += "Р";
          break;
        case ("C"):
          result += "С";
          break;
        case ("T"):
          result += "Т";
          break;
        case ("Y"):
          result += "У";
          break;
        case ("X"):
          result += "Х";
          break;
        default:
          result += text[i].toUpperCase();
      }
    }
    return result;
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
