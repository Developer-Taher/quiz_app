import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Quizz App"),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade700,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  void checkAnswer(bool userPickAnswer) {
    bool correctAnswer = quizbrain.getCorrectAnswer();
    setState(() {
      // Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (quizbrain.isFinished() == true) {
        // Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "START OVER",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              width: 180,
            )
          ],
        ).show();
        // Alert(
        //   context: context,
        //   type: AlertType.error,
        //   title: "Finished!",
        //   desc: "You\'ve reached the end of the quiz.",
        //   buttons: [
        //     DialogButton(
        //       child: Text(
        //         "COOL",
        //         style: TextStyle(color: Colors.white, fontSize: 20),
        //       ),
        //       onPressed: () => Navigator.pop(context),
        //       width: 120,
        //     )
        //   ],
        // ).show();
        //HINT! Step 4 Part B is in the quiz_brain.dart
        // Step 4 Part C - reset the questionNumber,
        quizbrain.reset();
        // Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }
      // Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickAnswer == correctAnswer) {
          print("user got it right");
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          print("user got it wrong");
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        quizbrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
