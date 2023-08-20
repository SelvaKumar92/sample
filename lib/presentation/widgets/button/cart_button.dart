import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  double? quantity;
  final VoidCallback? onButtonTap;
  final VoidCallback? onAddPressed;
  final VoidCallback? onMinusPressed;

  CartButton({
    Key? key,
    this.quantity,
    this.onButtonTap,
    this.onAddPressed,
    this.onMinusPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(
            color: Colors.lightBlue,
            width: 1,
          )),
      child: ((quantity ?? 0) == 0)
          ? InkWell(
              onTap: onButtonTap,
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onAddPressed,
                  child: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
                Text(
                  " ${quantity?.toInt().toString()} ",
                ),
                InkWell(
                  onTap: onMinusPressed,
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ],
            ),
    );
  }
}
