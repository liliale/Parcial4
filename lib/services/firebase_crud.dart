import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/respuesta.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Clientes');
class FirebaseCrud {
//CRUD method here
  static Future<Respuesta> addCliente({
    required String cedula,
    required String nombre,
    required String apellido,
    required String fechanacimiento,
    required String sexo,
    required String tipo,
    required String usuario
  }) async {

    Respuesta response = Respuesta();
    DocumentReference documentReferencer =
        _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "cedula": cedula,
      "nombre": nombre,
      "apellido": apellido,
      "fecha_nacimiento" : fechanacimiento,
      "sexo": sexo,
      "tipo": tipo,
      "usuario": usuario
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
          response.code = 200;
          response.message = "Cliente guardado exitosamente";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Future<Respuesta> updateCliente({
    required String cedula,
    required String nombre,
    required String apellido,
    required String fechanacimiento,
    required String sexo,
    required String tipo,
    required String usuario,
    required String docId,
  }) async {
    Respuesta response = Respuesta();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "cedula": cedula,
      "nombre": nombre,
      "apellido": apellido,
      "fecha_nacimiento" : fechanacimiento,
      "sexo": sexo,
      "tipo": tipo,
      "usuario": usuario
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Cliente modificado exitosamente";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Stream<QuerySnapshot> readCliente() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Respuesta> deleteCliente({
    required String docId,
  }) async {
     Respuesta response = Respuesta();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Cliente eliminado exitosamente";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }
}