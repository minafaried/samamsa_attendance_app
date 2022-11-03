import 'package:attendance_app/Common/Config/Palette.dart';
import 'package:attendance_app/features/Home/controller/mempersController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String? family = "الكل";
  String? event = "القداس";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MempersController>(context, listen: false).getMempers("الكل");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MempersController>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("الحضور"),
          centerTitle: true,
          backgroundColor: Palette.primaryColor1,
        ),
        body: model.memperStatus == MemperStatus.Loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Palette.primaryColor1,
                ),
              )
            : Column(
                children: [
                  Container(
                    color: Palette.primaryColor1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: family,
                          dropdownColor: Palette.primaryColor1,
                          items: const [
                            DropdownMenuItem(
                              child: Text(
                                "الكل",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "الكل",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "الخورس",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "الخورس",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "الأنبا إبرام",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "الأنبا إبرام",
                            ),
                          ],
                          onChanged: (String? value) {
                            {
                              setState(() {
                                Provider.of<MempersController>(context,
                                        listen: false)
                                    .getMempers(value!);
                                family = value;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        DropdownButton(
                          dropdownColor: Palette.primaryColor1,
                          value: event,
                          items: const [
                            DropdownMenuItem(
                              child: Text(
                                "القداس",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "القداس",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "التسبحة",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "التسبحة",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "الإجتماع",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: "الإجتماع",
                            ),
                          ],
                          onChanged: (String? value) {
                            {
                              setState(() {
                                event = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        child: mempersView(model),
                      )
                    ],
                  )
                ],
              ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async =>
                {await model.sendAttendance(family!, event!)},
            child: Text("إرسال")),
      );
    });
  }

  Widget mempersView(MempersController model) {
    List<Widget> mempersList =
        List.generate(model.mempers!.length, (int index) {
      return Card(
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Checkbox(
                      value: model.mempers![index].isAttende,
                      onChanged: (value) => setState(() {
                            model.mempers![index].isAttende = value!;
                          })),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 150,
                  child: Text(
                    model.mempers![index].name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ));
    });
    return Column(
      children: mempersList,
    );
  }
}
