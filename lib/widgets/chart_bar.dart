import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingper;
  ChartBar(this.label, this.spending, this.spendingper);
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (ctx,constraints){
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight* .15,
          child: FittedBox(child: Text('\$ ${spending.toStringAsFixed(0)}'))),
        SizedBox(
          height: constraints.maxHeight* .05,
        ),
        Container(
          height: constraints.maxHeight* .6,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingper,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight* .05,
        ),
        Container(
          height: constraints.maxHeight* .15,
          child: FittedBox(child: Text(label))),
      ],
    );
    },);  
  }
}
