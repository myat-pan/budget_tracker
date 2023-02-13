class CategoriesResult {
  CategoriesResult({
    this.status,
    this.incomeCategories,
    this.expenseCategories,
    this.message,
  });

  bool status;
  List<Categories> incomeCategories;
  List<Categories> expenseCategories;
  String message;

  CategoriesResult copyWith({
    bool status,
    List<Categories> incomeCategories,
    List<Categories> expenseCategories,
    String message,
  }) =>
      CategoriesResult(
        status: status ?? this.status,
        incomeCategories: incomeCategories ?? this.incomeCategories,
        expenseCategories: expenseCategories ?? this.expenseCategories,
        message: message ?? this.message,
      );
}

class Categories {
  Categories({
    this.id,
    this.name,
    this.type,
    this.color,
    this.iconImage,
    this.isDefault,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String type;
  String color;
  String iconImage;
  int isDefault;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Categories copyWith({
    int id,
    String name,
    String type,
    String color,
    String iconImage,
    int isDefault,
    int userId,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
  }) =>
      Categories(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        color: color ?? this.color,
        iconImage: iconImage ?? this.iconImage,
        isDefault: isDefault ?? this.isDefault,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
