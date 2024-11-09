import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  // ignore: use_key_in_widget_constructors
  const CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      selectedItemColor: Colors.white, 
      unselectedItemColor: const Color(0xFF6CC4C3),
      iconSize: 30, 
      items: [
        _buildBottomNavigationBarItem(
          icon: Icons.home,
          label: '',
          index: 0,
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.shopping_cart,
          label: '',
          index: 1,
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.history,
          label: '',
          index: 2,
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.calculate,
          label: '',
          index: 3,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: currentIndex == index
              ? const Color(0xFF11767a) 
              : Colors.transparent, 
          borderRadius: BorderRadius.circular(15), 
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
        child: Icon(
          icon,
          size: 30, 
          color: currentIndex == index
              ? Colors.white 
              : const Color(0xFF11767a), 
        ),
      ),
      label: label, 
    );
  }
}
