class EndpointsAPI {
  String domain;
  String name;

  EndpointsAPI({this.domain, this.name});

  Map<String, dynamic> toMap() => {
    "domain": domain,
    "name": name
  };

  factory EndpointsAPI.fromDb(Map<String, dynamic> json) => EndpointsAPI(
      domain: json["domain"],
      name: json['name']
  );

}