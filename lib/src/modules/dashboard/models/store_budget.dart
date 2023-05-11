class StoreBudget {
  StoreBudget({
    this.status,
    this.id,
    this.data,
    this.message,
  });

  bool status;
  int id;
  StoreBudgetData data;
  String message;

  StoreBudget copyWith({
    bool status,
    int id,
    StoreBudgetData data,
    String message,
  }) =>
      StoreBudget(
        status: status ?? this.status,
        id: id ?? this.id,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class StoreBudgetData {
  StoreBudgetData({
    this.id,
    this.type,
    this.remark,
    this.amount,
    this.categoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
  });

  int id;
  String type;
  dynamic remark;
  String amount;
  int categoryId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Category category;

  StoreBudgetData copyWith({
    int id,
    String type,
    dynamic remark,
    String amount,
    int categoryId,
    int userId,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
    Category category,
  }) =>
      StoreBudgetData(
        id: id ?? this.id,
        type: type ?? this.type,
        remark: remark ?? this.remark,
        amount: amount ?? this.amount,
        categoryId: categoryId ?? this.categoryId,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        category: category ?? this.category,
      );
}

class Category {
  Category({
    this.id,
    this.name,
    this.type,
    this.color,
    this.iconId,
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
  int iconId;
  String iconImage;
  int isDefault;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Category copyWith({
    int id,
    String name,
    String type,
    String color,
    int iconId,
    String iconImage,
    int isDefault,
    int userId,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        color: color ?? this.color,
        iconId: iconId ?? this.iconId,
        iconImage: iconImage ?? this.iconImage,
        isDefault: isDefault ?? this.isDefault,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
