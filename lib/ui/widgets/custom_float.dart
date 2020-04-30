import 'package:flutter/material.dart';
import 'package:SaudagarKaya/utils/uidata.dart';

class CustomFloat extends StatelessWidget {
  final IconData icon;
  final Widget builder;
  final VoidCallback qrCallback;
  final isMini;
  final tag;

  CustomFloat({this.icon, this.builder, this.qrCallback, this.isMini = false, this.tag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag : tag,
      clipBehavior: Clip.antiAlias,
      mini: isMini,
      onPressed: qrCallback,
      child: Ink(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: UIData.kitGradients)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            builder != null
                ? Positioned(
                    right: 7.0,
                    top: 7.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: builder,
                      radius: 10.0,
                    ),
                  )
                : Container(),
            // builder
          ],
        ),
      ),
    );
  }
}
