import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plateron/features/checkout/presentation/bloc/cart_bloc.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/presentation/presentation.dart';
import 'package:plateron/presentation/widgets/button/cart_button.dart';
import 'package:plateron/presentation/widgets/list_item/menu_list_item.dart';

/// Displays "menus" page
class CartItemsPage extends StatelessWidget {
  final CartBloc cartBloc;

  const CartItemsPage({required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>.value(value: cartBloc),
      ],
      child: const _CartPageView(),
    );
  }
}

class _CartPageView extends StatelessWidget {
  const _CartPageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                Text(
                  "${state.price.toString()} Total",
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Buy'),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                for (final menu in state.menuItems)
                  MenuListItem(
                    title: menu.title,
                    description: menu.description,
                    price: menu.amount,
                    addToCart: CartButton(
                      quantity: (state.menuItems.where((element) => element.productId == menu.productId))
                          .firstOrNull
                          ?.quantity,
                      onAddPressed: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartEvent.addItem(
                              state.menuItems.where((element) => element.productId == menu.productId).firstOrNull ??
                                  Menu()),
                        );
                      },
                      onButtonTap: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartEvent.addItem(menu),
                        );
                      },
                      onMinusPressed: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartEvent.deleteItem(
                              state.menuItems.where((element) => element.productId == menu.productId).firstOrNull ??
                                  Menu()),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getLoadingCard() {
    return const CircularProgressIndicator();
  }
}
