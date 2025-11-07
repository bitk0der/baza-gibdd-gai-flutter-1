class UserData {
  final String? passport;
  final String? vy;
  final String? sts;
  final String? snils;
  final String? inn;
  final String? uin;
  final String? birthCertificate;
  final String? internationalPassport;
  final String? firstName;
  final String? secondName;
  final String? lastName;
  final String? birthday;
  final String? region;
  final String? patentNumber;
  final String? blankNumber;
  final String? datePatentBirth;
  final String? registrationDate;
  final String? registrationExpiredDate;
  final String? registrationAdress;
  final String? datePasportBirth;
  final String? sex;
  final String? citizen;
  final String? countryEmitent;
  final String? numberMedicialBook;
  final String? medicialBookExpiredDate;
  final String? medicialBookDate;
  final String? gosNumber;
  //
  final String? firstLatName;
  final String? lastLatName;
  final String? internationalPassportDateBirth;
  //wp - work permit
  final String? wpNumber;
  final String? wpblankNumber;
  final String? wpDateBirth;

  UserData(
      {this.passport,
      this.vy,
      this.sts,
      this.snils,
      this.inn,
      this.birthCertificate,
      this.internationalPassport,
      this.firstName,
      this.secondName,
      this.lastName,
      this.birthday,
      this.region,
      this.uin,
      this.patentNumber,
      this.blankNumber,
      this.datePatentBirth,
      this.registrationDate,
      this.registrationExpiredDate,
      this.registrationAdress,
      this.datePasportBirth,
      this.sex,
      this.citizen,
      this.countryEmitent,
      this.numberMedicialBook,
      this.medicialBookExpiredDate,
      this.medicialBookDate,
      this.gosNumber,
      this.firstLatName,
      this.lastLatName,
      this.wpDateBirth,
      this.wpNumber,
      this.wpblankNumber,
      this.internationalPassportDateBirth});

  // Дополняем метод toString
  @override
  String toString() {
    String result = '';
    result += passport ?? '';
    result += '@';
    result += vy ?? '';
    result += '@';
    result += sts ?? '';
    result += '@';
    result += snils ?? '';
    result += '@';
    result += inn ?? '';
    result += '@';
    result += birthCertificate ?? '';
    result += '@';
    result += internationalPassport ?? '';
    result += '@';
    result += firstName ?? '';
    result += '@';
    result += secondName ?? '';
    result += '@';
    result += lastName ?? '';
    result += '@';
    result += birthday ?? '';
    result += '@';
    result += region ?? '';
    result += '@';
    result += uin ?? '';
    result += '@';
    result += patentNumber ?? '';
    result += '@';
    result += blankNumber ?? '';
    result += '@';
    result += datePatentBirth ?? '';
    result += '@';
    result += registrationDate ?? '';
    result += '@';
    result += registrationExpiredDate ?? '';
    result += '@';
    result += registrationAdress ?? '';
    result += '@';
    result += datePasportBirth ?? '';
    result += '@';
    result += sex ?? '';
    result += '@';
    result += citizen ?? '';
    result += '@';
    result += countryEmitent ?? '';
    result += '@';
    result += numberMedicialBook ?? '';
    result += '@';
    result += medicialBookExpiredDate ?? '';
    result += '@';
    result += medicialBookDate ?? '';
    result += '@';
    result += gosNumber ?? '';
    result += '@';
    result += firstLatName ?? '';
    result += '@';
    result += lastLatName ?? '';
    result += '@';
    result += internationalPassportDateBirth ?? ''; // Новое поле
    result += '@';
    result += wpNumber ?? ''; // Новое поле
    result += '@';
    result += wpblankNumber ?? ''; // Новое поле
    result += '@';
    result += wpDateBirth ?? ''; // Новое поле
    return result;
  }

  // Обновленный fromString метод
  static UserData fromString(String string) {
    final splited = string.split('@');
    return UserData(
      passport: splited.isNotEmpty ? splited[0] : null,
      vy: splited.length > 1 ? splited[1] : null,
      sts: splited.length > 2 ? splited[2] : null,
      snils: splited.length > 3 ? splited[3] : null,
      inn: splited.length > 4 ? splited[4] : null,
      birthCertificate: splited.length > 5 ? splited[5] : null,
      internationalPassport: splited.length > 6 ? splited[6] : null,
      firstName: splited.length > 7 ? splited[7] : null,
      secondName: splited.length > 8 ? splited[8] : null,
      lastName: splited.length > 9 ? splited[9] : null,
      birthday: splited.length > 10 ? splited[10] : null,
      region: splited.length > 11 ? splited[11] : null,
      uin: splited.length > 12 ? splited[12] : null,
      patentNumber: splited.length > 13 ? splited[13] : null,
      blankNumber: splited.length > 14 ? splited[14] : null,
      datePatentBirth: splited.length > 15 ? splited[15] : null,
      registrationDate: splited.length > 16 ? splited[16] : null,
      registrationExpiredDate: splited.length > 17 ? splited[17] : null,
      registrationAdress: splited.length > 18 ? splited[18] : null,
      datePasportBirth: splited.length > 19 ? splited[19] : null,
      sex: splited.length > 20 ? splited[20] : null,
      citizen: splited.length > 21 ? splited[21] : null,
      countryEmitent: splited.length > 22 ? splited[22] : null,
      numberMedicialBook: splited.length > 23 ? splited[23] : null,
      medicialBookExpiredDate: splited.length > 24 ? splited[24] : null,
      medicialBookDate: splited.length > 25 ? splited[25] : null,
      gosNumber: splited.length > 26 ? splited[26] : null,
      firstLatName: splited.length > 27 ? splited[27] : null,
      lastLatName: splited.length > 28 ? splited[28] : null,
      internationalPassportDateBirth:
          splited.length > 29 ? splited[29] : null, // Новое поле
      wpNumber: splited.length > 30 ? splited[30] : null, // Новое поле
      wpblankNumber: splited.length > 31 ? splited[31] : null, // Новое поле
      wpDateBirth: splited.length > 32 ? splited[32] : null, // Новое поле
    );
  }

  // Обновленный hashCode метод
  @override
  int get hashCode => (
        passport,
        vy,
        sts,
        snils,
        inn,
        birthCertificate,
        internationalPassport,
        firstName,
        secondName,
        lastName,
        birthday,
        region,
        patentNumber,
        blankNumber,
        datePatentBirth,
        registrationDate,
        registrationExpiredDate,
        registrationAdress,
        datePasportBirth,
        sex,
        citizen,
        countryEmitent,
        numberMedicialBook,
        medicialBookExpiredDate,
        medicialBookDate,
        gosNumber,
        firstLatName,
        lastLatName,
      ).hashCode;

  static List<List<String>> getListOfMassivesStrings(UserData userData) => [
        getPatentStringsForDocuments(userData),
        getWPStringsForDocuments(userData),
        getRegistrationStrings(userData),
        getPasportStringsForDocuments(userData),
        [userData.passport ?? ''],
        getMedicalStrings(userData),
        getGibddStrings(userData),
        getFsspStringsForDocuments(userData),
        getFnsStrings(userData)
      ];

  static List<String> getFsspStringsForDocuments(UserData data) {
    return [
      '${data.lastName ?? ''} ${data.firstName ?? ''} ${data.secondName ?? ''}'
          .trim(),
      data.birthday ?? '',
      data.region ?? '',
      data.inn ?? '',
      data.sts ?? '',
      data.passport ?? '',
      data.snils ?? '',
    ];
  }

  static List<String> getPasportStringsForDocuments(UserData data) {
    return [
      data.internationalPassport ?? '',
      data.internationalPassportDateBirth ?? '',
      data.lastName ?? '',
      data.firstName ?? '',
      data.secondName ?? '',
      data.lastLatName ?? '',
      data.firstLatName ?? '',
      data.birthday ?? '',
      data.sex ?? '',
      data.citizen ?? '',
    ];
  }

  static List<String> getDeportStrings(UserData data) {
    return [
      data.lastLatName ?? '',
      data.firstLatName ?? '',
      data.lastName ?? '',
      data.firstName ?? '',
      data.secondName ?? '',
      data.sex ?? '',
      data.birthday ?? '',
      data.citizen ?? '',
    ];
  }

  static List<String> getPatentStringsForDocuments(UserData data) {
    return [
      (data.patentNumber?.isNotEmpty ?? false)
          ? data.patentNumber!.split('@').first
          : '',
      (data.patentNumber?.isNotEmpty ?? false)
          ? data.patentNumber!.split('@').last
          : '',
      (data.blankNumber?.isNotEmpty ?? false)
          ? data.blankNumber!.split('@').first
          : '',
      (data.blankNumber?.isNotEmpty ?? false)
          ? data.blankNumber!.split('@').last
          : '',
      data.internationalPassport ?? '',
      data.datePatentBirth ?? '',
    ];
  }

  static List<String> getWPStringsForDocuments(UserData data) {
    return [
      (data.wpNumber?.isNotEmpty ?? false)
          ? data.wpNumber!.split('@').first
          : '',
      (data.wpNumber?.isNotEmpty ?? false)
          ? data.wpNumber!.split('@').last
          : '',
      (data.wpblankNumber?.isNotEmpty ?? false)
          ? data.wpblankNumber!.split('@').first
          : '',
      (data.wpblankNumber?.isNotEmpty ?? false)
          ? data.wpblankNumber!.split('@').last
          : '',
      data.internationalPassport ?? '',
      data.wpDateBirth ?? '',
    ];
  }

  static List<String> getDeportStringsToDocuments(UserData data) {
    return [
      data.internationalPassport ?? '',
      data.internationalPassport ?? '',
      data.lastLatName ?? '',
      data.firstLatName ?? '',
      data.lastName ?? '',
      data.firstName ?? '',
      data.secondName ?? '',
      data.sex ?? '',
      data.birthday ?? '',
      data.citizen ?? '',
    ];
  }

  static List<String> getFacesStrings(UserData data) {
    return [
      '${data.lastName ?? ''} ${data.firstName ?? ''} ${data.secondName ?? ''}',
      (data.birthday ?? '').isEmpty ? '' : data.birthday?.split('.').last ?? '',
      (data.birthday ?? '').isEmpty ? '' : data.birthday?.split('.')[1] ?? '',
      (data.birthday ?? '').isEmpty
          ? ''
          : data.birthday?.split('.').first ?? '',
      data.internationalPassport ?? data.passport ?? '',
      data.datePasportBirth ?? '',
    ];
  }

  // Функция для получения списка строк, которые должны быть проверены
  static List<String> getPatentStrings(UserData data) {
    return [
      data.patentNumber ?? '',
      data.blankNumber ?? '',
      data.internationalPassport ?? '',
      data.datePatentBirth ?? '',
    ];
  }

  static List<String> getWPStrings(UserData data) {
    return [
      data.wpNumber ?? '',
      data.wpblankNumber ?? '',
      data.internationalPassport ?? '',
      data.wpDateBirth ?? '',
    ];
  }

  static List<String> getRegistrationStrings(UserData data) {
    return [
      data.registrationDate ?? '',
      data.registrationExpiredDate ?? '',
      data.registrationAdress ?? '',
    ];
  }

  static List<String> getPasportStrings(UserData data) {
    return [
      data.internationalPassport ?? '',
      data.internationalPassportDateBirth ?? '',
      data.lastName ?? '',
      data.firstName ?? '',
      data.birthday ?? '',
      data.sex ?? '',
      data.citizen ?? '',
    ];
  }

  static List<String> getMedicalStrings(UserData data) {
    return [
      data.numberMedicialBook ?? '',
      data.medicialBookDate ?? '',
      data.medicialBookExpiredDate ?? '',
    ];
  }

  static List<String> getAutoMobileStrings(UserData data) {
    return [
      data.gosNumber ?? '',
      data.sts ?? '',
    ];
  }

  static List<String> getFsspStrings(UserData data) {
    return [
      data.lastName ?? '',
      data.firstName ?? '',
      data.secondName ?? '',
      data.birthday ?? '',
      data.region ?? '',
      data.inn ?? '',
      data.sts ?? '',
      data.passport ?? '',
      data.snils ?? '',
    ];
  }

  static List<String> getGibddStrings(UserData data) {
    return [
      data.passport ?? '',
      data.vy ?? '',
      data.sts ?? '',
    ];
  }

  static List<String> getFnsStrings(UserData data) {
    return [
      data.passport ?? '',
      data.inn ?? '',
    ];
  }

  UserData copyWith({
    String? passport,
    String? vy,
    String? sts,
    String? snils,
    String? inn,
    String? birthCertificate,
    String? internationalPassport,
    String? firstName,
    String? secondName,
    String? lastName,
    String? birthDay,
    String? region,
    String? uin,
    //
    String? patentNumber,
    String? blankNumber,
    String? datePatentBirth,
    String? registrationDate,
    String? registrationExpiredDate,
    String? registrationAdress,
    String? datePasportBirth,
    String? sex,
    String? citizen,
    String? countryEmitent,
    String? numberMedicialBook,
    String? medicialBookExpiredDate,
    String? medicialBookDate,
    String? gosNumber,
    String? firstLatName,
    String? lastLatName,
    String? internationalPassportDateBirth, // Новое поле
    String? wpNumber, // Новое поле
    String? wpblankNumber, // Новое поле
    String? wpDateBirth, // Новое поле
    bool forceNull = false,
  }) {
    return UserData(
      passport: forceNull ? passport : passport ?? this.passport,
      vy: forceNull ? vy : vy ?? this.vy,
      sts: forceNull ? sts : sts ?? this.sts,
      snils: forceNull ? snils : snils ?? this.snils,
      inn: forceNull ? inn : inn ?? this.inn,
      uin: forceNull ? uin : uin ?? this.uin,
      birthCertificate: forceNull
          ? birthCertificate
          : birthCertificate ?? this.birthCertificate,
      internationalPassport: forceNull
          ? internationalPassport
          : internationalPassport ?? this.internationalPassport,
      firstName: forceNull ? firstName : firstName ?? this.firstName,
      secondName: forceNull ? secondName : secondName ?? this.secondName,
      lastName: forceNull ? lastName : lastName ?? this.lastName,
      birthday: forceNull ? birthDay : birthDay ?? this.birthday,
      region: forceNull ? region : region ?? this.region,
      //
      patentNumber:
          forceNull ? patentNumber : patentNumber ?? this.patentNumber,
      blankNumber: forceNull ? blankNumber : blankNumber ?? this.blankNumber,
      datePatentBirth:
          forceNull ? datePatentBirth : datePatentBirth ?? this.datePatentBirth,
      registrationDate: forceNull
          ? registrationDate
          : registrationDate ?? this.registrationDate,
      registrationExpiredDate: forceNull
          ? registrationExpiredDate
          : registrationExpiredDate ?? this.registrationExpiredDate,
      registrationAdress: forceNull
          ? registrationAdress
          : registrationAdress ?? this.registrationAdress,
      datePasportBirth: forceNull
          ? datePasportBirth
          : datePasportBirth ?? this.datePasportBirth,
      sex: forceNull ? sex : sex ?? this.sex,
      citizen: forceNull ? citizen : citizen ?? this.citizen,
      countryEmitent:
          forceNull ? countryEmitent : countryEmitent ?? this.countryEmitent,
      numberMedicialBook: forceNull
          ? numberMedicialBook
          : numberMedicialBook ?? this.numberMedicialBook,
      medicialBookExpiredDate: forceNull
          ? medicialBookExpiredDate
          : medicialBookExpiredDate ?? this.medicialBookExpiredDate,
      medicialBookDate: forceNull
          ? medicialBookDate
          : medicialBookDate ?? this.medicialBookDate,
      gosNumber: forceNull ? gosNumber : gosNumber ?? this.gosNumber,
      firstLatName:
          forceNull ? firstLatName : firstLatName ?? this.firstLatName,
      lastLatName: forceNull ? lastLatName : lastLatName ?? this.lastLatName,
      internationalPassportDateBirth: forceNull
          ? internationalPassportDateBirth
          : internationalPassportDateBirth ??
              this.internationalPassportDateBirth,
      wpNumber: forceNull ? wpNumber : wpNumber ?? this.wpNumber, // Новое поле
      wpblankNumber: forceNull
          ? wpblankNumber
          : wpblankNumber ?? this.wpblankNumber, // Новое поле
      wpDateBirth: forceNull
          ? wpDateBirth
          : wpDateBirth ?? this.wpDateBirth, // Новое поле
    );
  }
}
