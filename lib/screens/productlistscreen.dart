import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:posproject/utils/utils.dart';
import 'addproducts.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('product');
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProductForm()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Expanded(child: StreamBuilder(
          //   stream : ref.onValue,
          //   builder: (context,AsyncSnapshot <DatabaseEvent> snapshot) {
          //
          //     if (!snapshot.hasData){
          //       return const CircularProgressIndicator();
          //     } else {
          //       Map<dynamic , dynamic> map =snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //
          //       list.clear();
          //       list = map.values.toList();
          //       return ListView.builder(
          //           itemCount: snapshot.data?.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return const ListTile(
          //               title: Text('acid'),
          //             );
          //           });
          //     }
          //
          //   },
          // )),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  return ExpansionTile(
                    collapsedTextColor: Colors.black,
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
                    leading: const Icon(
                      Icons.inventory,
                      color: Colors.teal,
                    ),
                    title: Text(
                      snapshot.child('productname').value.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                    // title: Text( snapshot.child('productname').value.toString(),),
                    trailing: PopupMenuButton(
                      // Icon : (Icons.more_vert),
                      itemBuilder: (context) => [
                         const PopupMenuItem(
                            value: 1,
                              child: ExpansionTile(
                                // onExpansionChanged: (){
                                //   showMyDialog();
                                // },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                        const PopupMenuItem(
                            value: 2,
                            child: ExpansionTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete'),
                            )),
                      ],
                    ),
                    children: [
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 13),
                      //   child: Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text(
                      //       "Product Quantity :\t\t\t{(snapshot.child!('productquantity').value.toString()}",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 17,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ),
                      // ),
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
                }),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String productname , String id) async{
    return showDialog(
        context: context, builder: (BuildContext context) {
      return  AlertDialog(
        title: const Text('Update'),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Edit'
            ),
          ),
        ),
        actions:  [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text ('Cancel')),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              'productname' : editController.text.toLowerCase()
            }).then((value) {
              Utils().toastMessage('Product Updated');
              
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });
          }, child: const Text ('Update')),
        ],
      );
    }
    );
  }
}
