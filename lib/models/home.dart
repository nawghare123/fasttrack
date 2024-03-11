class HomeModel {
  bool? success;
  String? message;
  List<Data>? data;

  HomeModel({this.success, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  String? layout;
  String? link;
  String? tag;
  bool? viewMore;
  List<Cards>? cards;

  Data(
      {this.title,
        this.layout,
        this.link,
        this.tag,
        this.viewMore,
        this.cards});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    layout = json['layout'];
    link = json['link'];
    tag = json['tag'];
    viewMore = json['view_more'];
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['layout'] = this.layout;
    data['link'] = this.link;
    data['tag'] = this.tag;
    data['view_more'] = this.viewMore;
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cards {
  String? bannerImage;
  String? header;
  String? title;
  String? tag;
  String? link;

  Cards({this.bannerImage, this.header, this.title, this.tag, this.link});

  Cards.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
    header = json['header'];
    title = json['title'];
    tag = json['tag'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_image'] = this.bannerImage;
    data['header'] = this.header;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['link'] = this.link;
    return data;
  }
}