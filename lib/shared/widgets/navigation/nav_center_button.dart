import 'package:flutter/material.dart';

class NavCenterButton extends StatelessWidget {
  final VoidCallback onTap;

  const NavCenterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF02658B),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3B02658B),
              blurRadius: 14,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 32,
              ),
              Positioned(
                bottom: 7,
                child: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF02658B),
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
