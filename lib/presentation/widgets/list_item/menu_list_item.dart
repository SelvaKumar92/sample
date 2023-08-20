import 'package:plateron/presentation/presentation.dart';

/// Renders a menu List Item
class MenuListItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final double? price;
  final double? quantity;
  final Widget? addToCart;

  const MenuListItem({
    super.key,
    this.image,
    this.title,
    this.description,
    this.quantity,
    this.price,
    this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.network(
              fit: BoxFit.fitHeight,
              image ?? '',
              height: 125,
              width: 125,
            ),
          ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description ?? '',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee_outlined,
                      size: 15,
                    ),
                    Text(
                      "'${price.toString()}",
                    ),
                    const Spacer(),
                    addToCart ?? const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
