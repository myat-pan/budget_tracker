// class StoreBudget {
//   bool status;
//   StoreBudgetData data;
//   String message;

//   StoreBudget({
//     this.status,
//     this.data,
//     this.message,
//   });

//   StoreBudget copyWith({
//     bool status,
//     StoreBudgetData data,
//     String message,
//   }) =>
//       StoreBudget(
//         status: status ?? this.status,
//         data: data ?? this.data,
//         message: message ?? this.message,
//       );
// }

// class StoreBudgetData {
//   String month;
//   String year;
//   List<DailyCard> dailyCards;

//   StoreBudgetData({
//     this.month,
//     this.year,
//     this.dailyCards,
//   });

//   StoreBudgetData copyWith({
//     String month,
//     String year,
//     List<DailyCard> dailyCards,
//   }) =>
//       StoreBudgetData(
//         month: month ?? this.month,
//         year: year ?? this.year,
//         dailyCards: dailyCards ?? this.dailyCards,
//       );
// }

// class DailyCard {
//   String day;
//   int income;
//   int expense;
//   int netBudget;
//   String percentage;
//   List<BudgetItems> items;

//   DailyCard({
//     this.day,
//     this.income,
//     this.expense,
//     this.netBudget,
//     this.percentage,
//     this.items,
//   });

//   DailyCard copyWith({
//     String day,
//     int income,
//     int expense,
//     int netBudget,
//     String percentage,
//     List<BudgetItems> items,
//   }) =>
//       DailyCard(
//         day: day ?? this.day,
//         income: income ?? this.income,
//         expense: expense ?? this.expense,
//         netBudget: netBudget ?? this.netBudget,
//         percentage: percentage ?? this.percentage,
//         items: items ?? this.items,
//       );
// }

class BudgetItems {
  int id;
  int userId;
  int categoryId;
  String amount;
  String type;
  String remark;
  DateTime createdDate;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Category category;

  BudgetItems({
    this.id,
    this.userId,
    this.categoryId,
    this.amount,
    this.type,
    this.remark,
    this.createdDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
  });

  BudgetItems copyWith({
    int id,
    int userId,
    int categoryId,
    String amount,
    String type,
    String remark,
    DateTime createdDate,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
    Category category,
  }) =>
      BudgetItems(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        remark: remark ?? this.remark,
        createdDate: createdDate ?? this.createdDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        category: category ?? this.category,
      );
}

class Category {
  int id;
  int userId;
  String name;
  String type;
  String icon;
  int iconId;
  String color;
  int isDefault;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Category({
    this.id,
    this.userId,
    this.name,
    this.type,
    this.icon,
    this.iconId,
    this.color,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Category copyWith({
    int id,
    int userId,
    String name,
    String type,
    String icon,
    int iconId,
    String color,
    int isDefault,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
  }) =>
      Category(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        type: type ?? this.type,
        icon: icon ?? this.icon,
        iconId: iconId ?? this.iconId,
        color: color ?? this.color,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
