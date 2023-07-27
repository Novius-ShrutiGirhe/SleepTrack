import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  SharedPreferences? _prefs;
  Duration? _longestDuration;
  DateTime? _currentDate;
  DateTime? _lockStartTime;
  DateTime? _lockEndTime;
  String _sleepTime = 'No lock durations';
  String _wakeUpTime = 'No lock durations';
  List<Duration> _lockDurations = [];

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _initializePreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _lockDurations = await _retrieveLockDurations();
    _longestDuration = _lockDurations.isNotEmpty
        ? _lockDurations
        .reduce((value, element) => value > element ? value : element)
        : null;
    _prefs = await SharedPreferences.getInstance();
    _currentDate = DateTime.now();
    final currentDateStr = DateFormat('yyyy-MM-dd').format(_currentDate!);
    final storedDateStr = _prefs!.getString('date') ?? '';
    if (currentDateStr != storedDateStr) {
      _prefs!.setString('date', currentDateStr);
      _prefs!.remove(currentDateStr);
      _longestDuration = Duration.zero;
    } else {
      final longestDurationMs = _prefs!.getInt(currentDateStr) ?? 0;
      _longestDuration = Duration(milliseconds: longestDurationMs);
      _lockStartTime = _prefs!.getString('lockStartTime') != null
          ? DateTime.parse(_prefs!.getString('lockStartTime')!)
          : null;
      _lockEndTime = _prefs!.getString('lockEndTime') != null
          ? DateTime.parse(_prefs!.getString('lockEndTime')!)
          : null;
      _updateSleepWakeTimes();
    }
  }

  Future<List<Duration>> _retrieveLockDurations() async {
    final currentDate = DateTime.now();
    final durations = <Duration>[];

    for (int i = 0; i < 21; i++) {
      final date = currentDate.subtract(Duration(days: i));
      final currentDateStr = DateFormat('yyyy-MM-dd').format(date);
      final longestDurationMs = _prefs!.getInt(currentDateStr) ?? 0;
      durations.add(Duration(milliseconds: longestDurationMs));
    }

    return durations;
  }

  Future<void> _saveLongestDuration() async {
    if (_currentDate == null || _longestDuration == null) return;
    final currentDateStr = DateFormat('yyyy-MM-dd').format(_currentDate!);
    await _prefs!.setInt(currentDateStr, _longestDuration!.inMilliseconds);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _lockStartTime = DateTime.now();
      _saveLongestDuration();
      _saveLockTimes();
    } else if (state == AppLifecycleState.resumed && _lockStartTime != null) {
      final lockEndTime = DateTime.now();
      final lockDuration = lockEndTime.difference(_lockStartTime!);
      if (_longestDuration == null || lockDuration > _longestDuration!) {
        setState(() {
          _longestDuration = lockDuration;
        });
        _updateSleepWakeTimes();
      }
      _lockStartTime = null;
      _lockEndTime = null;
    }
  }

  Future<void> _saveLockTimes() async {
    if (_lockStartTime != null && _lockEndTime != null) {
      final lockStartTimeStr = _lockStartTime!.toIso8601String();
      final lockEndTimeStr = _lockEndTime!.toIso8601String();
      await _prefs!.setString('lockStartTime', lockStartTimeStr);
      await _prefs!.setString('lockEndTime', lockEndTimeStr);
    }
  }

  void _updateSleepWakeTimes() {
    if (_longestDuration != null && _lockStartTime != null) {
      final sleepTime = _lockStartTime!.subtract(_longestDuration!);
      final sleepTimeFormatted = DateFormat('hh:mm:ss a').format(sleepTime);
      final wakeUpTimeFormatted =
      DateFormat('hh:mm:ss a').format(_lockStartTime!);
      _sleepTime = sleepTimeFormatted;
      _wakeUpTime = wakeUpTimeFormatted;
    }
  }

  String _getDurationString(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '$hours hours, $minutes minutes, $seconds seconds';
  }

  String _getAverageDuration() {
    if (_lockDurations.isEmpty) {
      return 'No lock durations';
    }

    if (_lockDurations.length == 1) {
      return _getDurationString(_lockDurations[0]);
    }

    final numDays = _lockDurations.length < 21 ? _lockDurations.length : 21;
    final durationsToConsider = _lockDurations.sublist(0, numDays);

    Duration totalDuration = Duration();
    for (var duration in durationsToConsider) {
      totalDuration += duration;
    }

    final averageDurationInMicroseconds =
        totalDuration.inMicroseconds ~/ numDays;

    final averageDuration =
    Duration(microseconds: averageDurationInMicroseconds);

    return _getDurationString(averageDuration);
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff3C2177),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          selectedFontSize: 15,
          showUnselectedLabels: false,
          backgroundColor: Colors.deepPurple,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.analytics,
                color: Colors.white,
              ),
              label: 'Analaysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article, color: Colors.white),
              label: 'Articles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note, color: Colors.white),
              label: 'Music',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Icon(Icons.access_alarm_outlined,
                      color: Colors.black54, size: mq.height * .35),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Average Sleep score ${_getAverageDuration()}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Avg. sleep time :${_longestDuration != null ? _getDurationString(_longestDuration!) : 'No lock durations'}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Average Sleep At : $_sleepTime  ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Average Wake At: $_wakeUpTime  ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _deleteStoredData,
                  child: Text('Delete Stored Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteStoredData() async {
    await _prefs?.clear();
    setState(() {
      _longestDuration = Duration.zero;
      _lockStartTime = null;

      _sleepTime = 'No lock durations';
      _wakeUpTime = 'No lock durations';
      _lockDurations = [];
    });
  }
}
