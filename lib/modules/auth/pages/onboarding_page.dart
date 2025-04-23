import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/constants/images.dart';
import 'package:offbeat_pravasi_v2/modules/auth/auth_exports.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<OnboardingServices>(
          builder: (context, provider, child) => Text(
              "${provider.currentQuestionIndex + 1} OF ${provider.onboardingQuestions.length} ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: SizedBox(
        //       width: 70,
        //       height: 34,
        //       child: FloatingActionButton(
        //         elevation: 1.0,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         onPressed: () {}, //skip logic here
        //         backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        //         child: Text("Skip",
        //             style: TextStyle(
        //               color: Theme.of(context).colorScheme.primary,
        //               fontSize: 14,
        //               fontWeight: FontWeight.w400,
        //             )),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Consumer<OnboardingServices>(
        builder: (context, provider, _) {
          var question = provider.currentQuestion;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.treaker_Background),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (provider.currentQuestionIndex + 1) /
                      provider.onboardingQuestions.length,
                  minHeight: 18,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  backgroundColor: Color.alphaBlend(
                    Colors.white54,
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 42, bottom: 24),
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: Column(
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select an answer",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Text(
                        question["question"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 12),
                      for (var option in question["options"])
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: OnboardingRadiolist(
                              option: option["text"],
                              optionValue: option["value"],
                              groupValue: provider
                                      .selectedAnswers[question["question"]] ??
                                  '',
                              onChanged: (value) {
                                setState(() {
                                  provider.selectedAnswers[
                                      question["question"]] = value!;
                                });
                              }),
                        ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (provider.currentQuestionIndex > 0)
                            SmallButton(
                              isback: true,
                              title: "Back",
                              onPressed: provider.previousQuestion,
                            ),
                          SmallButton(
                              isback: false,
                              title:
                                  provider.isLastQuestion ? "Submit" : "Next",
                              onPressed: provider.isLastQuestion
                                  ? () =>
                                      provider.saveAnswerToFirestore(context)
                                  : provider.nextQuestion),
                        ],
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
