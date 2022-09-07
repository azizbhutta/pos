import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:posproject/utils/utils.dart';
import '../widgets/round_button.dart';
import 'login.dart';


class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasepriceController= TextEditingController();

  String? barResult;
  // String? qrResult;

  Future barCodeScanner() async{

    String result;

    try{
      result = await FlutterBarcodeScanner.scanBarcode("#FFBF00", "Cancel" , true, ScanMode.BARCODE);
    } on PlatformException{
      result = "Failed to get platform version";
    }
    if(!mounted) return;
    setState(() {
      barResult = result;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
            'Add Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: const Icon(Icons.logout),),
          SizedBox(width: 10,)
        ],
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  onPressed: barCodeScanner,
                  color: Colors.teal,
                  shape: const StadiumBorder(),
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt_outlined,),
                      SizedBox(width: 5.0,),
                      Text("Scan Barcode", style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                barResult == null ? "Scan a Code" : "Scan Result is : $barResult",  style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        cursorColor: Colors.teal,
                        style: const TextStyle(color: Colors.teal),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          hintText: 'Product Name',
                          // helperText : 'Enter Product Name',
                          prefixIcon: Icon(Icons.inventory_2_outlined,color: Colors.teal,),
                        ),
                        validator: (value){
                          // nameController.clear();
                          if (value!.isEmpty){
                            return 'Enter Product Name';
                          }
                          return null;
                        } ,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        cursorColor: Colors.teal,
                        style: const TextStyle(color: Colors.teal),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          hintText: 'Sale Price',
                          // helperText : 'Enter Product Price',
                          prefixIcon: Icon(Icons.price_check_outlined,color: Colors.teal,),
                        ),
                        validator: (value){
                          // priceController.clear();
                          if (value!.isEmpty){
                            return 'Enter Product Price';
                          }
                          return null;
                        } ,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                        cursorColor: Colors.teal,
                        style: const TextStyle(color: Colors.teal),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          hintText: 'Product Quantity',
                          // helperText : 'Enter Product Quantity',
                          prefixIcon: Icon(Icons.queue_play_next_rounded,color: Colors.teal,),
                        ),
                        validator: (value){
                          // quantityController.clear();
                          if (value!.isEmpty){
                            return 'Enter Product Quantity';
                          }
                          return null;
                        } ,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: purchasepriceController,
                        cursorColor: Colors.teal,
                        style: const TextStyle(color: Colors.teal),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          hintText: 'purchase price',
                          // helperText : 'Enter Product purchase price',
                          prefixIcon: Icon(Icons.price_change_outlined,color: Colors.teal,),
                        ),
                        validator: (value){
                          // purchasepriceController.clear();
                          if (value!.isEmpty){
                            return 'Enter Product purchase price';
                          }
                          return null;
                        } ,
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 40,),
              RoundButton (
                title : 'Add Product',
                onTap: () {
                  if (_formKey.currentState!.validate()){
                  }
                  purchasepriceController.clear();
                },

              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 100),
              //   child: MaterialButton(
              //       onPressed: qrCodeScanner,
              //       color: Colors.black,
              //       shape: StadiumBorder(),
              //       child: Row(
              //         children: const [
              //           Icon(Icons.camera, color: Colors.white,),
              //           SizedBox(width: 5.0),
              //           Text("Scan QR Code", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              //         ],
              //       )
              //   ),
              // ),
              // SizedBox(height: 20,),
              // Text(
              //   qrResult == null ? "Scan QR Code" : "Scan QR Result is :   $qrResult", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              // )
            ],
          ),
         ),
      ),
    );
  }
}

