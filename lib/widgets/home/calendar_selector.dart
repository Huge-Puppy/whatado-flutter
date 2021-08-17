import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:whatado/state/home_state.dart';
import 'package:quiver/time.dart';

class _IndexedDate {
  final index;
  final dateTime;
  _IndexedDate(this.index, this.dateTime);
}

class CalendarSelector extends StatefulWidget {
  final double width;
  CalendarSelector({required this.width});
  @override
  State<StatefulWidget> createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  final List<_IndexedDate> dates = List<_IndexedDate>.generate(
      100, (i) => _IndexedDate(i, DateTime.now().add(Duration(days: i))));
  final monthWidth = 70.0;
  int scrollingMonth = DateTime.now().month;
  ScrollController? calendarScrollController;

  @override
  void initState() {
    super.initState();
    calendarScrollController = ScrollController();
    final now = DateTime.now();
    final daysLeftThisMonth = daysInMonth(now.year, now.month) - now.day + 1;
    final daysNextMonth = daysInMonth(now.month == 12 ? now.year + 1 : now.year,
        now.month == 12 ? 1 : now.month + 1);
    final daysLastMonth = daysInMonth(now.month >= 11 ? now.year + 1 : now.year,
        now.month >= 11 ? (now.month + 2) % 12 : now.month + 2);
    final dayWidth = (widget.width - monthWidth) / 6;

    List<double> monthOffsets = [
      daysLeftThisMonth * dayWidth,
      daysNextMonth * dayWidth,
      daysLastMonth * dayWidth
    ];

    calendarScrollController!.addListener(() {
      final offset = calendarScrollController!.offset;
      if (offset < monthOffsets[0]) {
        if (scrollingMonth != now.month) {
          setState(() => scrollingMonth = now.month);
        }
      } else if (offset < monthOffsets[1] + monthOffsets[1]) {
        if (scrollingMonth != now.month + 1) {
          setState(() => scrollingMonth = now.month + 1);
        }
      } else if (offset < monthOffsets[0] + monthOffsets[1] + monthOffsets[2]) {
        if (scrollingMonth != now.month + 2) {
          setState(() => scrollingMonth = now.month + 2);
        }
      } else if (scrollingMonth != now.month + 3) {
        setState(() => scrollingMonth = now.month + 3);
      }
    });
  }

  @override
  void dispose() {
    calendarScrollController?.dispose();
    super.dispose();
  }

  String toDate(DateTime time) {
    return DateFormat('yyyy-MM-dd').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    final double width = MediaQuery.of(context).size.width;
    final now = DateTime.now();
    return Container(
        height: 56,
        child: Row(
          children: [
            Container(
              width: monthWidth,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xffe85c3f),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Center(
                  child: Text(
                      DateFormat('MMM')
                          .format(DateTime(now.year, scrollingMonth)),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            Expanded(
                child: ListView(
                    controller: calendarScrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                  ...dates
                      .map((indexedDate) => InkWell(
                            onTap: () =>
                                homeState.selectedDateIndex = indexedDate.index,
                            child: Stack(
                              children: [
                                Container(
                                    height: double.infinity,
                                    width: (width - monthWidth) / 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            indexedDate.dateTime.day.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Text(DateFormat('EE')
                                            .format(indexedDate.dateTime)),
                                      ],
                                    )),
                                if (homeState.selectedDateIndex ==
                                    indexedDate.index)
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                            color: Color(0xffe85c3f),
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  )
                              ],
                            ),
                          ))
                      .toList()
                ]))
          ],
        ));
  }
}
