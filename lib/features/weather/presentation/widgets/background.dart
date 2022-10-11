import 'package:flutter/material.dart';

Color darkGrey = Color.fromRGBO(36, 34, 41, 1);

Color darkBlack = Color.fromRGBO(24, 22, 30, 1);

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
// back layer
    Paint paint1 = Paint();
    Path backClipPath = Path();

    backClipPath.lineTo(0.0, size.height * 0.8);
    var firstEndPoint = Offset(size.width * 0.35, size.height - 60.0);
    var firstControlPoint = Offset(size.width * 0.175, size.height - 10.0);
    backClipPath.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width * 0.7, size.height * 0.8);
    var secondControlPoint = Offset(size.width * 0.5, size.height * 0.7);
    backClipPath.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdEndPoint = Offset(size.width, size.height * 0.7);
    var thirdControlPoint = Offset(size.width * 0.85, size.height * 0.9);
    backClipPath.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    backClipPath.lineTo(size.width, 0.0);
    backClipPath.close();
    paint1.color = darkGrey;
    canvas.drawPath(backClipPath, paint1);

    //front layer
    Paint paint2 = Paint();
    Path frontClipPath = Path();

    frontClipPath.lineTo(0.0, size.height * 0.75);
    var firstEndP = Offset(size.width * 0.4, size.height * 0.7);
    var firstControlP = Offset(size.width * 0.2, size.height * 0.9);
    frontClipPath.quadraticBezierTo(
        firstControlP.dx, firstControlP.dy, firstEndP.dx, firstEndP.dy);

    var secondEndP = Offset(size.width * 0.8, size.height * 0.7);
    var secondControlP = Offset(size.width * 0.65, size.height * 0.55);
    frontClipPath.quadraticBezierTo(
        secondControlP.dx, secondControlP.dy, secondEndP.dx, secondEndP.dy);

    var thirdEndP = Offset(size.width, size.height * 0.7);
    var thirdControlP = Offset(size.width * 0.9, size.height * 0.8);
    frontClipPath.quadraticBezierTo(
        thirdControlP.dx, thirdControlP.dy, thirdEndP.dx, thirdEndP.dy);

    frontClipPath.lineTo(size.width, 0.0);
    frontClipPath.close();
    paint2.color = darkBlack;
    canvas.drawPath(frontClipPath, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
