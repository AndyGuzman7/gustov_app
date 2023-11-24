import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final String textTitle;
  final String textSubTitle;
  final Icon iconButtonItem;
  final dynamic arguments;

  final String? pageRoute;

  const ItemButton({
    super.key,
    required this.textTitle,
    this.pageRoute,
    required this.textSubTitle,
    required this.iconButtonItem,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 218, 218, 218),
              offset: Offset(0.0, 10.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          margin: EdgeInsets.zero,
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              pageRoute != null
                  ? Navigator.pushNamed(context, pageRoute!,
                      arguments: arguments)
                  : null;
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 243, 242, 242),
                    child: iconButtonItem,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      textTitle,
                    ),
                    subtitle: Text(textSubTitle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  CustomWidget(
      {required this.color, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widgetSize =
        screenWidth / 2; // Cada widget ocupa la mitad del ancho de la pantalla
    final borderRadius = BorderRadius.circular(10.0);

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: widgetSize,
          height: widgetSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
