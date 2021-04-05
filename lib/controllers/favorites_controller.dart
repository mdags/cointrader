import 'package:cointrader/models/favorites_model.dart';
import 'package:cointrader/services/data_services.dart';
import 'package:get/state_manager.dart';

class FavoritesController extends GetxController {
  var isLoading = true.obs;
  var list = List<FavoritesModel>().obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await DataBaseServices.instance.getFavorites();
      if (data != null) {
        list.assignAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  void addData(FavoritesModel model) async {
    await DataBaseServices.instance.insertFavorite(model);
  }

  void delete(int id) async {
    await DataBaseServices.instance.deleteFavorite(id);
    list.removeWhere((element) => element.id == id);
  }
}
