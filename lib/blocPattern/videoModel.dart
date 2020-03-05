class VideoModel {
  int id;
  List<Resultsv> vresults;

  VideoModel({this.id, this.vresults});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      vresults = new List<Resultsv>();
      json['results'].forEach((v) {
        vresults.add(new Resultsv.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.vresults != null) {
      data['results'] = this.vresults.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resultsv {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Resultsv(
      {this.id,
      this.iso6391,
      this.iso31661,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

  Resultsv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}