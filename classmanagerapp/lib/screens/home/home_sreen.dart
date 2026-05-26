import 'package:classmanagerapp/core/widgets/diciplinas/diciplinas.dart';
import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';
import 'package:classmanagerapp/screens/activities/student_activities_screen.dart';
import 'package:classmanagerapp/screens/screen_academico/screen_academico.dart';
import 'package:classmanagerapp/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    DiciplinasScreen(),
    StudentActivitiesScreen(),
    AcademicoScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
