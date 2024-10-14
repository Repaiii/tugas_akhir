import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/view_model_home.dart';


class DeleteConfirmationDialog extends StatelessWidget {
  final String nama;
  final int idDosen;
  final int idMahasiswa;

  const DeleteConfirmationDialog(BuildContext context, {
    required this.nama,
    required this.idDosen,
    required this.idMahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    final viewModelHome = Provider.of<ViewModelHome>(context, listen: false);
    return AlertDialog(
      title: const Text("Peringatan"),
      content: Text("Anda Yakin Ingin Menghapus $nama?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Tidak"),
        ),
        TextButton(
          onPressed: () async {
            await viewModelHome.deleteMahasiswaDiDosen(
              idDosen: idDosen,
              idMhs: idMahasiswa,
            );
            await viewModelHome.fetchDetailDosen(id: idDosen);
            Navigator.of(context).pop();
          },
          child: const Text("Ya"),
        ),
      ],
    );
  }
}
