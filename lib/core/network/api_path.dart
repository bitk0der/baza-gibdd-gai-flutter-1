class ApiPath {
  static const baseUrl = 'https://xn----7sbbdcsj3bpai5b1a8n.xn--p1ai/gaiapp';

  static const banners = '/gaiapp.php';

  static const sendMessage = '$baseUrl/helpreq.php';
  static const getLastMessage = '$baseUrl/helpresp.php';

  static const getBackgroundNotification = '$baseUrl/helpresp.php';

  static const appMetrikaConfigKey = '970fabff-d5d0-4837-bb5d-57c14032580a';

  static String paymentScreenUrl(String yin) {
    if (yin.startsWith('182')) {
      return '$baseUrl/oplat/sendnalogppurl.php?uin=$yin';
    } else {
      return '$baseUrl/oplat/sendnalogppurl.php?uin=$yin';
    }
  }

  static String getInvoiceInfo() =>
      "${ApiPath.baseUrl}/oplat/sendgetinvoiceinfoppl.php";

  static String getDoSearch() => "${ApiPath.baseUrl}/oplat/senddosearch.php";

  static String getResult() => "${ApiPath.baseUrl}/oplat/sendgetresult.php";

  static String loadFsin() => "$baseUrl/oplat/fsinregionitems.json";

  static const gibddFines = "https://moneta.avtoapi.ru/search/v2/fsspgibdd";

  static const reportExampleUrl = '$baseUrl/pers/examplepers.pdf';

  static const getCart = '$baseUrl/pers/persreportsavailable.php';

  static const getPaymentLink = '$baseUrl/pers/persbuyreport.php';

  static const checkPayment = '$baseUrl/pers/perspaymentcheck.php';

  static const getReceivingOrders = '$baseUrl/pers/persreportsorders.php';

  static const checkAutoWidget =
      'https://xn----7sbbdcsj3bpai5b1a8n.xn--p1ai/appwidget/orders.html';

  static String getAutoCheckString(String number, bool isGosNumber) {
    if (isGosNumber) {
      return 'https://xn----7sbbdcsj3bpai5b1a8n.xn--p1ai/appwidget/search.html?inputnumber=$number';
    } else {
      return 'https://xn----7sbbdcsj3bpai5b1a8n.xn--p1ai/appwidget/search.html?inputvin=$number';
    }
  }
}
