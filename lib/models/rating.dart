class Rating {
  final double? rate;
  final int? count;

  Rating({
   this.rate,
   this.count
  });

    factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
       rate: (json["rate"] as num?)?.toDouble(),
      count: json["count"]
    );
  }
}