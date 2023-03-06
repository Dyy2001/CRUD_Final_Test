import 'dart:convert';

import 'package:final_task/createdata.dart';
import 'package:final_task/editdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  late Map map;
  late List _listdata = [];

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://pegawai.indonesiafintechforum.org/api/getDataPegawai"));
    if (response.statusCode == 200) {
      setState(() {
        map = jsonDecode(response.body);
        _listdata = map['data'];
      });
    }
  }

  Future<void> _deleteData(String id) async {
    final response = await http.post(
      Uri.parse('https://pegawai.indonesiafintechforum.org/api/deletePegawai'),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ReadData()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat menghapus data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Data Pegawai"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _listdata[index]['nama'].toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.work, size: 18.0),
                            SizedBox(width: 5.0),
                            Text(_listdata[index]['posisi'].toString()),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.attach_money, size: 18.0),
                            SizedBox(width: 5.0),
                            Text(_listdata[index]['gaji'].toString()),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.location_city, size: 18.0),
                            SizedBox(width: 5.0),
                            Text(_listdata[index]['alamat'].toString()),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditData(
                                          listdata: {
                                            "id": _listdata[index]['id']
                                                .toString(),
                                            "nama": _listdata[index]['nama'],
                                            "posisi": _listdata[index]
                                                ['posisi'],
                                            "gaji": _listdata[index]['gaji'],
                                            "alamat": _listdata[index]
                                                ['alamat'],
                                          },
                                        )));
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteData(_listdata[index]['id'].toString());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateDate()));
            },
            child: const Text("Create Data"),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: apicall,
            child: const Text("Read Data"),
          ),
        ],
      ),
    );
  }
}
