import "package:app/features/new_order/presentation/widgets/menu_item_card.dart";
import "package:flutter/material.dart";

class PhoneOrderGrid extends StatelessWidget {
  const PhoneOrderGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mad',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                    CustomCard(text: "Forret", onPressed: () => {}),
                    CustomCard(text: "Hovedret", onPressed: () => {}),
                    CustomCard(text: "Salat", onPressed: () => {}),
                    CustomCard(text: "Desert", onPressed: () => {}),
                    CustomCard(text: "Andet", onPressed: () => {}),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Drikkevarer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      CustomCard(text: "Sodavand og saft", onPressed: () => {}),
                      CustomCard(text: "Vin", onPressed: () => {}),
                      CustomCard(text: "Øl", onPressed: () => {}),
                      CustomCard(text: "Cocktails", onPressed: () => {}),
                      CustomCard(text: "Kaffe", onPressed: () => {}),
                      CustomCard(text: "Kakao og te", onPressed: () => {}),
                      CustomCard(text: "Andet", onPressed: () => {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
