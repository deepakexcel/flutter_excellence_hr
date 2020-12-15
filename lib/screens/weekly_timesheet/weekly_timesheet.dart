import 'package:flutter/material.dart';
import 'package:flutter_excellence_hr/model/timesheet/timesheet.dart';
import 'package:flutter_excellence_hr/model/tmsreport/tmsreport.dart';
import 'package:flutter_excellence_hr/resources/app_colors.dart';
import 'package:flutter_excellence_hr/screens/navigate/navigation.dart';
import 'package:flutter_excellence_hr/services/timesheet/timesheet.dart';
import 'package:flutter_excellence_hr/services/tmsreport/tmsreport.dart';
import 'package:flutter_excellence_hr/widgets/appbar.dart';
import 'package:flutter_excellence_hr/widgets/profile_widgets/profile_widgets.dart';
import 'package:flutter_excellence_hr/widgets/timesheet_widgets/timesheet_widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sticky_headers/sticky_headers.dart';

class WeeklyTimeSheet extends StatefulWidget {
  @override
  _WeeklyTimeSheetState createState() => _WeeklyTimeSheetState();
}

class _WeeklyTimeSheetState extends State<WeeklyTimeSheet> {
  final totalTime = TextEditingController();
  final comment = TextEditingController();
  TMSReportService apireport = TMSReportService();
  TMSReport tmsReport;
  TimeSheetService api = TimeSheetService();
  TimeSheet timeSheet;
  bool yourTimesheet = false;
  bool yourTMSReport = false;

  _getTimeSheet() async {
    return await api.getTimesheet().then((value) {
      timeSheet = value;
      print("The full time date " + timeSheet.data[0].fullDate);
      setState(() {
        yourTimesheet = true;
      });
    });
  }

  _getTMSReport() async {
    return await apireport.getTMSComment().then((value) {
      tmsReport = value;
      setState(() {
        yourTMSReport = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getTimeSheet();
    _getTMSReport();
  }

  @override
  Widget build(BuildContext context) {
    customDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration:
                    new BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(children: [
                        Container(
                            margin: EdgeInsets.all(16),
                            child: Text("Monday Time Sheet",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'OpenSans')))
                      ]),
                      Divider(height: 1, thickness: .5, color: Colors.grey),
                      SizedBox(height: 16),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Text("Total Time ",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 16))))
                          ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
                              height: 35,
                              child: TextFormField(
                                enabled: true,
                                controller: totalTime,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                        fontSize: 16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text("Comment ",
                                    style: TextStyle(
                                        fontFamily: 'OpenSans', fontSize: 16))),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              height: 100,
                              child: TextFormField(
                                enabled: true,
                                maxLines: 5,
                                controller: comment,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  // hintText: tmsReport.data.report,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
                                height: 45,
                                child: Text(
                                  'Its better if you put your detail reports on tms and HR system will automatically fetch it for you',
                                  style: TextStyle(
                                      color: AppColors.LIGHTBLACK_COLOR,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text("Upload Tracker Screenshot",
                                    style: TextStyle(
                                        fontFamily: 'OpenSans', fontSize: 16))),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: UploadPic(),
                            ),
                          ),
                        ],
                      ),
                      RoundedLoadingButton(
                        color: AppColors.BTN_BLACK_COLOR,
                        width: 150,
                        borderRadius: 10,
                        onPressed: () {},
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(title: AppBarWidget(pageName: "Weekly Timesheet")),
      drawer: Navigation(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Submit Weekly Timesheet'),
          backgroundColor: AppColors.BTN_BLACK_COLOR),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StickyHeader(
          header: Header(),
          content: Column(children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[0].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[1].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[2].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    customDialog();
                  },
                  child: Container(
                      color: Colors.grey[300],
                      margin: EdgeInsets.fromLTRB(8, 8, 1, 1),
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                      child: Text(timeSheet.data[0].date,
                          style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 14))),
                )),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 8, 1, 1),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(timeSheet.data[1].date,
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 8, 8, 1),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(timeSheet.data[2].date,
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    customDialog();
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 1, 8),
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                      child: Text(
                          timeSheet.data[0].totalHours.toString() +
                              " - Total Hours",
                          style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 14))),
                )),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(1, 0, 1, 8),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(
                            timeSheet.data[1].totalHours.toString() +
                                " - Total Hours",
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(1, 0, 8, 8),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(
                            timeSheet.data[2].totalHours.toString() +
                                " - Total Hours",
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
              ],
            ),
            SaveStates(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[3].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[4].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          timeSheet.data[5].day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(8, 8, 1, 1),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(timeSheet.data[3].date,
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 8, 1, 1),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(timeSheet.data[4].date,
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 8, 8, 1),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(timeSheet.data[5].date,
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(8, 0, 1, 8),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(
                            timeSheet.data[3].totalHours.toString() +
                                " - Total Hours",
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 0, 1, 8),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(
                            timeSheet.data[4].totalHours.toString() +
                                " - Total Hours",
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
                Expanded(
                    child: Container(
                        color: Colors.grey[300],
                        margin: EdgeInsets.fromLTRB(1, 0, 8, 8),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Text(
                            timeSheet.data[5].totalHours.toString() +
                                " - Total Hours",
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 14)))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        timeSheet.data[6].day,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'SourceSans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(flex: 2, child: Container())
              ],
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: Container(
                    color: Colors.yellowAccent,
                    height: 70,
                    margin: EdgeInsets.fromLTRB(8, 8, 1, 1),
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                    child: Text(timeSheet.data[6].date,
                        style:
                            TextStyle(fontFamily: 'OpenSans', fontSize: 14))),
              ),
              Expanded(flex: 2, child: Container())
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      color: Colors.yellowAccent,
                      height: 16,
                      padding: EdgeInsets.all(1),
                      margin: EdgeInsets.fromLTRB(8, 0, 1, 1),
                      child: Text('Weekends of',
                          style: TextStyle(fontSize: 12, color: Colors.black))),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
