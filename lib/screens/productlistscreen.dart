import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'addproducts.dart';



class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final _auth =FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('product');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: const Text(
        'Products List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    backgroundColor: Colors.teal,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductForm()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      body: Column(
        children:  [
          Expanded(
            child:
              FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index){
                    return ExpansionTile(
                      title: Text(snapshot.child('productname').value.toString()
                      ),
                      children: [
                        Text(snapshot.child('productquantity').value.toString()),
                        Text(snapshot.child('purchaseprice').value.toString()),
                        Text(snapshot.child('saleprice').value.toString())
                      ],
                    );

                    // return  ListTile(
                    //   title: Text(snapshot.child('productname').value.toString()),
                    //   subtitle: Text(snapshot.child('saleprice').value.toString()),
                    //   // subtitle: Text(snapshot.child('productquantity').value.toString()),
                    //   // subtitle: Text(snapshot.child('purchaseprice').value.toString()),
                    // //     'barcode': barResult,
                    //
                    // );
                  }
                  ),
          ),
        ],
      ),
    );
  }
}
