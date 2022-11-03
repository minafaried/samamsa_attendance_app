class Domain {
  static final Domain _domain = Domain._internal();
  late String serverName;
  late String portNumber;

  factory Domain() {
    _domain.serverName = "10.0.2.2";
    _domain.portNumber = "8080";
    return _domain;
  }
  Domain._internal();
}
