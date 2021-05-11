import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class DifferentWidgets extends StatefulWidget {
  @override
  _DifferentWidgetsState createState() => _DifferentWidgetsState();
}

class _DifferentWidgetsState extends State<DifferentWidgets> {

  List<int> items = [1,2,3,4,5,6,7,8];
  GlobalKey _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Different Widgets'),
        backgroundColor: Colors.brown[400],
        actions: [
          IconButton(icon: Icon(Icons.person,color: Colors.black,),iconSize: 25.0,onPressed: (){},),
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black,),iconSize: 25.0,onPressed: (){}),
        ],
      ),
      drawer: Drawer(),
      backgroundColor: Colors.brown[200],
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20.0),
              ///First Row of the widget
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Normal ClipRRect',
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          child: Image.asset("assets/image/flutter_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Oval Clip',
                        child: ClipOval(
                          child: Image.asset("assets/image/flutter_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Custom Clip',
                        child: ClipPath(
                          clipper: ClipPathClass(),
                          child: Image.asset("assets/image/flutter_logo.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Tooltip(
                message: 'CustomPaint widget',
                child: CustomPaintExample()
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                height: 365,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context,index){
                  return Dismissible(
                    key: Key(items[index].toString()),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Card(
                        elevation: 2.0,
                        color: Colors.brown[400],
                        child: ListTile(
                          leading: Text(index.toString()),
                          title: Text('Dismissible Widget'),
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///for flutter logo
class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


/// for custom dialer
class CustomPaintExample extends StatefulWidget {
  @override
  _CustomPaintExampleState createState() => _CustomPaintExampleState();
}

class _CustomPaintExampleState extends State<CustomPaintExample> with SingleTickerProviderStateMixin{
  double percentValue = 0.0;
  double newPercentage = 0.0;
  AnimationController _controller;

  @override
  void initState() {
    setState(() {
      percentValue = 0.0;
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
    ..addListener(() {
      setState(() {
        percentValue = lerpDouble(percentValue, newPercentage, _controller.value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: ButtonPainter(
            borderColor: Colors.red,
            progressColor: Colors.green,
            percentage: percentValue,
            width: 8.0
          ),
          child: RaisedButton(
            color: Colors.brown[400],
            splashColor: Colors.brown[800],
            shape: CircleBorder(),
            child: Text('Press\n ${percentValue.toInt()}%',
            style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
            onPressed: (){
              setState(() {
                percentValue = newPercentage;
                newPercentage = newPercentage + 10;
                if(newPercentage > 100.0){
                  percentValue = 0.0;
                  newPercentage = 0.0;
                }
                _controller.forward(from: 0.0);
              });
            },
          ),
        ),
      ),
    );
  }
}

class ButtonPainter extends CustomPainter{

  Color borderColor;
  Color progressColor;
  double percentage;
  double width;

  ButtonPainter({this.borderColor, this.progressColor, this.percentage, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
        ..color = borderColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;
    Paint complete = Paint()
    ..color = progressColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;
    Offset center = Offset(size.width/2 , size.height/2);
    double radius = min(size.width/2, size.height/2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2*pi* (percentage/100);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius:  radius),
        -pi/2,
        arcAngle,
        false,
        complete );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

