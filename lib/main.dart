import 'package:flutter/material.dart';

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  int _count = 0;

  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
        initialIndex: 1,
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Sample'),
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor:
                shadowColor ? Theme.of(context).colorScheme.shadow : null,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: const Icon(Icons.cloud_outlined),
                  text: titles[0],
                ),
                Tab(
                  icon: const Icon(Icons.beach_access_sharp),
                  text: titles[1],
                ),
                Tab(
                  icon: const Icon(Icons.brightness_5_sharp),
                  text: titles[2],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: index.isOdd ? oddItemColor : evenItemColor,
                    title: Text('${titles[0]} $index'),
                    subtitle:
                        Text('You have pressed the button $_count times.'),
                  );
                },
              ),
              ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: index.isOdd ? oddItemColor : evenItemColor,
                    title: Text('${titles[1]} $index'),
                    subtitle:
                        Text('You have pressed the button $_count times.'),
                  );
                },
              ),
              ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: index.isOdd ? oddItemColor : evenItemColor,
                    title: Text('${titles[2]} $index'),
                    subtitle:
                        Text('You have pressed the button $_count times.'),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                alignment: MainAxisAlignment.center,
                overflowSpacing: 5.0,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        shadowColor = !shadowColor;
                      });
                    },
                    icon: Icon(
                      shadowColor ? Icons.visibility_off : Icons.visibility,
                    ),
                    label: const Text('shadow color'),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      if (scrolledUnderElevation == null) {
                        setState(() {
                          // Default elevation is 3.0, increment by 1.0.
                          scrolledUnderElevation = 4.0;
                        });
                      } else {
                        setState(() {
                          scrolledUnderElevation =
                              scrolledUnderElevation! + 1.0;
                        });
                      }
                    },
                    child: Text(
                      'scrolledUnderElevation: ${scrolledUnderElevation ?? 'default'}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() {
              _count++;
            }),
            tooltip: 'Increment Counter',
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
