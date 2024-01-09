// library resizable_stack_image;

import 'package:flutter/material.dart';

class ResizableStackImage extends StatefulWidget {
  const ResizableStackImage(
      {super.key, required this.height, required this.width, required this.child});

  final Widget child;
  final double height;
  final double width;

  @override
  _ResizableStackImageState createState() => _ResizableStackImageState();
}

const ballDiameter = 20.0;
double top = 0;
double left = 0;
double stackHeight = 150;
double stackWidth = 150;

class _ResizableStackImageState extends State<ResizableStackImage> {
  void onDrag(double dx, double dy) {
    var newHeight = stackHeight + dy;
    var newWidth = stackWidth + dx;

    setState(() {
      stackHeight = newHeight > 0 ? newHeight : 0;
      stackWidth = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: SizedBox(
            height: stackHeight,
            width: stackWidth,
            child: widget.child,
          ),
        ),
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = stackHeight - 2 * mid > widget.height
                  ? widget.height
                  : stackHeight - 2 * mid;
              var newWidth = stackWidth - 2 * mid > widget.height
                  ? widget.height
                  : stackWidth - 2 * mid;

              setState(() {
                stackHeight = newHeight > 20 ? newHeight : 20;
                stackWidth = newWidth > 20 ? newWidth : 20;
                top = top + mid < 0
                    ? 0
                    : top + mid > widget.height
                    ? widget.height
                    : top + mid;
                left = left + mid < 0
                    ? 0
                    : left + mid > widget.height
                    ? widget.height
                    : left + mid;
              });
            },
          ),
        ),
        Positioned(
          top: top - ballDiameter / 2,
          left: left + stackWidth - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = stackHeight + 2 * mid > widget.height
                  ? widget.height
                  : stackHeight + 2 * mid;
              var newWidth = stackWidth + 2 * mid > widget.height
                  ? widget.height
                  : stackWidth + 2 * mid;

              setState(() {
                stackHeight = newHeight > 20 ? newHeight : 20;
                stackWidth = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > widget.height
                    ? widget.height
                    : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > widget.height
                    ? widget.height
                    : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + stackHeight - ballDiameter / 2,
          left: left + stackWidth - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = stackHeight + 2 * mid > widget.height
                  ? widget.height
                  : stackHeight + 2 * mid;
              var newWidth = stackWidth + 2 * mid > widget.height
                  ? widget.height
                  : stackWidth + 2 * mid;

              setState(() {
                stackHeight = newHeight > 20 ? newHeight : 20;
                stackWidth = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > widget.height
                    ? widget.height
                    : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > widget.height
                    ? widget.height
                    : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + stackHeight - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = stackHeight + 2 * mid > widget.height
                  ? widget.height
                  : stackHeight + 2 * mid;
              var newWidth = stackWidth + 2 * mid > widget.height
                  ? widget.height
                  : stackWidth + 2 * mid;

              setState(() {
                stackHeight = newHeight > 20 ? newHeight : 20;
                stackWidth = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > widget.height
                    ? widget.height
                    : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > widget.height
                    ? widget.height
                    : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + stackHeight / 2 - ballDiameter / 2,
          left: left + stackWidth / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              setState(() {
                top = top + dy < 0
                    ? 0
                    : top + dy > widget.height - stackHeight
                    ? widget.height - stackHeight
                    : top + dy;
                left = left + dx < 0
                    ? 0
                    : left + dx > widget.height - stackWidth
                    ? widget.height - stackWidth
                    : left + dx;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
