class RecipeModal {
  late String appLabel;
  late String appImageUrl;
  late double appCalories;
  late String appUrl;

  RecipeModal(
      {this.appLabel = "label",
      this.appImageUrl = "image",
      this.appCalories = 0.00,
      this.appUrl = "url"});
  factory RecipeModal.fromMap(Map recipe){
    return RecipeModal(
     appLabel: recipe["label"],
      appCalories: recipe["calories"],
      appImageUrl: recipe["image"],
      appUrl: recipe["url"],
    );
  }
}
