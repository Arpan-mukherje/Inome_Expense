import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class StorageServices {
  static Future<void> addData(                                                  
      {required inputAmount,
      required inputType,
      required category,
      required description,
      required month}) async {
    final uuid = Uuid().v1();
    final storeData = await FirebaseFirestore.instance
        .collection('Money')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(month.toString())
        .doc(uuid)
        .set({
      "inputamount": inputAmount,
      "inputtype": inputType,
      "category": category,
      "description": description,
    });
  }

  static Stream<QuerySnapshot<dynamic>> getData(final String month) {
    final data = FirebaseFirestore.instance
        .collection('Money')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(month.toString())
        .snapshots();

    return data;
  }
}
