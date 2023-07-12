// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  ScrollController controller = ScrollController();
  List item = [];
  bool load = false;
  bool alload = false;

  fetch() async {
    if (alload) {
      return;
    }
    setState(() {
      load = true;
    });
    await Future.delayed(const Duration(microseconds: 500));
    List newdata = item.length >= 50
        ? []
        : List.generate(20, (index) => "List item ${index + item.length}");
    if (newdata.isNotEmpty) {
      item.addAll(newdata);
    }
  }

  @override
  void initState() {
    super.initState();

    fetch();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          !load) {
        if (kDebugMode) {
          print("NEWDATA CALl");
        }
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: item.length + (alload ? 1 : 0),
                controller: controller,
                itemBuilder: (
                  context,
                  index,
                ) {
                  if (index > item.length) {
                    return ListTile(
                      title: Text("$index"),
                    );
                  }
                  return null;
                }),
          ),
          if (load) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
