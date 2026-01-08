import 'package:flutter/material.dart';
import 'food_model.dart';

class DetailScreen extends StatefulWidget {
  // const DetailScreen({super.key});

  Food item;
  DetailScreen(this.item);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Screen")),
      body: ListView(
        children: [
          Image.network(this.widget.item.image),
          _buildText(this.widget.item.title),
          _buildSmallText("តម្លៃ៖ ${(this.widget.item.price * 4000).toInt()} រៀល"),
          _buildSmallText("តម្លៃគិតជាដុល្លា៖ ${this.widget.item.price} ដុល្លា"),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "មុខម្ហូបៈ $text",
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSmallText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "មុខម្ហូបៈ $text",
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
