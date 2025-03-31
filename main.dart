import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await initializeDateFormatting('ko', null); // 로케일 데이터 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨김
      home: TimeScreen(), // 메인 화면 설정
    );
  }
}

class TimeScreen extends StatefulWidget {
  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  late String _currentTime; // 현재 시간을 저장할 변수
  late Timer _timer; // 1초마다 시간을 갱신할 타이머

  @override
  void initState() {
    super.initState();
    _updateTime(); // 초기 시간 설정
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(); // 1초마다 시간 갱신
    });
  }

  void _updateTime() {
    setState(() {
      // 현재 시간을 한국어 포맷으로 설정
      _currentTime = DateFormat('yyyy-MM-dd\n  a h:mm:ss', 'ko').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '현재 시각',
          style: TextStyle(fontSize: 24), // 글자 크기 증가
        ),
        centerTitle: true, // 타이틀 중앙 정렬
        backgroundColor: Color(0xFFCCCCCC), // 타이틀 배경색 지정
      ),
      body: Center(
        child: Text(
          _currentTime,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold), // 글자 크기 증가
          textAlign: TextAlign.center, // 텍스트 중앙 정렬
        ),
      ),
    );
  }
}
