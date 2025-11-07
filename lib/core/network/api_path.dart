class ApiPath {
  static const baseUrl = 'https://xn----7sboldak4aeeqnag.xn--p1ai';

  static const banners =
      'https://xn----7sboldak4aeeqnag.xn--p1ai/migrantreestr/appinfo.php';

  static const sendMessage =
      'https://xn--80anhm0a.xn--p1ai/apimobile/machat/masend.php';
  static const getLastMessage =
      'https://xn--80anhm0a.xn--p1ai/apimobile/machat/mareceive.php';

  static const getBackgroundNotification =
      'https://xn----7sboldak4aeeqnag.xn--p1ai/migrantreestr/deportpatent/chat/sendanswer.php';

  static const appMetrikaConfigKey = '';

  static paymentScreenUrl(String yin) {
    if (yin.startsWith('182')) {
      return '$baseUrl/migrantreestr/plategi/sendnalogppurl.php?uin=$yin';
    } else {
      return '$baseUrl/migrantreestr/plategi/sendfssppurl.php?uin=$yin';
    }
  }

  static String getInvoiceInfo() =>
      "${ApiPath.baseUrl}/migrantreestr/plategi/sendgetinvoiceinfoppl.php";

  static String getDoSearch() =>
      "${ApiPath.baseUrl}/migrantreestr/plategi/senddosearch.php";

  static String getResult() =>
      "${ApiPath.baseUrl}/migrantreestr/plategi/sendgetresult.php";

  static String loadFsin() =>
      "$baseUrl/migrantreestr/plategi/fsinregionitems.json";
}
