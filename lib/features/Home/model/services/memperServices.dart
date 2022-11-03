import 'package:attendance_app/Common/Config/serverDomain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemperServices {
  Domain domain = Domain();
  Future<List?> getMempers(String family) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("Mempers");
      final mempers = (family == "الكل"
              ? await collection.get()
              : await collection.where("family", isEqualTo: family).get())
          .docs
          .map((doc) => {
                "id": doc.id,
                "name": doc["name"],
                "family": doc["family"],
              })
          .toList();
      print(mempers);
      return mempers;
    } catch (e) {
      print('error:' + e.toString());
      return null;
    }
  }

  Future<void> sendAttendance(
      String family, String event, List<Map<String, dynamic>> mempers) async {
    try {
      var batch = FirebaseFirestore.instance.batch();
      CollectionReference collection = FirebaseFirestore.instance
          .collection("Families")
          .doc(family)
          .collection(event);
      mempers.forEach((element) {
        var docRef = collection.doc();
        batch.set(docRef, element);
      });
      await batch.commit();
    } catch (e) {
      print('error:' + e.toString());
    }
  }
}
