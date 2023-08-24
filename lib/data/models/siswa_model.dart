class Siswa {
  int? id, kelas;
  String? name, nis, photo;

  Siswa({this.id, this.name, this.kelas, this.nis, this.photo});

  Siswa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nis = json['nis'];
    kelas = json['kelas'];
    photo = json['photo'];

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'name': name,
        'nis': nis,
        'kelas': kelas,
        'photo': photo
      };
    }
  }
}
