import 'package:cached_network_image/cached_network_image.dart';
import 'package:fainalnotbad/FireBase/firebase_products_controller.dart';
import 'package:fainalnotbad/firebase/fb_storege_controller.dart';
import 'package:fainalnotbad/helbers/image_picker.dart';
import 'package:fainalnotbad/helbers/nav_helber.dart';
import 'package:fainalnotbad/models/task_model.dart';
import 'package:fainalnotbad/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with NavHelper, ImagePikerHelper {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = TrackingScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: const Icon(Icons.arrow_forward_rounded),
            onPressed: () {
              jump(context, const AddProductScreen(), false);
            },
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: const SizedBox(),
            backgroundColor: Colors.black,
            title: const Text('My Products '),
          ),
          backgroundColor: Colors.black,
          body: StreamBuilder(
            stream: FbProductsController().read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.orange,
                ));
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<ProductModel> list =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                  itemCount: list.length,
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 20.h, horizontal: 20.w),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () => jump(context,
                              AddProductScreen(productModel: list[index]), false),
                          splashColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 80.w, top: 10.h, bottom: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index].title ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    list[index].not!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 20.h,
                          end: 10.w,
                          child: InkWell(
                            onTap: () async {
                              await FbProductsController()
                                  .delete(list[index]);
                              for (var item in list[index].images!) {
                                await FbStorageController().delete(item.path);
                              }
                            },
                            splashColor: Colors.transparent,
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.all(3.w),
                          child: PositionedDirectional(
                            start: 0,
                            end: 10,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: 60.h,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.grey.shade300),
                              child: list[index].images != null
                                  ? PageView.builder(
                                      itemBuilder: (context, _) {
                                        return CachedNetworkImage(
                                            imageUrl:
                                                list[index].images![_].link,
                                            fit: BoxFit.cover);
                                      },
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: list.length,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                );
              } else {
                return Center(
                    child: Icon(
                  Icons.accessibility_new_outlined,
                  color: Colors.orange,
                  size: 100.h,
                ));
              }
            },
          ),
        ),
      ],
    );
  }
}
