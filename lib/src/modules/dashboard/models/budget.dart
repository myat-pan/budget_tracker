import 'package:budget_tracker/src/modules/dashboard/models/store_budget.dart';

class Budget {
  Budget({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  BudgetData data;
  String message;

  Budget copyWith({
    bool status,
    BudgetData data,
    String message,
  }) =>
      Budget(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class BudgetData {
  BudgetData({
    this.dailyCards,
  });

  List<DailyCard> dailyCards;

  BudgetData copyWith({
    List<DailyCard> dailyCards,
  }) =>
      BudgetData(
        dailyCards: dailyCards ?? this.dailyCards,
      );
}

class DailyCard {
  DailyCard({
    this.day,
    this.income,
    this.expense,
    this.netBudget,
    this.percentage,
    this.items,
  });

  String day;
  int income;
  int expense;
  int netBudget;
  String percentage;
  List<StoreBudgetData> items;

  DailyCard copyWith({
    String day,
    int income,
    int expense,
    int netBudget,
    String percentage,
    List<StoreBudgetData> items,
  }) =>
      DailyCard(
        day: day ?? this.day,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        netBudget: netBudget ?? this.netBudget,
        percentage: percentage ?? this.percentage,
        items: items ?? this.items,
      );
}
