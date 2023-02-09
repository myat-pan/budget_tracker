class Result {
  Result({
    this.status,
    this.message,
  });

  bool status;
  String message;

  Result copyWith({
    bool status,
    String message,
  }) =>
      Result(
        status: status ?? this.status,
        message: message ?? this.message,
      );
}
