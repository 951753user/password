import 'package:flutter/material.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  TextEditingController t1 = TextEditingController();
  int item = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HRA Calculator'),
        ),
        body: Column(
          children: [
            TextField(
              controller: t1,
              onChanged: (val) {},
            ),
            ElevatedButton(onPressed: (){
              item = int.parse(t1.text);
              setState(() {

              });
            }, child: Text("FIND")),
            Expanded(
              child: GridView.builder(
                  itemCount: item,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                            child: (index % 2 == 0)
                                ? Container(
                                    height: 500,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text("${index + 1}"),
                                    ),
                                  )
                                : Container()),
                        Expanded(
                            child: (index % 2 == 1)
                                ? Container(
                                    height: 500,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text("${index + 1}"),
                                    ),
                                  )
                                : Container()),
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}
