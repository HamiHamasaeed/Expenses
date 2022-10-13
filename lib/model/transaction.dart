// ignore_for_file: file_names

class Transaction {
  late final String id;
  late final String item;
  late final double amount;
  late final DateTime date;

  Transaction(
      {required this.id,
      required this.item,
      required this.amount,
      required this.date});
}
