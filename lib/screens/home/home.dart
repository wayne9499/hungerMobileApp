import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger/screens/home/setting_form.dart';
import 'package:hunger/services/auth.dart';
import 'package:hunger/services/databases.dart';
import 'package:provider/provider.dart';
import 'package:hunger/screens/home/hungers_list.dart';
import 'package:hunger/models/objectModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Authservice _auth = Authservice();

  void _showBottomPanel() {
    showModalBottomSheet(context: context, backgroundColor: Colors.white, elevation: 0.0, isScrollControlled: true, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0),
      topRight: Radius.circular(45.0)),
    ), builder: (context) {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
        child: SettingForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ItemObject>>.value(
      value: DatabaseService().hungers, // stream in database.dart file
      child: Scaffold(
        drawer: Drawer(
          elevation: 0.0,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () async {
                  await _auth.signout();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.blueGrey),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text('hungers\'',
            style: TextStyle(
              letterSpacing: 3.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold
            ),
          ),
          actions: <Widget>[
            IconButton(onPressed: () => _showBottomPanel(), icon: Icon(Icons.settings, color: Colors.purple,))
          ],
        ),
        body: HungerList(),
      ),
    );
  }
}
