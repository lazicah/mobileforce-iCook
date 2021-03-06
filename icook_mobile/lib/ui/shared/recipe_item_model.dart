import 'package:icook_mobile/ui/base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:icook_mobile/locator.dart';
import 'package:icook_mobile/core/constants/view_routes.dart';
class RecipeItemModel extends BaseNotifier {
  final navigation = locator<NavigationService>();

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void init({bool isLiked = false}) {
    _isLiked = isLiked;
  }

  void click() {
    _isLiked = !_isLiked;
    notifyListeners();
  }

  void seeDetails(){
    navigation.navigateTo(ViewRoutes.recipe_details);
  }

  void seeUserInfo(){
    navigation.navigateTo(ViewRoutes.otheruserinfo);
  }
}
