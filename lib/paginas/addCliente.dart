import 'package:parcial4/paginas/listaClientes.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _cliente_nombre = TextEditingController();
  final _cliente_apellido = TextEditingController();
  final _cliente_cedula= TextEditingController();
  final _cliente_sexo= TextEditingController();
  final _cliente_tipo= TextEditingController();
  final _cliente_usuario= TextEditingController();
  final _cliente_fecha= TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cedulaField = TextFormField(
        controller: _cliente_cedula,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Cedula es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Cedula",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final nombreField = TextFormField(
        controller: _cliente_nombre,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Nombre es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nombre",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final apellidoField = TextFormField(
        controller: _cliente_apellido,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Apellido es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Apellido",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    
    final tipoField = TextFormField(
        controller: _cliente_tipo,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Tipo es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Tipo usuario",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final sexoField = TextFormField(
        controller: _cliente_sexo,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo sexo es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Sexo",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
     final fechaField = TextFormField(
        controller: _cliente_fecha,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Fecha es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Fecha nac.",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
     final usuarioField = TextFormField(
        controller: _cliente_usuario,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo usuario es requerido';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Usuario",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('Lista de clientes'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.addCliente(
                cedula: _cliente_cedula.text,
                nombre: _cliente_nombre.text,
                apellido: _cliente_apellido.text,
                tipo: _cliente_tipo.text,
                sexo: _cliente_sexo.text,
                fechanacimiento: _cliente_fecha.text,
                usuario: _cliente_usuario.text,
                );
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Guardar",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Parcial4'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:  Center (
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  cedulaField,
                  const SizedBox(height: 25.0),
                  nombreField,
                  const SizedBox(height: 25.0),
                  apellidoField,
                  const SizedBox(height: 25.0),
                  tipoField,
                  const SizedBox(height: 25.0),
                  sexoField,
                  const SizedBox(height: 25.0),
                  fechaField,
                  const SizedBox(height: 25.0),
                 usuarioField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
        )
      )
    );
  }
}
