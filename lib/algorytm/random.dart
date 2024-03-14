import 'dart:math';

import 'package:my_app_2/models/importantEvent.dart';

class RandomDateGenerator {
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDates;

  static DateTime beginningOfYear = DateTime.utc(DateTime.now().year, 1, 1);
  static DateTime endOfYear = DateTime.utc(DateTime.now().year + 1, 1, 1);

  RandomDateGenerator({
    required this.numberOfDates,
  }) : startDate = beginningOfYear,
        endDate = endOfYear;

  List<ImportantEvent> generateRandomDates() {
    Random random = Random();
    List<ImportantEvent> randomEvents = [];
    int rangeInDays = endDate.difference(startDate).inDays;

    for (int i = 0; i < numberOfDates; i++) {
      int randomDays = random.nextInt(rangeInDays);
      DateTime randomDate = startDate.add(Duration(days: randomDays));
      ImportantEvent event = ImportantEvent(eventName: "Event", eventDate: randomDate);

      // Add the random date to the list
      randomEvents.add(event);
    }

    return randomEvents;
  }
}

// void main() {
//   // Example usage
//   DateTime startDate = DateTime(2022, 1, 1);
//   DateTime endDate = DateTime(2023, 1, 1);
//   int numberOfDates = 5;
//
//   RandomDateGenerator generator =
//   RandomDateGenerator(startDate: startDate, endDate: endDate, numberOfDates: numberOfDates);
//   List<DateTime> randomDates = generator.generateRandomDates();
//
//
// }
