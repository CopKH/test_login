import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_test/providers/list.dart';
import 'package:login_test/widget/product_card.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const routeName = '/product';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ListData>(context).listAPI().then((_) {
        setState(() {
          _isLoading = false;
          print('FETCH DATA');
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ListData>(context);
    final dataList = data.product.toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              SingleChildScrollView(
            child: Column(
              children: [
                ProductCard(
                  name: dataList[index].title,
                  price: dataList[index].price,
                  imageUrl:
                      dataList[index].images,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          itemCount: dataList.length,
        ),
      ),
    );
  }
}
