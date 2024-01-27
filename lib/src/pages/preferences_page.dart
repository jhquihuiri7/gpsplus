import 'package:flutter/material.dart';
import 'package:gps_plus/src/constants/preferences.dart';
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
  List<bool> _isCheckedList = List.generate(10, (index) => false);

  void GetPreferences(Size size, List<Widget> preferencesIndex) {
    for (var element in preferences_questions) {
      preferencesIndex.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
            color: (activeId-1 >= element['question_id'])
                ? Colors.green
                : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  offset: Offset(0.3, 0.3), spreadRadius: 0.3, blurRadius: 0.3)
            ]),
        padding: EdgeInsets.symmetric(horizontal: (activeId-1 >= element['question_id']) ? 15 : 25, vertical: 10),
        child: Row(
          children: [
            Text(
              (element['question_id'] + 1).toString(),
              style: (activeId-1 >= element['question_id'])
                  ? TextStyles().changeColor(
                      TextStyles().primaryTextTheme.bodySmall, Colors.white)
                  : TextStyles().primaryTextTheme.bodySmall,
            ),
            const SizedBox(width: 10,),
            (activeId-1 >= element['question_id']) ? const Icon(Icons.check_circle_outline, color: Colors.white, size: 20,) : Container()
          ],
        ),
      ));
      List<String> answers = element['answers'];
      List<Widget> answersWidget = [];
      for (var element in answers) {
        answersWidget.add(Text(element));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> preferencesIndex = [];
    final Size size = MediaQuery.of(context).size;
    GetPreferences(size, preferencesIndex);
    return Scaffold(
      body: Center(
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
                  itemCount: preferencesIndex.length,
                  itemBuilder: (context, index){
                    return preferencesIndex[index];
                  }
              ),
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
                      print(activeId);
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Pregunta ${preferences_questions[index]["question_id"]+1}: ${preferences_questions[index]['question']}", style: TextStyles().primaryTextTheme.bodyMedium,),
                        ),
                        const SizedBox(height: 30,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: preferences_questions[index]["answers"].length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                child: Card(
                                  child: CheckboxListTile(
                                      title: Text(
                                          preferences_questions[index]["answers"][i]),
                                      value: _isCheckedList[i],
                                      onChanged: (value) {
                                        _isCheckedList[i] = value!;
                                        setState(() {});
                                     }
                                  ),
                                ),
                              );
                            }
                          ),
                        )
                      ]);
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _isCheckedList = List.generate(10, (index) => false);
                      if (activeId < 6) {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 100), curve: Curves.ease);
                      }else {
                        Navigator.pushReplacementNamed(context, 'registraitonComplete');
                      }
                      if (activeId == 4){
                        indexController.animateTo(activeId * 60, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
                      }
                    },
                    child: (activeId < 6) ? const Text("Siguiente") : const Text("Finalizar")
                ),
                const SizedBox(width: 20,)
              ],
            )
          ],
        )),
      ),
    );
  }
}
