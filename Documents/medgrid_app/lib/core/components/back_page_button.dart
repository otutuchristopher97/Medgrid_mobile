import 'package:go_router/go_router.dart';
import 'package:medgrid_app/core/pallet.dart';
import 'package:flutter/material.dart';

class BackPageButton extends StatelessWidget {
  const BackPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Pallet.black,
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
