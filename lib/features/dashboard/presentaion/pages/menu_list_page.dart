import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plateron/core/injection/injection.dart';
import 'package:plateron/core/navigation/app_router.dart';
import 'package:plateron/features/checkout/presentation/bloc/cart_bloc.dart';
import 'package:plateron/features/checkout/presentation/pages/cart_items_page.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/features/dashboard/presentaion/bloc/menu_list_bloc.dart';
import 'package:plateron/presentation/presentation.dart';
import 'package:plateron/presentation/widgets/button/cart_button.dart';
import 'package:plateron/presentation/widgets/list_item/menu_list_item.dart';

/// Displays "menus" page
class MenuListPage extends StatelessWidget {
  const MenuListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuListBloc>(
          create: (context) => locator<MenuListBloc>()..add(const MenuListEvent.fetchMenuItems()),
        ),
        BlocProvider<CartBloc>(create: (context) => locator<CartBloc>()),
      ],
      child: const _MenusPageView(),
    );
  }
}

class _MenusPageView extends StatelessWidget {
  const _MenusPageView();

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();

    return BlocBuilder<CartBloc, CartState>(builder: (context, cartState) {
      return BlocBuilder<MenuListBloc, MenuListState>(
        builder: (context, state) {
          return state.maybeWhen(
            () => getLoadingCard(),
            orElse: () => getLoadingCard(),
            loaded: (listItem) {
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
                        "${cartState.menuItems.length} items",
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartItemsPage(
                                    cartBloc: locator<CartBloc>(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Place Order'),
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
                      for (final menu in listItem)
                        MenuListItem(
                          title: menu.title,
                          description: menu.description,
                          image: menu.image,
                          price: menu.amount,
                          addToCart: CartButton(
                            quantity: (cartState.menuItems.where((element) => element.productId == menu.productId))
                                .firstOrNull
                                ?.quantity,
                            onAddPressed: () {
                              BlocProvider.of<CartBloc>(context).add(
                                CartEvent.addItem(cartState.menuItems
                                        .where((element) => element.productId == menu.productId)
                                        .firstOrNull ??
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
                                CartEvent.deleteItem(cartState.menuItems
                                        .where((element) => element.productId == menu.productId)
                                        .firstOrNull ??
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
        },
      );
    });
  }

  Widget getLoadingCard() {
    return const CircularProgressIndicator();
  }
}
