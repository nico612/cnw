

class BaseRequestListMode {

  final int size;
  final int page;

  const BaseRequestListMode({this.page = 1, this.size = 10});

  
  Map<String, dynamic>  get params => {"page": page, "size": size};
      


}