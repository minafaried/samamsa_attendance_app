class Memper {
  String id;
  String name;
  String family;
  bool isAttende = false;
  DateTime date = DateTime.now();

  Memper({
    required this.id,
    required this.name,
    required this.family,
  });

  factory Memper.fromJson(Map<String, dynamic> json) => Memper(
      id: json["id"] ?? "",
      name: json["name"] ?? '',
      family: json["family"] ?? '');

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "family": family,
        "isAttende": isAttende,
        "date": date
      };
}
