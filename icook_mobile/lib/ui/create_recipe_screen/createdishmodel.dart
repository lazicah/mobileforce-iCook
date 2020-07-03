import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icook_mobile/core/constants/view_state.dart';
import 'package:icook_mobile/core/datasources/remotedata_source/DIsh/dishdatasource.dart';
import 'package:icook_mobile/core/mixins/validators.dart';
import 'package:icook_mobile/models/requests/Dish/postdish.dart';
import 'package:icook_mobile/ui/base_view_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class CreateDishModel extends BaseNotifier with Validators {
  final datasource = locator<DishDataSource>();
  final snack = locator<SnackbarService>();

  List<String> _ingredients = [];
  List<String> get ingredients => _ingredients;

  List<String> _images;
  // List<String> get images => _images;

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  List<String> _recipes = [];
  List<String> get recipes => _recipes;

  //scaffoldkey
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //formkey
  final formkey = GlobalKey<FormState>();

  //Textcontroller
  final title = TextEditingController();
  final healthbenefits = TextEditingController();
  final ingre = TextEditingController();
  final steps = TextEditingController();

  Future<void> postDish() async {
    if (!formkey.currentState.validate() ||
        _recipes.length < 3 ||
        ingredients.length < 3) {
      showSnack('Requirements not complete');
      return;
    }
    setState(ViewState.Busy);
    List<String> health = [];
    health.add(healthbenefits.text);
    final body = PostDIshBody(
        name: title.text,
        ingredients: ingredients,
        recipe: recipes,
        healthBenefits: health);

    print(body);

    try {
      var result = await datasource.postADish(body);
      print(result);
      setState(ViewState.Idle);
      dispose();

      showSnack('Successfully Added');
    } catch (e) {
      print('add dish model exception $e');
      setState(ViewState.Idle);
      showSnack(e.toString());
    }
  }

  void getImages() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Selected Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    images = resultList;
    _error = error;

    notifyListeners();
  }

  void addIngredient() {
    if (ingre.text.isNotEmpty) {
      _ingredients.add(ingre.text);
      ingre.clear();
      notifyListeners();
    }
  }

  void addStep() {
    if (steps.text.isNotEmpty) {
      _recipes.add(steps.text);
      steps.clear();
      notifyListeners();
    }
  }

  void removeStep(int index) {
    print(index);
    if (_recipes.isNotEmpty) {
      _recipes.removeAt(index);
      notifyListeners();
    }
  }

  void removeIngredient(int index) {
    print(index);
    if (_ingredients.isNotEmpty) {
      _ingredients.removeAt(index);
      notifyListeners();
    }
  }

  void showSnack(String message) {
    snack.showCustomSnackBar(
        message: message,
        title: 'iCook_bot',
        instantInit: true,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    title.clear();
    healthbenefits.clear();
    ingre.clear();
    steps.clear();
    _recipes.clear();
    _ingredients.clear();
  }
}
