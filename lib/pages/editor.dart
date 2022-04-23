import 'package:bonbon/common/bon.dart';
import 'package:bonbon/model/bon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    var availableBons = context.select<BonModel, List<Bon>>(
      (model) => model.availableBons,
    );

    var removeAvailableBonAtIndex = context.select<BonModel, Function>(
      (model) => model.removeAvailableBonAtIndex,
    );

    var setAvailableBonAtIndex = context.select<BonModel, Function>(
      (model) => model.setAvailableBonAtIndex,
    );

    var setAvailableBon = context.select<BonModel, Function>(
      (model) => model.setAvailableBon,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit BonBon'),
      ),
      body: GridView.builder(
        itemCount: availableBons.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 200,
          maxCrossAxisExtent: 500,
        ),
        itemBuilder: (context, index) => SizedBox(
          height: 200,
          child: BonWidget(
            value: availableBons[index].value,
            description: availableBons[index].description,
            color: availableBons[index].color,
            onPressed: () => showBonEditDialog(
              context,
              availableBons,
              index,
              removeAvailableBonAtIndex,
              setAvailableBonAtIndex,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            availableBons.add(Bon(Colors.blue, '', 0));
            setAvailableBon(availableBons);
            showBonEditDialog(
              context,
              availableBons,
              availableBons.length - 1,
              removeAvailableBonAtIndex,
              setAvailableBonAtIndex,
            );
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<dynamic> showBonEditDialog(
      BuildContext context,
      List<Bon> availableBons,
      int index,
      Function removeAvailableBonAtIndex,
      Function setAvailableBonAtIndex) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var futureBon = Bon(
          availableBons[index].color,
          availableBons[index].description,
          availableBons[index].value,
        );

        return AlertDialog(
          title: const Text('Edit Bon'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                initialValue: availableBons[index].description,
                onChanged: (String description) {
                  futureBon.description = description;
                },
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Value',
                  ),
                  initialValue: availableBons[index].value.toStringAsFixed(2),
                  onChanged: (String value) {
                    futureBon.value = double.parse(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: BlockPicker(
                  pickerColor: availableBons[index].color,
                  availableColors: Colors.primaries
                      .map((primary) => [
                            primary.shade50,
                            primary.shade100,
                            primary.shade200,
                            primary.shade300,
                            primary.shade400,
                            primary.shade500,
                            primary.shade600,
                            primary.shade700,
                            primary.shade800,
                            primary.shade900,
                          ])
                      .expand((e) => e)
                      .toList(),
                  onColorChanged: (Color color) {
                    futureBon.color = color;
                  },
                  layoutBuilder: (
                    BuildContext context,
                    List<Color> colors,
                    PickerItem child,
                  ) {
                    return SizedBox(
                      width: 300,
                      height: 280,
                      child: GridView.count(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: [for (Color color in colors) child(color)],
                      ),
                    );
                  },
                  itemBuilder: (Color color, bool isCurrentColor,
                      void Function() changeColor) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: color,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: changeColor,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: isCurrentColor ? 1 : 0,
                            child: Icon(
                              Icons.done,
                              size: 20,
                              color: useWhiteForeground(color)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  useInShowDialog: true,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                removeAvailableBonAtIndex(index);
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                setAvailableBonAtIndex(futureBon, index);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }
}
