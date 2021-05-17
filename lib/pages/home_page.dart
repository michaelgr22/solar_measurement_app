import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackgroundImage(),
          SizedBox(
            width: double.infinity,
            height: 130,
          ),
          ButtonWithIcon(
            icon: Icons.image_search,
            text: 'Messungen',
            route: '/measurements',
          ),
          ButtonWithIcon(
            icon: Icons.wb_sunny_outlined,
            text: 'Vorhersage',
            route: '/predictions',
          ),
        ],
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  final icon;
  final text;
  final route;

  ButtonWithIcon(
      {@required this.icon, @required this.text, @required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        NavigationButton(
          text: text,
          route: route,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            icon,
            size: 40.0,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final text;
  final route;
  NavigationButton({@required this.text, @required this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
            minimumSize: Size(200.0, 50.0)),
        child: Text(text),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FittedBox(
        child: Image.asset(
          'assets/images/solar-energy-with-sky-background.jpg',
        ),
        fit: BoxFit.fill,
      ),
      width: double.infinity,
      height: 270.0,
    );
  }
}
