class GymResponse {
  List<Gyms>? gyms;

  GymResponse({this.gyms});

  GymResponse.fromJson(Map<String, dynamic> json) {
    if (json['gyms'] != null) {
      gyms = <Gyms>[];
      json['gyms'].forEach((v) {
        gyms!.add(new Gyms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gyms != null) {
      data['gyms'] = this.gyms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gyms {
  int? id;
  String? title;
  double? rating;
  int? price;
  bool? favorite;
  String? date;
  List<PopularClasess>? popularClasess;

  Gyms(
      {this.id,
      this.title,
      this.rating,
      this.price,
      this.favorite,
      this.date,
      this.popularClasess});

  Gyms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['rating'];
    price = json['price'];
    favorite = json['favorite'];
    date = json['date'];
    if (json['popular_clasess'] != null) {
      popularClasess = <PopularClasess>[];
      json['popular_clasess'].forEach((v) {
        popularClasess!.add(new PopularClasess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['favorite'] = this.favorite;
    data['date'] = this.date;
    if (this.popularClasess != null) {
      data['popular_clasess'] =
          this.popularClasess!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularClasess {
  String? title;
  int? price;
  bool? favorite;
  String? location;
  String? time;

  PopularClasess(
      {this.title, this.price, this.favorite, this.location, this.time});

  PopularClasess.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    favorite = json['favorite'];
    location = json['location'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['favorite'] = this.favorite;
    data['location'] = this.location;
    data['time'] = this.time;
    return data;
  }
}
