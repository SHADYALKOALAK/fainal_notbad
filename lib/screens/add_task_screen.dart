import 'dart:io';
import 'package:fainalnotbad/helbers/chickDataHelber.dart';
import 'package:fainalnotbad/helbers/converter_helper.dart';
import 'package:fainalnotbad/helbers/image_picker.dart';
import 'package:fainalnotbad/models/images_model.dart';
import 'package:fainalnotbad/models/task_model.dart';
import 'package:fainalnotbad/witgets/my_button.dart';
import 'package:fainalnotbad/witgets/my_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../FireBase/firebase_task_controller.dart';
import '../firebase/fb_storege_controller.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? taskModel;

  const AddTaskScreen({
    this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with ChickData, ImagePikerHelper, ConverterHelper {
  late TextEditingController nameEditingController;
  late TextEditingController notEditingController;
  List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    nameEditingController =
        TextEditingController(text: widget.taskModel?.title ?? '');
    notEditingController =
        TextEditingController(text: widget.taskModel?.not ?? '');
    if (widget.taskModel != null) {
      convertLinks();
    }
  }

  bool loaderImage = false;

  Future<void> convertLinks() async {
    setState(() => loaderImage = true);
    for (var item in widget.taskModel!.images!) {
      var file = await convertLinkToFile(item.link);
      imageFiles.add(file);
    }
    setState(() => loaderImage = false);
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    notEditingController.dispose();
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Not'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  var image = await choseMaltyImage();
                  imageFiles.addAll(image);
                  setState(() {});
                },
                child: loaderImage == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.orange, width: 1),
                        ),
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Colors.grey.shade400),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                        File(imageFiles[index].path),
                                        fit: BoxFit.cover),
                                  ),
                                  PositionedDirectional(
                                    end: -10,
                                    top: 1,
                                    bottom: -40,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() => imageFiles
                                            .remove(imageFiles[index]));
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10.w),
                            itemCount: imageFiles.length),
                      ),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                editingController: nameEditingController,
                hint: 'Please Enter Your Name Task',
                colorBackground: Colors.transparent,
                isBorderStyle: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              MyTextField(
                editingController: notEditingController,
                hint: 'please Enter Your Task  ',
                isBorderStyle: true,
                lines: 7,
                colorBackground: Colors.transparent,
              ),
              SizedBox(height: 20.h),
              loader == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        await clickData();
                      },
                      child: MyButton(
                        text: widget.taskModel == null ? 'Add' : 'Update',
                        sizeText: 15.sp,
                        colorButton: Colors.orange,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> clickData() async {
    setState(() => loader = true);
    String id = const Uuid().v4();
    List<ImagesModel> linksImages = [];
    for (File item in imageFiles) {
      var link =
          await FbStorageController().uploadFile(item, path: 'images/$id');
      if (link != null) {
        linksImages.add(link);
      }
    }
    await chick(id, linksImages);
  }

  Future<void> chick(String id, dynamic links) async {
    if (nameEditingController.text.isEmpty) {
      showSnackBar(context, 'please Enter Your title', true);
    } else if (notEditingController.text.isEmpty) {
      showSnackBar(context, "please Enter Your Not", true);
    } else {
      widget.taskModel == null
          ? FireBaseTaskController().insert(
              TaskModel(
                  id: id,
                  not: notEditingController.text,
                  images: links,
                  title: nameEditingController.text),
            )
          : FireBaseTaskController().update(TaskModel(
              id: widget.taskModel!.id,
              title: nameEditingController.text.trim(),
              not: notEditingController.text.trim(),
              images: links,
            ));
      if (context.mounted) {
        setState(() => loader = false);
        Navigator.pop(context);
      }
    }
  }
}
