import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        AuthBackgorundC1(),
        SafeArea(
          child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10),
          child: const Icon(
            Icons.person_pin_circle_rounded,
            color: Colors.white,
            size: 100,
          ),
        )),
        child,
      ]),
    );
  }
}

class AuthBackgorundC1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size_screen = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size_screen.height * 0.4,
      decoration: orangeDecoration(),
      child: Stack(
        children: [
          Positioned(
            child: Bubble(),
            top: 85,
            left: 45,
          ),
          Positioned(
            child: Bubble(),
            top: -35,
            left: -25,
          ),
          Positioned(
            child: Bubble(),
            top: -50,
            right: -40,
          ),
          Positioned(
            child: Bubble(),
            bottom: -30,
            left: -12,
          ),
          Positioned(
            child: Bubble(),
            bottom: -50,
            left: -20,
          ),
          Positioned(
            child: Bubble(),
            bottom: 100,
            right: 15,
          ),
          Positioned(
            child: Bubble(),
            bottom: 10,
            right: 70,
          ),
        ],
      ),
    );
  }

  BoxDecoration orangeDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(255, 165, 0, 1),
        Color.fromRGBO(255, 100, 2, 1),
      ]));
}

class Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.15)),
    );
  }
}