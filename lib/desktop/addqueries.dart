import 'package:autowheelweb/Utils/colors.dart';
import 'package:flutter/material.dart';

class AddQueries extends StatefulWidget {
   AddQueries({
    required this.index,
    super.key});
int index = 0;
  @override
  State<AddQueries> createState() => _AddQueriesState();
}

class _AddQueriesState extends State<AddQueries>with SingleTickerProviderStateMixin { 
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar( 
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
            centerTitle: true,
        title: Text('Add Enquiries', overflow: TextOverflow.ellipsis), bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: 'Enquiry Punched Today',icon: Icon(Icons.calendar_month),),
            Tab(text: 'Tomarrow Follow-ups',icon: Icon(Icons.person),),
            Tab(text: "Today's Follow-ups",icon:  Icon(Icons.verified_user),),
            Tab(text: 'Toatal Leads',icon: Icon(Icons.info),),
          ],
        ),
      ),
      backgroundColor: AppColor.colWhite,
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Tab 1 Content')),
          Center(child: Text('Tab 2 Content')),
          Center(child: Text('Tab 3 Content')),
          Center(child: Text('Tab 3 Content')),
        ],
      ),
    
    );
  }
}