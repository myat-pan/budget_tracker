class CategoriesIcon {
  CategoriesIcon({
    this.status,
    this.total,
    this.data,
    this.message,
  });

  bool status;
  int total;
  List<IconData> data;
  String message;

  CategoriesIcon copyWith({
    bool status,
    int total,
    List<IconData> data,
    String message,
  }) =>
      CategoriesIcon(
        status: status ?? this.status,
        total: total ?? this.total,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class IconData {
  IconData({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String image;
  String createdAt;
  String updatedAt;
  String deletedAt;

  IconData copyWith({
    int id,
    String image,
    String createdAt,
    String updatedAt,
    String deletedAt,
  }) =>
      IconData(
        id: id ?? this.id,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
