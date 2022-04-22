import 'package:bonbon/common/bon.dart';
import 'package:bonbon/model/bon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({Key? key}) : super(key: key);

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonBon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () {
              Navigator.pushNamed(context, '/edit');
            },
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: AvailableBonPickerWidget(),
          ),
          SelectedBonOverviewWidget(),
        ],
      ),
    );
  }
}

class SelectedBonOverviewWidget extends StatelessWidget {
  const SelectedBonOverviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedBonsValue = context.select<BonModel, double>(
      (model) => model.selectedBonsValue,
    );

    var clearSelectedBon = context.select<BonModel, Function>(
      (model) => model.clearSelectedBon,
    );

    return Container(
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedBonsValue.toStringAsFixed(2)} EUR',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () => clearSelectedBon(),
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          SelectedBonPickerWidget(),
        ],
      ),
    );
  }
}

class SelectedBonPickerWidget extends StatefulWidget {
  const SelectedBonPickerWidget({Key? key}) : super(key: key);

  @override
  State<SelectedBonPickerWidget> createState() =>
      _SelectedBonPickerWidgetState();
}

class _SelectedBonPickerWidgetState extends State<SelectedBonPickerWidget> {
  @override
  Widget build(BuildContext context) {
    var selectedBons = context.select<BonModel, List<Bon>>(
      (model) => model.selectedBons,
    );

    var removeBonAt = context.select<BonModel, Function>(
      (model) => model.removeSelectedBonAt,
    );

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedBons.length,
        itemBuilder: (context, index) => SizedBox(
          width: 200,
          child: BonWidget(
            value: selectedBons[index].value,
            description: selectedBons[index].description,
            color: selectedBons[index].color,
            onPressed: () => removeBonAt(index),
          ),
        ),
      ),
    );
  }
}

class AvailableBonPickerWidget extends StatefulWidget {
  const AvailableBonPickerWidget({Key? key}) : super(key: key);

  @override
  State<AvailableBonPickerWidget> createState() =>
      _AvailableBonPickerWidgetState();
}

class _AvailableBonPickerWidgetState extends State<AvailableBonPickerWidget> {
  @override
  Widget build(BuildContext context) {
    var availableBons = context.select<BonModel, List<Bon>>(
      (model) => model.availableBons,
    );

    var selectBon = context.select<BonModel, Function>(
      (model) => model.selectBon,
    );

    return GridView.builder(
      itemCount: availableBons.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 200,
        maxCrossAxisExtent: 500,
      ),
      itemBuilder: (context, index) => BonWidget(
        value: availableBons[index].value,
        description: availableBons[index].description,
        color: availableBons[index].color,
        onPressed: () => selectBon(availableBons[index]),
      ),
    );
  }
}
