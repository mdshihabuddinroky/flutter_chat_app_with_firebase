import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            // TODO:add image
            // decoration: const ShapeDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/person.jpeg'),
            //     fit: BoxFit.cover,
            //   ),
            //   shape: OvalBorder(),
            // ),
          ),
          const SizedBox(
            width: 23,
          ),
          Text(title,
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.30,
              ))
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
