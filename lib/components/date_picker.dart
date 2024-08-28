import 'package:checklistapp/helper/g_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime)? onPickedDate;
  final DateTime? initialDate;
  const DatePicker({this.initialDate, this.onPickedDate, super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late var dateTime = widget.initialDate ??
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isToday = dateTime.day == DateTime.now().day;
    final isTmr =
        dateTime.day == DateTime.now().add(const Duration(days: 1)).day;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final now = DateTime.now();
            setState(() => dateTime = DateTime(now.year, now.month, now.day));
            widget.onPickedDate?.call(dateTime);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: GColor.scheme.primary,
              ),
              color: isToday ? GColor.scheme.primary : GColor.scheme.surface,
            ),
            child: Text(
              "Today",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    isToday ? GColor.scheme.onPrimary : GColor.scheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              final now = DateTime.now();
              dateTime = DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 1));
            });
            widget.onPickedDate?.call(dateTime);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: GColor.scheme.primary,
              ),
              color: isTmr ? GColor.scheme.primary : GColor.scheme.surface,
            ),
            child: Text(
              "Tomorrow",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isTmr ? GColor.scheme.onPrimary : GColor.scheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: showDateTime,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: GColor.scheme.surfaceContainer),
                color: GColor.scheme.surfaceContainer,
              ),
              child: Text(
                DateFormat('dd/MM/yyyy').format(dateTime),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() => dateTime = date);
    widget.onPickedDate?.call(date);
  }
}
