import 'package:flutter/material.dart';
import '../data/models/siswa_model.dart';

class SiswaPage extends StatefulWidget {
  const SiswaPage({Key? key}) : super(key: key);

  @override
  State<SiswaPage> createState() => _SiswaViewState();
}

class _SiswaViewState extends State<SiswaPage> {
  List<Siswa> daftarSiswa = [
    Siswa(
      id: 1,
      name: 'John Doe',
      nis: '2020-001',
      kelas: 5,
      photo:
          'https://e0.pxfuel.com/wallpapers/688/852/desktop-wallpaper-pin-oleh-aury-otaku-di-doraemon-dengan-gambar-doraemon-kartun-yellow-doraemon.jpg',
    ),
  ];
  TextEditingController searchController = TextEditingController();

  List<Siswa> searchResults = [];

  void search(String value) {
    setState(() {
      searchResults = daftarSiswa.where((siswa) {
        return (siswa.name?.toLowerCase() ?? '')
                .contains(value.toLowerCase()) ||
            (siswa.nis?.toLowerCase() ?? '').contains(value.toLowerCase()) ||
            siswa.id.toString() == value;
      }).toList();
    });
  }

  void update(int id, Map<String, dynamic> value) {
    try {
      int index = daftarSiswa.indexWhere((element) => element.id == id);
      Map<String, dynamic> data = {...value};
      data['id'] = id;

      if (index != -1) {
        final siswa = Siswa.fromJson(data);
        daftarSiswa[index] = siswa;
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }
 
  void remove(int id) {
    try {
      daftarSiswa.removeWhere((e) => e.id == id);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  void create(Map<String, dynamic> value) {
    try {
      int id = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> data = {...value};
      data['id'] = id;

      final siswa = Siswa.fromJson(data);
      daftarSiswa.add(siswa);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Data Siswa (${daftarSiswa.length})'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search.......',
              ),
              onChanged: (value) {
                search(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, i) {
                final siswa = searchResults[i];
                String? nama = siswa.name;
                String? nis = siswa.nis;

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration:  BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                      color: Color.fromARGB(255, 144, 176, 231),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(siswa.photo ?? ''),
                            radius: 40,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nama!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25)),
                              Text(
                                nis!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormSiswa(siswa: siswa),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  update(siswa.id ?? 0, value);
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.mode_edit_outlined,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => remove(siswa.id ?? 0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FormSiswa()))
              .then((value) {
            if (value != null) {
              create(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormSiswa extends StatefulWidget {
  final Siswa? siswa;
  const FormSiswa({Key? key, this.siswa}) : super(key: key);

  @override
  State<FormSiswa> createState() => _FormSiswaState();
}

class _FormSiswaState extends State<FormSiswa> {
  final nama = TextEditingController();
  final nis = TextEditingController();
  final kelas = TextEditingController();
  final photo = TextEditingController();

  @override
  void initState() {
    if (widget.siswa?.id != null) {
      nama.text = widget.siswa?.name ?? '';
      nis.text = widget.siswa?.nis ?? '';
      kelas.text = widget.siswa?.kelas.toString() ?? '';
      photo.text = widget.siswa?.photo ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.siswa?.id == null ? 'Tambah Data Siswa' : 'Edit Data Siswa'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nama,
            decoration: const InputDecoration(
              hintText: 'Input Nama Siswa',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            controller: nis,
            decoration: const InputDecoration(
              hintText: 'Input NIS Siswa',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            controller: kelas,
            decoration: const InputDecoration(
              hintText: 'Input Kelas Siswa',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: photo,
            decoration: const InputDecoration(
              hintText: 'Input Foto Dalam Bentuk URL',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'nama': nama.text,
              'nis': nis.text,
              'kelas': int.tryParse(kelas.text) ?? 0,
              'photo': photo.text,
            });
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
