import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: RiotButton(borderCut: 20)),
    );
  }
}

class RiotButton extends StatefulWidget {
  final double borderCut;
  final double width;
  final double height;
  RiotButton({
    @required this.borderCut,
    this.width = 195.0,
    this.height = 56.0
  });

  @override
  _RiotButtonState createState() => _RiotButtonState();
}

class _RiotButtonState extends State<RiotButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: BorderPainter(borderCut: widget.borderCut * (1 - _animation.value)),
      child: InkWell(
        onHover: (isHovered) => (isHovered) ? _animationController.forward() : _animationController.reverse(),
        onTap: (){},
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.all(4.0),
          color: Colors.lightBlue,
          child: Center(
            child: Text("Click Me!", style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  double borderCut;
  Offset leftCornerTopBorder;
  Offset topCornerLeftBorder;
  Offset rightCornerBottomBorder;
  Offset bottomCornerRightBorder;

  BorderPainter({@required this.borderCut});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black..strokeWidth = 1.0;

    topCornerLeftBorder = Offset(borderCut, 0.0);
    leftCornerTopBorder = Offset(0.0, borderCut);
    rightCornerBottomBorder = Offset(size.width, size.height - borderCut);
    bottomCornerRightBorder = Offset(size.width - borderCut, size.height);
    canvas.drawLine(topCornerLeftBorder, Offset(size.width, 0.0), paint);
    canvas.drawLine(Offset(size.width, 0.0), rightCornerBottomBorder, paint);
    canvas.drawLine(rightCornerBottomBorder, bottomCornerRightBorder, paint);
    canvas.drawLine(bottomCornerRightBorder, Offset(0.0, size.height), paint);
    canvas.drawLine(Offset(0.0, size.height), leftCornerTopBorder, paint);
    canvas.drawLine(leftCornerTopBorder, topCornerLeftBorder, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
