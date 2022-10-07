
// body: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// // mainAxisSize: MainAxisSize.max,
// // verticalDirection: VerticalDirection.down,
// children: [
// const SizedBox(height: 150,),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 100),
// child: MaterialButton(
// onPressed: checkpermission_opencamera,
// color: Colors.redAccent,
// shape: const StadiumBorder(),
// child: Row(
// children: const [
// Icon(
// Icons.camera_alt_outlined,
// ),
// SizedBox(
// width: 5.0,
// ),
// Text(
// "Scan Barcode",
// style: TextStyle(color: Colors.white,
// fontWeight: FontWeight.bold),
// )
// ],
// ),
// ),
// ),
//
// // const SizedBox(height: 15.0),
// // Text(
// //   barResult == null
// //       ? "Scan a Code"
// //       : "Scan Result is : $barResult",
// //   style: const TextStyle(
// //       color: Colors.teal, fontWeight: FontWeight.bold),
// //
// // ),
//
//
// const SizedBox(
// height: 50,
// ),
// Form(
// key: _formKey,
// child: Column(
// children: [
// TextFormField(
// controller: barcodeController,
// textInputAction: TextInputAction.next,
// cursorColor: Colors.teal,
// style: const TextStyle(color: Colors.teal),
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.teal),
// ),
// hintText: 'BarCode Id',
// // helperText : 'Enter Product Name',
// prefixIcon: Icon(
// Icons.qr_code_scanner_sharp,
// color: Colors.teal,
// ),
// ),
// validator: (value) {
// if (value!.isEmpty) {
// return 'Scan The BarCode';
// }
// return null;
// },
// ),
// TextFormField(
// controller: nameController,
// textInputAction: TextInputAction.next,
// cursorColor: Colors.teal,
// style: const TextStyle(color: Colors.teal),
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.teal),
// ),
// hintText: 'Product Name',
// // helperText : 'Enter Product Name',
// prefixIcon: Icon(
// Icons.inventory_2_outlined,
// color: Colors.teal,
// ),
// ),
// validator: (value) {
// // nameController.clear();
// if (value!.isEmpty) {
// return 'Enter Product Name';
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// keyboardType: TextInputType.number,
// controller: priceController,
// textInputAction: TextInputAction.next,
// cursorColor: Colors.teal,
// style: const TextStyle(color: Colors.teal),
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.teal),
// ),
// hintText: 'Sale Price',
// // helperText : 'Enter Product Price',
// prefixIcon: Icon(
// Icons.price_check_outlined,
// color: Colors.teal,
// ),
// ),
// validator: (value) {
// // priceController.clear();
// if (value!.isEmpty) {
// return 'Enter Product Price';
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// keyboardType: TextInputType.number,
// controller: quantityController,
// textInputAction: TextInputAction.next,
// cursorColor: Colors.teal,
// style: const TextStyle(color: Colors.teal),
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.teal),
// ),
// hintText: 'Product Quantity',
// // helperText : 'Enter Product Quantity',
// prefixIcon: Icon(
// Icons.queue_play_next_rounded,
// color: Colors.teal,
// ),
// ),
// validator: (value) {
// // quantityController.clear();
// if (value!.isEmpty) {
// return 'Enter Product Quantity';
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// keyboardType: TextInputType.number,
// controller: purchasepriceController,
// textInputAction: TextInputAction.done,
// cursorColor: Colors.teal,
// style: const TextStyle(color: Colors.teal),
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.teal),
// ),
// hintText: 'purchase price',
// // helperText : 'Enter Product purchase price',
// prefixIcon: Icon(
// Icons.price_change_outlined,
// color: Colors.teal,
// ),
// ),
// validator: (value) {
// // purchasepriceController.clear();
// if (value!.isEmpty) {
// return 'Enter Product purchase price';
// }
// return null;
// },
// ),
// ],
// )),
// const SizedBox(
// height: 40,
// ),
// RoundButton(
// title: 'Add',
// loading: loading,
// onTap: () {
// if (_formKey.currentState!.validate()) {
// setState(() {
// loading = true;
// });
//
// String id = DateTime
//     .now()
//     .microsecondsSinceEpoch
//     .toString();
// databaseRef.child(id).set({
// 'id': id,
// 'barcode': barcodeController.text.toString(),
// 'productname': nameController.text.toString(),
// 'saleprice': priceController.text.toString(),
// 'productquantity': quantityController.text.toString(),
// 'purchaseprice': purchasepriceController.text.toString()
// }).then((value) {
// Utils().toastMessage('Product Add');
// setState(() {
// loading = false;
// });
// }).onError((error, stackTrace) {
// Utils().toastMessage(error.toString());
// setState(() {
// loading = false;
// });
// });
// barcodeController.clear();
// nameController.clear();
// priceController.clear();
// quantityController.clear();
// purchasepriceController.clear();
// }
// },
// ),
// ],
// ),
// ),
// ),