import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class FondoLogin extends StatelessWidget {
  const FondoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoVerde = Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(color: colorPrincipal));

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoVerde,
        Positioned(top: 40, child: circulo),
        Positioned(top: 90, left: 250, child: circulo),
        Container(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              const SizedBox(height: 20.0, width: double.infinity),
              Center(
                  child: Image.asset(
                "lib/assets/logoinventarygo.png",
                height: 120,
              ))
            ],
          ),
        )
      ],
    );
  }
}
