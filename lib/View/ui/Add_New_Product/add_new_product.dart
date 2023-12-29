import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';
import 'package:wmax_devs_task/View/common_widget/custom_button.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';
import 'package:wmax_devs_task/View/ui/Add_New_Product/widgets/custom_text_field_widget.dart';
import 'package:wmax_devs_task/View/ui/Cart/Controller/cart_controller.dart';
import 'dart:io';


class NewProductAddScreen extends StatefulWidget {
  const NewProductAddScreen({super.key});

  @override
  State<NewProductAddScreen> createState() => _NewProductAddScreenState();
}

class _NewProductAddScreenState extends State<NewProductAddScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final picker = ImagePicker();
  bool isImageLoading = false;
  String? path;
  File? _image;

  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "New Product Entry",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _sizedBox(size.height / 40, 0),
            Center(
              child: GestureDetector(
                onTap: () {
                  showOptions();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0,
                              8), // Offset changes the position of the shadow
                        )
                      ],
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 2, // Border width
                      ),
                      borderRadius: BorderRadius.circular(2)),
                  height: size.height / 3,
                  width: size.width / 1.15,
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black.withOpacity(.5),
                                size: 100,
                              ),
                              SizedBox(
                                height: size.height / 50,
                              ),
                              const Text(
                                "Tap to open Camera",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )
                      : Image(
                          image: FileImage(_image!),
                          fit: BoxFit.fill,
                          height: size.height,
                        ),
                ),
              ),
            ),
            _sizedBox(size.height / 20, 0),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: CustomTextWidget(
                      text: "Title   : ",
                      fSize: 18,
                      textAlign: TextAlign.end,
                    )),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 200,
                    child: CustomTextFieldWidget(
                      text: "Product Name",
                      controller: _productNameController,
                    ),
                  ),
                ),
              ],
            ),
            _sizedBox(10, 0),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: CustomTextWidget(
                      text: "Price   : ",
                      fSize: 18,
                      textAlign: TextAlign.end,
                    )),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 200,
                    child: CustomTextFieldWidget(
                      textInputType: TextInputType.number,
                      text: "Product Amount",
                      controller: _productPriceController,
                    ),
                  ),
                ),
              ],
            ),
            _sizedBox(10, 0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                    flex: 2,
                    child: CustomTextWidget(
                      text: "Description   : ",
                      fSize: 18,
                      textAlign: TextAlign.end,
                    )),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 200,
                    child: CustomTextFieldWidget(
                      maxLine: 3,
                      text: "Description",
                      controller: _descriptionController,
                    ),
                  ),
                ),
              ],
            ),
            _sizedBox(size.height / 20, 0),
            CustomButtonWidget(onTap: () async{
              await addNewProductFunction();
            }, title: "Add product")
          ],
        ),
      ),
    );
  }

  SizedBox _sizedBox(double height, double width) => SizedBox(
        height: height,
        width: width,
  );
  Future getImageFromDevice(String imgSource) async {
    XFile? pickedFile ;
    if(imgSource == "Camera"){
       pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
       pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      path = pickedFile.path;
    }
    isImageLoading = false;
    setState(() {});
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromDevice("Camera");
              isImageLoading = true;
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromDevice("Gallery");
              isImageLoading = true;
            },
          ),
        ],
      ),
    );
  }

  Future<void> addNewProductFunction()async{
    if(_image == null || _productPriceController.text.isEmpty){
      CustomSnackBar().showSnackBar(title: "Message", message: "Failed !!",color: LightThemeData().errorColor);
      return;
    }
     CartListHiveModel data = CartListHiveModel(
        id: 00,
        title: _productNameController.text,
        price: double.parse(_productPriceController.text),
        image: "",
        category: "Device Image",
        description: _descriptionController.text,
        localImage: _image!.path.toString()
    );
    Box<CartListHiveModel> box = Hive.box<CartListHiveModel>("cart_list_product2");
    await box.add(data);
    cartController.cartList.add(data);
    CustomSnackBar().showSnackBar(title: "Message", message: "New Product Added Successful!!");
    if(mounted){
      Navigator.pop(context);
    }
    return;
  }
}
