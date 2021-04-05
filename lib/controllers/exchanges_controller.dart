import 'package:cointrader/models/exchanges_model.dart';
import 'package:cointrader/services/remote_services.dart';
import 'package:get/state_manager.dart';

class ExchangesController extends GetxController {
  var isLoading = true.obs;
  var exchangeList = List<ExchangesModel>().obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await RemoteServices.fetchExchanges();
      if (data != null) {
        //exchangeList.value = data;
        exchangeList.assignAll(data);
      }
    } finally {
      isLoading(false);
    }
  }
}
