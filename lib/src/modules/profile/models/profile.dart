class ProfileResult {
  ProfileResult({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<ProfileData> data;
  String message;

  ProfileResult copyWith({
    bool status,
    List<ProfileData> data,
    String message,
  }) =>
      ProfileResult(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class ProfileData {
  ProfileData({
    this.brief,
    this.monthlyResults,
  });

  Brief brief;
  List<MonthlyResult> monthlyResults;

  ProfileData copyWith({
    Brief brief,
    List<MonthlyResult> monthlyResults,
  }) =>
      ProfileData(
        brief: brief ?? this.brief,
        monthlyResults: monthlyResults ?? this.monthlyResults,
      );
}

class Brief {
  Brief({
    this.year,
    this.income,
    this.expense,
    this.netBudget,
    this.percentage,
  });

  int year;
  int income;
  int expense;
  int netBudget;
  int percentage;

  Brief copyWith({
    int year,
    int income,
    int expense,
    int netBudget,
    int percentage,
  }) =>
      Brief(
        year: year ?? this.year,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        netBudget: netBudget ?? this.netBudget,
        percentage: percentage ?? this.percentage,
      );
}

class MonthlyResult {
  MonthlyResult({
    this.month,
    this.income,
    this.expense,
    this.netBudget,
  });

  String month;
  int income;
  int expense;
  int netBudget;

  MonthlyResult copyWith({
    String month,
    int income,
    int expense,
    int netBudget,
  }) =>
      MonthlyResult(
        month: month ?? this.month,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        netBudget: netBudget ?? this.netBudget,
      );
}
