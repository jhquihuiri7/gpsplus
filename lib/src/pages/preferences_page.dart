import 'package:flutter/material.dart';
import 'package:gps_plus/src/constants/preferences.dart';
import 'package:gps_plus/src/models/preferences_model.dart';
import 'package:gps_plus/src/styles/text_styles.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final List<Widget> preferences = [];

  int activeId = 0;

  final PageController controller = PageController(initialPage: 0);
  final ScrollController indexController = ScrollController();
  TextEditingController textController = TextEditingController();
  List<bool> _isCheckedList = List.generate(15, (index) => false);
  bool _enableNext = false;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Mis preferencias",
                      style: TextStyles().changeColor(
                          TextStyles().primaryTextTheme.titleLarge,
                          Colors.black45),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                width: size.width,
                child: ListView.builder(
                    controller: indexController,
                    scrollDirection: Axis.horizontal,
                    itemCount: preferences_questions.length,
                    itemBuilder: (context, index) {
                      PreferenceModel preferenceModel = PreferenceModel.fromJson(preferences_questions[index]);
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                            color: (activeId - 1 >= preferenceModel.questionId)
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  offset: Offset(0.3, 0.3), spreadRadius: 0.3, blurRadius: 0.3)
                            ]),
                        padding: EdgeInsets.symmetric(
                            horizontal: (activeId - 1 >= preferenceModel.questionId) ? 15 : 25,
                            vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              (preferenceModel.questionId + 1).toString(),
                              style: (activeId - 1 >= preferenceModel.questionId)
                                  ? TextStyles().changeColor(
                                  TextStyles().primaryTextTheme.bodySmall, Colors.white)
                                  : TextStyles().primaryTextTheme.bodySmall,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (activeId - 1 >= preferenceModel.questionId)
                                ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 20,
                            )
                                : Container()
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: size.height * 0.6,
                  width: size.width,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: preferences_questions.length,
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        activeId = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      PreferenceModel preferenceModel = PreferenceModel.fromJson(preferences_questions[index]);
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Pregunta ${preferenceModel.questionId + 1}: ${preferenceModel.question}",
                            style: TextStyles().primaryTextTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: (_isCheckedList[
                                      preferenceModel.answers
                                              .length -
                                          1] & preferenceModel.otherAnswer)
                                  ? preferenceModel.answers
                                          .length +
                                      1
                                  : preferenceModel.answers
                                      .length,
                              itemBuilder: (context, i) {
                                if (i ==
                                    preferenceModel.answers
                                        .length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 2),
                                    child: Card(
                                      child: TextField(
                                        controller: textController,
                                        onChanged: (value){
                                          textController.text = value;
                                          if(textController.text.isEmpty){
                                            _enableNext = false;
                                          }else{
                                            _enableNext = true;
                                          }
                                          setState(() {

                                          });
                                        },
                                        showCursor: true,
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                          labelText: "Escribe cual otro",
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 2),
                                    child: Card(
                                      child: CheckboxListTile(
                                          title: Text(
                                              preferenceModel.answers[i]),
                                          value: _isCheckedList[i],
                                          onChanged: (value) {
                                            if (!preferenceModel.multipleChoice){
                                              _isCheckedList.fillRange(0, _isCheckedList.length, false);
                                            }

                                            _isCheckedList[i] = value!;
                                            for (bool element
                                                in _isCheckedList) {
                                              if (element) {
                                                if (_isCheckedList[preferenceModel.answers.length-1] & preferenceModel.otherAnswer){
                                                  if(textController.text == ''){
                                                    _enableNext = false;
                                                  }
                                                }else{
                                                  _enableNext = true;
                                                }
                                                break;
                                              } else {
                                                _enableNext = false;
                                              }
                                            }

                                            setState(() {});
                                          }),
                                    ),
                                  );
                                }
                              }),
                        )
                      ]);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: _enableNext
                          ? () {
                              textController.text = '';
                              _isCheckedList.fillRange(0, _isCheckedList.length, false);
                              if (activeId < preferences_questions.length-1) {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.ease);
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, 'registraitonComplete');
                              }
                              if (activeId == 4) {
                                indexController.animateTo(activeId * 60,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    curve: Curves.ease);
                              }
                              _enableNext = false;
                            }
                          : null,
                      child: (activeId < preferences_questions.length-1)
                          ? const Text("Siguiente")
                          : const Text("Finalizar")),
                  const SizedBox(
                    width: 20,
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
