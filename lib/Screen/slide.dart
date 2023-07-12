import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> img = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class SLIDE extends StatefulWidget {
  const SLIDE({Key? key}) : super(key: key);

  @override
  State<SLIDE> createState() => _SLIDEState();
}

class _SLIDEState extends State<SLIDE> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final CarouselController _controller = CarouselController();
  int current = 0;
  bool visible = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    Timer(const Duration(seconds: 3), () {
      setState(() {
        visible = true;
      });
    });

    super.initState();
  }

  final List<Widget> imageSliders = img
      .map(
        (item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(item, fit: BoxFit.cover, width: 1000.0)),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Carousel with indicator controller demo')),
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     setState(() {
          //       visible =true;
          //     });
          //   },
          //   child: Text("VISIBLE"),
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Visibility(
              visible: visible,
              child: CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    }),
              ),
            ),
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25.0)),
            child: TabBar(
              indicator: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(25.0)),
              labelColor: Colors.white,
              controller: _tabController,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Chats',
                ),
                Tab(
                  text: 'Status',
                ),
                Tab(
                  text: 'Settings',
                )
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [
              Center(
                child: Text("Chats Pages"),
              ),
              Center(
                child: Text("Status Pages"),
              ),
              Center(
                child: Text('Settings Page'),
              )
            ],
          ))
        ],
      ),
    );
  }
}
