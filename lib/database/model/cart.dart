class Cart {
  int id;
  String _id_produk;
  int _harga;
  int _jumlah;
  int _sub_total;
  Cart(this._id_produk, this._harga, this._jumlah, this._sub_total);
  Cart.map(dynamic obj) {
    this._id_produk = obj["id_produk"];
    this._harga = obj["harga"];
    this._jumlah = obj["jumlah"];
    this._sub_total = obj["sub_total"];
  }
  String get cartIdProduk => _id_produk;
  int get cartHarga => _harga;
  int get cartJumlah => _jumlah;
  int get cartSubTotal => _sub_total;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id_produk"] = this._id_produk;
    map["harga"] = this._harga;
    map["jumlah"] = this._jumlah;
    map["sub_total"] = this._sub_total;
    return map;
  }
  void setCartId(int id) {
    this.id = id;
  }
}
