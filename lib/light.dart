


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Light extends StatefulWidget {
  const Light({Key? key}) : super(key: key);

  @override
  State<Light> createState() => _LightState();
}

class _LightState extends State<Light> with SingleTickerProviderStateMixin{


  bool _isLight = false;
  late AnimationController _controller;
  
  late double _doublescale;

  @override
  void initState() {
    _controller = AnimationController(
        vsync : this,
        duration: Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: 0.1,
    )..addListener(() {
      setState((){});
    });

    super.initState();
  }

  @override
  void dispose() {
_controller.dispose();
   super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _doublescale = 1 - _controller.value;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: _isLight ? Colors.yellow : Colors.grey.shade700
              )
          ),
          _isLight ? 
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 74,
                  right: MediaQuery.of(context).size.width / 2 -74,
                  top: 430,
                  child: Transform.scale(
                    scale: _doublescale,
                    child: Transform.rotate(
                        angle: 3.15,
                    child: GestureDetector(
                      onTap: () {
                        setState((){
                          _isLight = false;
                        });
                      },
                      child: Image.asset("assets/images/light/light.png"),
                    )
                    ),
                    
                  )
              ):
          Positioned(
              left: MediaQuery.of(context).size.width / 2 - 74,
              right: MediaQuery.of(context).size.width / 2 -74,
              top: 430,
              child: Transform.scale(
                scale: _doublescale,
                child: Transform.rotate(
                    angle: 3.15,
                    child: GestureDetector(
                      onTap: () {
                        setState((){
                          _isLight = true;
                        });
                      },
                      child: Image.asset("assets/images/light/dark.png"),
                    )
                ),

              )
          )

        ],
      ),
    );
  }
}
