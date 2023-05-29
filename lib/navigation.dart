import 'package:bts_emprunt/page/actifs/actif.dart';
import 'package:bts_emprunt/page/emprunteur/emprunteur.dart';
import 'package:bts_emprunt/page/livre/livre.dart';
import 'package:flutter/material.dart';

class NavRailExample extends StatefulWidget {
  NavRailExample({super.key});

  @override
  final selectedIndex = _NavRailExampleState().selectedIndex;
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = 0.0;

  List<Widget> pageList = [Livre(), emprunteur(), actif()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: selectedIndex,
            groupAlignment: groupAligment,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            labelType: labelType,
            leading: showLeading
                ? FloatingActionButton(
              elevation: 0,
              onPressed: () {

              },
              child: const Icon(Icons.add),
            )
                : const SizedBox(),
            trailing: showTrailing
                ? IconButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.more_horiz_rounded),
            )
                : const SizedBox(),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.menu_book),
                selectedIcon: Icon(Icons.menu_book),
                label: Text('Mes livres'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Emprunteur'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.handshake),
                selectedIcon: Icon(Icons.handshake),
                label: Text('Emprunt actifs'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child:  pageList[selectedIndex],
          ),
        ],
      ),
    );
  }
}
