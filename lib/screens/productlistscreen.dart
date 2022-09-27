import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


  // final editController = TextEditingController();
  final searchFilterController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasepriceController = TextEditingController();

   String? productName;
  String? salePrice;
  String? purchasePrice;
  String? productQuantity;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
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
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchFilterController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                      border: OutlineInputBorder()
                ),
                onChanged: (String value){
                  setState(() {

                  });
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {

                    final productName =
                    snapshot.child('productname').value.toString();
                    if(searchFilterController.text.isEmpty){
                      return ExpansionTile(
                        collapsedTextColor: Colors.black,
                        textColor: Colors.redAccent,
                        iconColor: Colors.redAccent,
                        leading: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.teal,
                        ),
                        title: Text(
                          snapshot.child('productname').value.toString(),                      style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                        ),

                        // trailing: PopupMenuButton(
                        //    // icon : (Icons.more_vert),
                        //   itemBuilder: (context) => [
                        //      const PopupMenuItem(
                        //         value: 1,
                        //           child: ExpansionTile(
                        //             trailing: Icon(null),
                        //              // onExpansionChanged: (){
                        //              // Navigator.pop(context);
                        //              //     showMyDialog(productName);},
                        //             leading: Icon(Icons.mode_edit_outline_outlined),
                        //             title: Text('Edit'),
                        //           ),
                        //         ),
                        //     const PopupMenuItem(
                        //         value: 2,
                        //         child: ExpansionTile(
                        //           trailing: Icon(null),
                        //             // ref.child(snapshot.child('products').value.toString()).remove();
                        //           leading: Icon(Icons.delete_outline),
                        //           title: Text('Delete'),
                        //         )),
                        //   ],
                        // ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Sale Price" +
                                    "                                      " + salePrice.toString(),
                                // snapshot.child('saleprice').value.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Product Quantity" +
                                    "                           " + productQuantity.toString(),

                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Purchase Price" +
                                    "                               " + purchasePrice.toString(),
                                // snapshot.child('saleprice').value.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "Update Data",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                width: 180,
                              ),
                              IconButton(onPressed: (){
                                showMyDialog(
                                  snapshot.child("productname").value.toString(),
                                  snapshot.child("saleprice").value.toString(),
                                  snapshot.child("productquantity").value.toString(),
                                  snapshot.child("purchaseprice").value.toString(),
                                  snapshot.child("id").value.toString(),
                                );
                              }, icon: Icon(Icons.edit, color: Colors.green,))

                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "Delete Data",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                width: 180,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: const Text(
                                                "Are you sure you want to delete, if yes then press delete"),
                                            actions: [
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      ref.child(snapshot.child("id").value.toString()).remove();
                                                      setState(() {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
                                                      });
                                                    },
                                                    color: Colors.redAccent,
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 25,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      );
                    }else if(productName.toLowerCase().contains(searchFilterController.text.toLowerCase())){
                      return ExpansionTile(
                        collapsedTextColor: Colors.black,
                        textColor: Colors.redAccent,
                        iconColor: Colors.redAccent,
                        leading: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.teal,
                        ),
                        title: Text(
                          snapshot.child('productname').value.toString(),                      style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Sale Price" +
                                    "                                      " + salePrice.toString(),
                                // snapshot.child('saleprice').value.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Product Quantity" +
                                    "                           " + productQuantity.toString(),

                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Purchase Price" +
                                    "                               " + purchasePrice.toString(),
                                // snapshot.child('saleprice').value.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "Update Data",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                width: 180,
                              ),
                              IconButton(onPressed: (){
                                showMyDialog(
                                  snapshot.child("productname").value.toString(),
                                  snapshot.child("saleprice").value.toString(),
                                  snapshot.child("productquantity").value.toString(),
                                  snapshot.child("purchaseprice").value.toString(),
                                  snapshot.child("id").value.toString(),
                                );
                              }, icon: Icon(Icons.edit, color: Colors.green,))

                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "Delete Data",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                width: 180,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: const Text(
                                                "Are you sure you want to delete, if yes then press delete"),
                                            actions: [
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      ref.child(snapshot.child("id").value.toString()).remove();
                                                      setState(() {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
                                                      });
                                                    },
                                                    color: Colors.redAccent,
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 25,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      );
                    }else {
                      return Container();
                    }

                 // productName =
                 //        snapshot.child('productname').value.toString();
                 //    salePrice =
                 //        snapshot.child('saleprice').value.toString();
                 //    productQuantity =
                 //        snapshot.child('productquantity').value.toString();
                 //    purchasePrice =
                 //        snapshot.child('purchaseprice').value.toString();
                 //    return ExpansionTile(
                 //      collapsedTextColor: Colors.black,
                 //      textColor: Colors.redAccent,
                 //      iconColor: Colors.redAccent,
                 //      leading: const Icon(
                 //        Icons.inventory_2_outlined,
                 //        color: Colors.teal,
                 //      ),
                 //      title: Text(
                 //        snapshot.child('productname').value.toString(),                      style: const TextStyle(
                 //            fontWeight: FontWeight.w800, fontSize: 17),
                 //      ),
                 //
                 //      // trailing: PopupMenuButton(
                 //      //    // icon : (Icons.more_vert),
                 //      //   itemBuilder: (context) => [
                 //      //      const PopupMenuItem(
                 //      //         value: 1,
                 //      //           child: ExpansionTile(
                 //      //             trailing: Icon(null),
                 //      //              // onExpansionChanged: (){
                 //      //              // Navigator.pop(context);
                 //      //              //     showMyDialog(productName);},
                 //      //             leading: Icon(Icons.mode_edit_outline_outlined),
                 //      //             title: Text('Edit'),
                 //      //           ),
                 //      //         ),
                 //      //     const PopupMenuItem(
                 //      //         value: 2,
                 //      //         child: ExpansionTile(
                 //      //           trailing: Icon(null),
                 //      //             // ref.child(snapshot.child('products').value.toString()).remove();
                 //      //           leading: Icon(Icons.delete_outline),
                 //      //           title: Text('Delete'),
                 //      //         )),
                 //      //   ],
                 //      // ),
                 //      children: [
                 //         Padding(
                 //          padding: const EdgeInsets.only(left: 13),
                 //          child: Align(
                 //            alignment: Alignment.topLeft,
                 //            child: Text(
                 //              "Sale Price" +
                 //                  "                                      " + salePrice.toString(),
                 //                  // snapshot.child('saleprice').value.toString(),
                 //              style: const TextStyle(
                 //                  color: Colors.black,
                 //                  fontSize: 17,
                 //                  fontWeight: FontWeight.w400),
                 //            ),
                 //          ),
                 //        ),
                 //        const SizedBox(
                 //          height: 5.0,
                 //        ),
                 //        Padding(
                 //          padding: const EdgeInsets.only(left: 13),
                 //          child: Align(
                 //            alignment: Alignment.topLeft,
                 //            child: Text(
                 //              "Product Quantity" +
                 //                  "                           " + productQuantity.toString(),
                 //
                 //              style: const TextStyle(
                 //                  color: Colors.black,
                 //                  fontSize: 17,
                 //                  fontWeight: FontWeight.w400),
                 //            ),
                 //          ),
                 //        ),
                 //        const SizedBox(
                 //          height: 5.0,
                 //        ),
                 //        Padding(
                 //          padding: const EdgeInsets.only(left: 13),
                 //          child: Align(
                 //            alignment: Alignment.topLeft,
                 //            child: Text(
                 //              "Purchase Price" +
                 //                  "                               " + purchasePrice.toString(),
                 //              // snapshot.child('saleprice').value.toString(),
                 //              style: const TextStyle(
                 //                  color: Colors.black,
                 //                  fontSize: 17,
                 //                  fontWeight: FontWeight.w400),
                 //            ),
                 //          ),
                 //        ),
                 //        const SizedBox(
                 //          height: 5.0,
                 //        ),
                 //        Row(
                 //          children: [
                 //            const Padding(
                 //              padding: EdgeInsets.only(left: 14),
                 //              child: Text(
                 //                "Update Data",
                 //                style: TextStyle(
                 //                    color: Colors.black,
                 //                    fontWeight: FontWeight.bold,
                 //                    fontSize: 18),
                 //              ),
                 //            ),
                 //            const SizedBox(
                 //              width: 180,
                 //            ),
                 //            IconButton(onPressed: (){
                 //              showMyDialog(
                 //                snapshot.child("productname").value.toString(),
                 //                snapshot.child("saleprice").value.toString(),
                 //                snapshot.child("productquantity").value.toString(),
                 //                snapshot.child("purchaseprice").value.toString(),
                 //                snapshot.child("id").value.toString(),
                 //              );
                 //            }, icon: Icon(Icons.edit, color: Colors.green,))
                 //
                 //          ],
                 //        ),
                 //        const SizedBox(height: 10),
                 //        Row(
                 //          children: [
                 //            const Padding(
                 //              padding: EdgeInsets.only(left: 14),
                 //              child: Text(
                 //                "Delete Data",
                 //                style: TextStyle(
                 //                    color: Colors.black,
                 //                    fontWeight: FontWeight.bold,
                 //                    fontSize: 18),
                 //              ),
                 //            ),
                 //            const SizedBox(
                 //              width: 180,
                 //            ),
                 //            GestureDetector(
                 //                onTap: () {
                 //                  showDialog(
                 //                      context: context,
                 //                      builder: (BuildContext context) {
                 //                        return AlertDialog(
                 //                          content: const Text(
                 //                              "Are you sure you want to delete, if yes then press delete"),
                 //                          actions: [
                 //                            const SizedBox(
                 //                              height: 4.0,
                 //                            ),
                 //                            Row(
                 //                              mainAxisAlignment:
                 //                                  MainAxisAlignment.spaceEvenly,
                 //                              children: [
                 //                                MaterialButton(
                 //                                  onPressed: () {
                 //                                     ref.child(snapshot.child("id").value.toString()).remove();
                 //                                     setState(() {
                 //                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
                 //                                     });
                 //                                  },
                 //                                  color: Colors.redAccent,
                 //                                  child: const Text(
                 //                                    "Delete",
                 //                                    style: TextStyle(
                 //                                        color: Colors.white),
                 //                                  ),
                 //                                ),
                 //                                MaterialButton(
                 //                                  color: Colors.green,
                 //                                  onPressed: () {
                 //                                    Navigator.pop(context);
                 //                                  },
                 //                                  child: const Text(
                 //                                    "No",
                 //                                    style: TextStyle(
                 //                                        color: Colors.white),
                 //                                  ),
                 //                                )
                 //                              ],
                 //                            )
                 //                          ],
                 //                        );
                 //                      });
                 //                },
                 //                child: const Icon(
                 //                  Icons.delete,
                 //                  color: Colors.red,
                 //                  size: 25,
                 //                ))
                 //          ],
                 //        ),
                 //        const SizedBox(
                 //          height: 20,
                 //        ),
                 //
                 //      ],
                 //    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  showMyDialog(String producdName, String salePrice, String productQuantity, String purchasePrice, String id) async {
    // nameController.text = products;
    nameController.text = producdName;
    priceController.text = salePrice.toString();
    purchasepriceController.text = purchasePrice.toString();
    quantityController.text = productQuantity.toString();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Column(
               children: [
                 TextFormField(
                   controller: nameController,
                   decoration: const InputDecoration(
                     hintText: "Product Name",
                   ),
                 ),
                 const SizedBox(height: 10,),
                 TextFormField(
                   controller: priceController,
                   decoration: const InputDecoration(
                     hintText: "Sale Price",
                   ),
                 ),
                 const SizedBox(height: 10,),
                 TextFormField(
                   controller: quantityController,
                   decoration: const InputDecoration(
                     hintText: "Product Quantity",
                   ),
                 ),
                 const SizedBox(height: 10,),
                 TextFormField(
                   controller: purchasepriceController,
                   decoration: const InputDecoration(
                     hintText: "Purchase Price",
                   ),
                 )
               ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      "productname": nameController.text.toLowerCase(),
                      "saleprice": priceController.text,
                      "productquantity": quantityController.text,
                      "purchaseprice": purchasepriceController.text,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Post Updated");
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                    });
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }
}
