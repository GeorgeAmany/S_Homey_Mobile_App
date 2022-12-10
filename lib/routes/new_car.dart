
import 'package:flutter/material.dart';


class addNewCars extends StatefulWidget {
  const addNewCars({Key? key}) : super(key: key);

  @override
  State<addNewCars> createState() => _addNewCarsState();
}

class _addNewCarsState extends State<addNewCars> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: const [

            // FlatButton(onPressed: () async{
            //
            //   final ImagePicker _picker = ImagePicker();
            //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            //
            //   if (image != null) {
            //     var selected = File(image.path);
            //
            //     Uri urll = Uri.https(
            //         'pandarosh-91270-default-rtdb.firebaseio.com', '/s&mInfo.json');
            //
            //     await http
            //         .post(
            //       urll,
            //       body: json.encode({
            //        // 'name': name.text,
            //         'num': "0",
            //       }),
            //     ).then((a){
            //
            //
            //     });
            //
            //     setState(() {
            //      // _file = selected;
            //     });
            //   } else {
            //     print("No file selected");
            //   }
            //
            //
            // },
            //     child: Text("Capture"))
          ],
        ),
      ),
    );
  }
}
