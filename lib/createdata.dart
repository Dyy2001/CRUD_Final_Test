import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateDate extends StatefulWidget {
  const CreateDate({Key? key});

  @override
  State<CreateDate> createState() => _CreateDateState();
}

class _CreateDateState extends State<CreateDate> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _posisiController = TextEditingController();
  final TextEditingController _gajiController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  Future<void> _submitData() async {
    final response = await http.post(
      Uri.parse('https://pegawai.indonesiafintechforum.org/api/addPegawai'),
      body: {
        'nama': _namaController.text,
        'posisi': _posisiController.text,
        'gaji': _gajiController.text,
        'alamat': _alamatController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil ditambahkan')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Terjadi kesalahan saat menambahkan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pegawai"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _posisiController,
              decoration: InputDecoration(
                labelText: 'Posisi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _gajiController,
              decoration: InputDecoration(
                labelText: 'Gaji',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(350, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: _submitData,
              child: const Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}
