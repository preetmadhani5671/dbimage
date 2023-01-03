import 'dart:typed_data';

import 'package:dbimage/dbhelper.dart';
import 'package:dbimage/screen/homeScreen/controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    DbHelper db = DbHelper();
    controller.l1.value = await db.readData();
    print(controller.l1.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Insert Data"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  ByteData byteData =
                      await rootBundle.load("assets/nature.jpg");
                  Uint8List uintList = byteData.buffer.asUint8List();
                  DbHelper db = DbHelper();
                  db.insertData("patil", "9825547715", uintList);
                  getdata();
                },
                child: Text("Insert"),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: controller.l1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.memory(controller.l1.value[index]['photo']),
                        title: Text(controller.l1[index]['name']),
                        subtitle: Text(controller.l1[index]['mobile']),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
