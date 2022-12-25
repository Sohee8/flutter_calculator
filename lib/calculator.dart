import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  String showText = "";
  final List<String> buttons = [
    'mc',
    'm+',
    'm-',
    'mr',
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '*',
    '00',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container( padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),color: const Color.fromRGBO(214, 213, 211, 1),
          child: Column(
            children: [
              Container(
                  height: 130, width: double.infinity, padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: Colors.black54),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity, height: 90, padding: const EdgeInsets.all(5), alignment: Alignment.centerRight,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: const Color.fromRGBO(227, 219, 211, 1),),
                          child: Text( showText,style: const TextStyle(fontSize: 35),)),
                      Container(
                          alignment: Alignment.center, padding: const EdgeInsets.only(top: 5),
                          child: const Text('7-DIGIT LED DISPLAY',style: TextStyle(color: Colors.white,fontSize: 10))),
                    ],
                  )
              ),

              Container(
                height: 50, margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color:const Color.fromRGBO(185, 187, 190, 1) ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30,child: Row(
                      children: [
                        Image.asset('assets/calc_icon2.png'),
                        Text(' ON',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    ),
                    SizedBox(child: Image.asset('assets/calc_icon.png'),height: 30,)
                  ],
                ),
              ),

              Expanded(flex:2,child: _buttons(),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 2/1.7),
      itemBuilder: (BuildContext context, int index) {
        return _myButton(buttons[index]);
      },
      itemCount: buttons.length,
    );
  }

  _myButton(String text) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonTap(text);
          });},
        color: _getColor(text),
        textColor: _getColor2(text),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
        child: Text(text,style: const TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
      ),
    );
  }

  handleButtonTap(String text) {
    if (text == "AC") {
      showText = "";
      return;
    }
    if (text == "=") {
      showText = calculate();
      if (showText.endsWith(".0")) {
        showText = showText.replaceAll(".0", "");
      }
      return;
    }

    if (text == "C") {
      showText = showText.substring(0, showText.length - 1);
      return;
    }
    showText = showText + text;
  }

  calculate() {
    try {
      var exp = Parser().parse(showText);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Err";
    }
  }

  _getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-" || text == "%") {
      return const Color.fromRGBO(145, 152, 157, 1);
    }
    if(text == "mr" || text == "m+" || text == "m-" || text == "mc"){
      return const Color.fromRGBO(72, 73, 70, 1);
    }
    if (text == "C" || text == "AC" || text == "=") {
      return Colors.orange;
    }
    return const Color.fromRGBO(250, 250, 250, 1);
  }

  _getColor2(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-" || text == "%"||text == "C" || text == "AC" || text == "=") {
      return Colors.white;
    }
    if(text == "mr" || text == "m+" || text == "m-" || text == "mc"){
      return Colors.white;
    }
    return Colors.black87;
  }
}