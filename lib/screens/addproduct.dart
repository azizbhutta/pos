import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posproject/screens/productlist.dart';
import 'package:posproject/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductFire extends StatefulWidget {
  const ProductFire({Key? key}) : super(key: key);

  @override
  State<ProductFire> createState() => _ProductFireState();
}

class _ProductFireState extends State<ProductFire> {
  bool loading = false;


  final _formKey = GlobalKey<FormState>();
  TextEditingController barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasepriceController = TextEditingController();


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // String? barResult;
  // String? qrResult;
  String cameraStatus = "";
  String? myScan;
  String? id;

  final fireStore = FirebaseFirestore.instance.collection('products');
  CollectionReference ref = FirebaseFirestore.instance.collection('products');

  barCodeScanner() async {
    await FlutterBarcodeScanner.scanBarcode(
        "#FFBF00", "Cancel", true, ScanMode.BARCODE) .then((value) => setState(() => myScan = value));
  }

  checkpermission_opencamera()async {
    PermissionStatus camerStatus = await Permission.camera.request();
    if (camerStatus == PermissionStatus.granted) {
      barCodeScanner();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission Granted")));
    }
    if (camerStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You Need To Provide Camera Permission.")));
    }
    if (camerStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  final _auth = FirebaseAuth.instance;

  bool isSelected = false;

  scanner(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: MaterialButton(
        onPressed: checkpermission_opencamera,
        color: Colors.redAccent,
        shape: const StadiumBorder(),
        child: Row(
          children: const [
            Icon(
              Icons.camera_alt_outlined,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              "Scan Barcode",
              style: TextStyle(color : Colors.white,fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    barcodeController.dispose();
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    purchasepriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return true;
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFeeeeee),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Products',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListFireScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: checkpermission_opencamera,
              icon: const Icon(
                Icons.qr_code_scanner_sharp,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        resizeToAvoidBottomInset : false,
        body: Padding(
          padding: const EdgeInsets.only(top: 150, left: 30,right: 30),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('products').where('barcode', isEqualTo:  '$myScan').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(snapshot.hasData && snapshot.data?.size == 0){
                  barcodeController.text = "no data";
                  barcodeController.text = myScan.toString();
                  return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: barcodeController,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.teal,
                            style: const TextStyle(color: Colors.teal),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              hintText: 'BarCode Id',
                              labelText: "Scan Barcode",
                              // helperText : 'Enter Product Name',
                              prefixIcon: Icon(
                                Icons.qr_code_scanner_sharp,
                                color: Colors.teal,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Scan The BarCode';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.teal,
                            style: const TextStyle(color: Colors.teal),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              hintText: 'Product Name',
                              // helperText : 'Enter Product Name',
                              prefixIcon: Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.teal,
                              ),
                            ),
                            validator: (value) {
                              // nameController.clear();
                              if (value!.isEmpty) {
                                return 'Enter Product Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.teal,
                            style: const TextStyle(color: Colors.teal),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              hintText: 'Sale Price',
                              // helperText : 'Enter Product Price',
                              prefixIcon: Icon(
                                Icons.price_check_outlined,
                                color: Colors.teal,
                              ),
                            ),
                            validator: (value) {
                              // priceController.clear();
                              if (value!.isEmpty) {
                                return 'Enter Product Price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: quantityController,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.teal,
                            style: const TextStyle(color: Colors.teal),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              hintText: 'Product Quantity',
                              // helperText : 'Enter Product Quantity',
                              prefixIcon: Icon(
                                Icons.queue_play_next_rounded,
                                color: Colors.teal,
                              ),
                            ),
                            validator: (value) {
                              // quantityController.clear();
                              if (value!.isEmpty) {
                                return 'Enter Product Quantity';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: purchasepriceController,
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.teal,
                            style: const TextStyle(color: Colors.teal),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              hintText: 'purchase price',
                              // helperText : 'Enter Product purchase price',
                              prefixIcon: Icon(
                                Icons.price_change_outlined,
                                color: Colors.teal,
                              ),
                            ),
                            validator: (value) {
                              // purchasepriceController.clear();
                              if (value!.isEmpty) {
                                return 'Enter Product purchase price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MaterialButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                String id =  DateTime.now().microsecondsSinceEpoch.toString();
                                fireStore.doc(id).set({
                                  'id' :id,
                                  'barcode': barcodeController.text.toString(),
                                  'productname': nameController.text.toString(),
                                  'saleprice': priceController.text.toString(),
                                  'productquantity': quantityController.text.toString(),
                                  'purchaseprice': purchasepriceController.text.toString()

                                }).then((value){
                                  Utils().toastMessage('Product Add');
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => const ProductListFireScreen())
                                  );
                                }).onError((error, stackTrace){
                                  Utils().toastMessage(error.toString());
                                  setState(() {
                                    loading = false;
                                  });
                                });
                                barcodeController.clear();
                                nameController.clear();
                                priceController.clear();
                                quantityController.clear();
                                purchasepriceController.clear();
                              }
                            },
                            minWidth: 150.0,
                            height: 35,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Colors.redAccent,
                            child: const Text('Add',
                                style: TextStyle(fontSize: 16.0, color: Colors.white)),

                          ),
                        ],
                      ));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index){

                    barcodeController.text = myScan!;
                    nameController.text = snapshot.data!.docs[index]['productname'].toString();
                    priceController.text = snapshot.data!.docs[index]['saleprice'].toString();
                    quantityController.text = snapshot.data!.docs[index]['productquantity'].toString();
                    purchasepriceController.text = snapshot.data!.docs[index]['purchaseprice'].toString();
                    id = snapshot.data!.docs[index]['id'].toString();

                    return Column(
                      children: [
                        TextFormField(
                          controller: barcodeController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          style: const TextStyle(color: Colors.teal),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            hintText: 'BarCode Id',
                            // helperText : 'Enter Product Name',
                            prefixIcon: Icon(
                              Icons.qr_code_scanner_sharp,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Scan The BarCode';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          style: const TextStyle(color: Colors.teal),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            hintText: 'Product Name',
                            // helperText : 'Enter Product Name',
                            prefixIcon: Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (value) {
                            // nameController.clear();
                            if (value!.isEmpty) {
                              return 'Enter Product Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          style: const TextStyle(color: Colors.teal),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            hintText: 'Sale Price',
                            // helperText : 'Enter Product Price',
                            prefixIcon: Icon(
                              Icons.price_check_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (value) {
                            // priceController.clear();
                            if (value!.isEmpty) {
                              return 'Enter Product Price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: quantityController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          style: const TextStyle(color: Colors.teal),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            hintText: 'Product Quantity',
                            // helperText : 'Enter Product Quantity',
                            prefixIcon: Icon(
                              Icons.queue_play_next_rounded,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (value) {
                            // quantityController.clear();
                            if (value!.isEmpty) {
                              return 'Enter Product Quantity';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: purchasepriceController,
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.teal,
                          style: const TextStyle(color: Colors.teal),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            hintText: 'purchase price',
                            // helperText : 'Enter Product purchase price',
                            prefixIcon: Icon(
                              Icons.price_change_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (value) {
                            // purchasepriceController.clear();
                            if (value!.isEmpty) {
                              return 'Enter Product purchase price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        MaterialButton(
                          onPressed: (){
                            fireStore.doc(id).update({
                              "productname": nameController.text,
                              "saleprice": priceController.text,
                              "productquantity": quantityController.text,
                              "purchaseprice": purchasepriceController.text,
                            }).then((value) {
                              Fluttertoast.showToast(msg: "Product Updated");
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const ProductListFireScreen())
                              );
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(msg: error.toString());
                            });
                            barcodeController.clear();
                            nameController.clear();
                            priceController.clear();
                            quantityController.clear();
                            purchasepriceController.clear();
                          },
                          minWidth: 150.0,
                          height: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.redAccent,
                          child: const Text('Update',
                              style: TextStyle(fontSize: 16.0, color: Colors.white)),

                        ),
                      ],
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}
