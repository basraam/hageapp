import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxahaaga/kooxahaaga.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxoGuud/kooxoGuud.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import 'package:iconsax/iconsax.dart';

class groups extends StatelessWidget {
  final String UserId;
  const groups({super.key, required this.UserId});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Kooxo',
              style: TextStyle(color: Colors.green),
            ),
            centerTitle: true,
            backgroundColor: BColors.backgroundColor,
            bottom: const TabBar(
              labelColor: BColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green,
              tabs: [
                Tab(icon: Icon(Icons.group_add), text: 'Kooxo Guud'),
                Tab(icon: Icon(Icons.group), text: 'Kooxahaaga'),


              ],
            ),
          ),
          body: TabBarView(
            children: [
              kooxoGuud(userId: UserId,),
              Kooxahaaga(),
            ],
          ),
        ));

  }
}