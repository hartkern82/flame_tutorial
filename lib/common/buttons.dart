import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  const PrimaryButton({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
