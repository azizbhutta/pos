import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'firestore/productfire.dart';

class ShakeebScreen extends StatefulWidget {
  const ShakeebScreen({Key? key}) : super(key: key);

  @override
  State<ShakeebScreen> createState() => _ShakeebScreenState();
}

class _ShakeebScreenState extends State<ShakeebScreen> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasepriceController = TextEditingController();
  final barcodeController = TextEditingController();


  var myScan;


  barCodeScanner() async {
    await FlutterBarcodeScanner.scanBarcode(
        "#FFBF00", "Cancel", true, ScanMode.BARCODE) .then((value) => setState(() => myScan = value));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return true;
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFeeeeee),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Products List',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () {
                barCodeScanner();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text ('Do you want to SignOut?'),
                      actions: [
                        TextButton(
                          child :const Text('Yes'),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.green,
                              textStyle: const TextStyle(
                                fontSize: 14,
                              )
                          ),

                        ),
                        TextButton(
                          child :const Text('No'),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor:Colors.green,
                              textStyle: const TextStyle(
                                fontSize:14,
                              )
                          ),
                        ),
                      ],
                    );
                  }
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').where('barcode', isEqualTo:  '$myScan').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          return ExpansionTile(
                            title: Text(snapshot.data!.docs[index]['productname'].toString()),
                            children: [
                              Text(snapshot.data!.docs[index]['barcode'].toString()),
                              Text(snapshot.data!.docs[index]['productquantity'].toString()),
                              Text(snapshot.data!.docs[index]['purchaseprice'].toString()),
                              Text(snapshot.data!.docs[index]['saleprice'].toString())
                            ],

                          );
                        },
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
