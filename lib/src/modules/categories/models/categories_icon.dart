class CategoriesIcon {
  CategoriesIcon({
    this.status,
    this.total,
    this.data,
    this.message,
  });

  bool status;
  int total;
  List<IconsData> data;
  String message;

  CategoriesIcon copyWith({
    bool status,
    int total,
    List<IconsData> data,
    String message,
  }) =>
      CategoriesIcon(
        status: status ?? this.status,
        total: total ?? this.total,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class IconsData {
  IconsData({
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

  IconsData copyWith({
    int id,
    String image,
    String createdAt,
    String updatedAt,
    String deletedAt,
  }) =>
      IconsData(
        id: id ?? this.id,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
