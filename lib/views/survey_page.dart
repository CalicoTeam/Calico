import 'package:clovi_template/utils/color_utils.dart';
import 'package:clovi_template/views/components/bottom_button.dart';
import 'package:clovi_template/views/components/step_progress.dart';
import 'package:clovi_template/views/components/style_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clovi_template/views/components/bottom_nav_bar.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int selected = 0;

  Widget genderRadio(String text, int index) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            selected = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 21,
            color: (selected == index)
                ? CalicoColors.representOrange
                : Color.fromARGB(255, 177, 177, 177),
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: (selected == index)
                      ? CalicoColors.representOrange
                      : Color.fromARGB(255, 177, 177, 177))),
        ));
  }

  List<String> ages = [
    '16-19',
    '20-24',
    '25-29',
    '30-34',
    '35-39',
    '40-44',
    '45-49'
  ];

  int tag = 1;
  List<String> tags = [];
  String? selectedAge = '16-19';

  PageController _controller = PageController(initialPage: 0);
  double _currentPage = 0;

  // For bottom navigation bar
  int _currentIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, 'video');
    } else if (index == 1) {
      Navigator.pushNamed(context, 'survey_page');
    } else if (index == 2) {
      Navigator.pushNamed(context, 'survey_page');
    }
    _currentIndex = index;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = 70;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 110,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          child: Text('건너뛰기',
                              style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color.fromARGB(255, 194, 194, 194))),
                          onPressed: () {})))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: StepProgress(currentStep: _currentPage, steps: 3),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: const Text("성별 입력",
                        style: TextStyle(
                            fontSize: 17.95,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text.rich(
                          TextSpan(text: "성별을 입력하고 내 성별의", children: <TextSpan>[
                            TextSpan(text: "\n인기 쇼츠를 시청해보세요.")
                          ]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.47,
                              color: Color.fromARGB(255, 177, 177, 177)))),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 100, height: 50, child: genderRadio("여자", 1)),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10)),
                      Container(
                          width: 100, height: 50, child: genderRadio("남자", 2))
                    ],
                  )),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
                  Container(
                    width: screenWidth * 0.7,
                    alignment: Alignment.center,
                    child: const Text.rich(
                        TextSpan(
                          text: "성별을 입력하시면 ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "개인정보 수집이용에",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " \n동의하는 것으로 간주합니다.",
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.47,
                            color: Color.fromARGB(255, 177, 177, 177))),
                  ),
                ]),
                Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: const Text("나이 입력",
                        style: TextStyle(
                            fontSize: 17.95,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text.rich(
                          TextSpan(
                              text: "나이를 입력하고 내 연령대의",
                              children: <TextSpan>[
                                TextSpan(text: "\n인기 쇼츠를 시청해보세요.")
                              ]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.47,
                              color: Color.fromRGBO(177, 177, 177, 1)))),
                  SizedBox(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2)
                          ],
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.w800,
                              color: CalicoColors.representBlack),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: '20',
                              hintStyle: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 177, 177, 177))),
                        ),
                      )),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth * 0.7,
                    alignment: Alignment.center,
                    child: const Text.rich(
                        TextSpan(
                          text: "나이를 입력하시면 ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "개인정보 수집이용에",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " \n동의하는 것으로 간주합니다.",
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.47,
                            color: Color.fromARGB(255, 177, 177, 177))),
                  ),
                ]),
                Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text("스타일 선택",
                          style: TextStyle(
                              fontSize: 17.95,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                    Container(
                        width: screenWidth,
                        alignment: Alignment.center,
                        child: const Text.rich(
                            TextSpan(
                                text: "내가 좋아하거나 닮아가고 싶은",
                                children: <TextSpan>[
                                  TextSpan(text: "\n분위기를 선택해보세요.")
                                ]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.47,
                                color: Color.fromARGB(255, 177, 177, 177)))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: StyleChips(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BottomButtons(pageController: _controller),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).highlightColor,
        items: BottomNavItems.items,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
