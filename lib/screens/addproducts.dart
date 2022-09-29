import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:posproject/screens/productlistscreen.dart';
import 'package:posproject/utils/utils.dart';
import '../widgets/round_button.dart';
import 'login.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('product');

  final _formKey = GlobalKey<FormState>();
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasepriceController = TextEditingController();

  // String? barResult;
  // String? qrResult;
  String cameraStatus = "";

   barCodeScanner() async {
    await FlutterBarcodeScanner.scanBarcode(
          "#FFBF00", "Cancel", true, ScanMode.BARCODE) .then((value) => setState(() => barcodeController.text = value));
    }
    // } on PlatformException {
    //   result = "Failed to get platform version";
    // }
    // if (!mounted) return;
    // setState(() => barcodeController.text = value ));{
    //   if(result != barResult) {
    //     barResult = result;
    //   }else{
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already Exist this item")));
    //     return ;
    //   }
    // });
  // }
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

  // Future qrCodeScanner() async{
  //   String qResult;
  //   try{
  //     qResult = await FlutterBarcodeScanner.scanBarcode("#FFBF00", "Cancel", true, ScanMode.QR);
  //   } on PlatformException{
  //     qResult = "Failed to get Plateform Version";
  //   }
  //   if(!mounted) return;
  //   setState(() {
  //     qrResult = qResult;
  //   });
  // }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return true;
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFeeeeee),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Products',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () {
                // showMyDialog();
                _auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              // verticalDirection: VerticalDirection.down,
              children: [
                const SizedBox(height: 150,),
                Padding(
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
                ),

                // const SizedBox(height: 15.0),
                // Text(
                //   barResult == null
                //       ? "Scan a Code"
                //       : "Scan Result is : $barResult",
                //   style: const TextStyle(
                //       color: Colors.teal, fontWeight: FontWeight.bold),
                //
                // ),


                const SizedBox(
                  height: 50,
                ),
                Form(
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
                      ],
                    )),
                const SizedBox(
                  height: 40,
                ),
                RoundButton(
                  title: 'Add',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    String id =  DateTime.now().microsecondsSinceEpoch.toString();
                    databaseRef.child(id).set({
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // showMyDialog() async {
  //     context : context;
  //     builder : (context) => AlertDialog(
  //       title: Text ('Do You Want To Go Back?'),
  //         actions: [
  //               TextButton(
  //                 child :Text('Cancle'),
  //                     onPressed: () => Navigator.pop(context,false,),
  //                  ),
  //                 TextButton(
  //                      child :Text('Yes'),
  //                       onPressed: () => Navigator.pop(context,true,),
  //                  ),
  //              ],
  //           );
  //         }

}


