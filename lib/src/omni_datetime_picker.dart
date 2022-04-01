import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/src/time_picker_spinner.dart';

/// Omni DateTime Picker
///
/// If properties are not given, default value will be used.
class OmniDateTimePicker extends StatefulWidget {
  /// Start initial datetime
  ///
  /// Default value: DateTime.now()
  final DateTime? startInitialDate;

  /// Minimum date that can be selected
  ///
  /// Default value: DateTime.now().subtract(const Duration(days: 3652))
  final DateTime? startFirstDate;

  /// Maximum date that can be selected
  ///
  /// Default value: DateTime.now().add(const Duration(days: 3652))
  final DateTime? startLastDate;

  final bool? is24HourMode;
  final bool? isShowSeconds;
  final bool showTime;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? calendarTextColor;
  final Color? tabTextColor;
  final Color? unselectedTabBackgroundColor;
  final Color? buttonTextColor;
  final TextStyle? timeSpinnerTextStyle;
  final TextStyle? timeSpinnerHighlightedTextStyle;
  final Radius? borderRadius;

  const OmniDateTimePicker({
    Key? key,
    this.startInitialDate,
    this.startFirstDate,
    this.startLastDate,
    this.is24HourMode,
    this.showTime = true,
    this.isShowSeconds,
    this.primaryColor,
    this.backgroundColor,
    this.calendarTextColor,
    this.tabTextColor,
    this.unselectedTabBackgroundColor,
    this.buttonTextColor,
    this.timeSpinnerTextStyle,
    this.timeSpinnerHighlightedTextStyle,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<OmniDateTimePicker> createState() => _OmniDateTimePickerState();
}

class _OmniDateTimePickerState extends State<OmniDateTimePicker>
    with SingleTickerProviderStateMixin {
  /// startDateTime will be returned after clicking Done
  ///
  /// Initial value: Current DateTime
  DateTime startDateTime = DateTime.now();

  @override
  void initState() {
    if (widget.startInitialDate != null) {
      startDateTime = widget.startInitialDate!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: widget.primaryColor ?? Colors.blue,
                surface: widget.backgroundColor ?? Colors.white,
                onSurface: widget.calendarTextColor ?? Colors.black,
              ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            size < 668
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.backgroundColor ?? Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: widget.borderRadius ??
                                const Radius.circular(16),
                            topRight: widget.borderRadius ??
                                const Radius.circular(16)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CalendarDatePicker(
                            initialDate:
                                widget.startInitialDate ?? DateTime.now(),
                            firstDate: widget.startFirstDate ??
                                DateTime.now()
                                    .subtract(const Duration(days: 3652)),
                            lastDate: widget.startLastDate ??
                                DateTime.now().add(const Duration(days: 3652)),
                            onDateChanged: (dateTime) {
                              startDateTime = DateTime(
                                dateTime.year,
                                dateTime.month,
                                dateTime.day,
                                startDateTime.hour,
                                startDateTime.minute,
                              );
                            },
                          ),
                          if (widget.showTime)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: size > 668 ? 26.0 : 10.0),
                                child: TimePickerSpinner(
                                  is24HourMode: widget.is24HourMode ?? false,
                                  isShowSeconds: widget.isShowSeconds ?? false,
                                  normalTextStyle:
                                      widget.timeSpinnerTextStyle ??
                                          TextStyle(
                                              fontSize: size > 668 ? 18 : 14.0,
                                              color: widget.calendarTextColor ??
                                                  Colors.black54),
                                  highlightedTextStyle:
                                      widget.timeSpinnerHighlightedTextStyle ??
                                          TextStyle(
                                              fontSize: size > 668 ? 18 : 14.0,
                                              color: widget.calendarTextColor ??
                                                  Colors.black),
                                  time: startDateTime,
                                  onTimeChange: (dateTime) {
                                    DateTime tempStartDateTime = DateTime(
                                      startDateTime.year,
                                      startDateTime.month,
                                      startDateTime.day,
                                      dateTime.hour,
                                      dateTime.minute,
                                      dateTime.second,
                                    );

                                    startDateTime = tempStartDateTime;
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              widget.borderRadius ?? const Radius.circular(16),
                          topRight:
                              widget.borderRadius ?? const Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CalendarDatePicker(
                          initialDate:
                              widget.startInitialDate ?? DateTime.now(),
                          firstDate: widget.startFirstDate ??
                              DateTime.now()
                                  .subtract(const Duration(days: 3652)),
                          lastDate: widget.startLastDate ??
                              DateTime.now().add(const Duration(days: 3652)),
                          onDateChanged: (dateTime) {
                            startDateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              startDateTime.hour,
                              startDateTime.minute,
                            );
                          },
                        ),
                        if (widget.showTime)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: size > 668 ? 26.0 : 10.0),
                            child: TimePickerSpinner(
                              is24HourMode: widget.is24HourMode ?? false,
                              isShowSeconds: widget.isShowSeconds ?? false,
                              normalTextStyle: widget.timeSpinnerTextStyle ??
                                  TextStyle(
                                      fontSize: size > 668 ? 18 : 14.0,
                                      color: widget.calendarTextColor ??
                                          Colors.black54),
                              highlightedTextStyle:
                                  widget.timeSpinnerHighlightedTextStyle ??
                                      TextStyle(
                                          fontSize: size > 668 ? 18 : 14.0,
                                          color: widget.calendarTextColor ??
                                              Colors.black),
                              time: startDateTime,
                              onTimeChange: (dateTime) {
                                DateTime tempStartDateTime = DateTime(
                                  startDateTime.year,
                                  startDateTime.month,
                                  startDateTime.day,
                                  dateTime.hour,
                                  dateTime.minute,
                                  dateTime.second,
                                );

                                startDateTime = tempStartDateTime;
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: widget.borderRadius ?? const Radius.circular(16),
                  bottomRight: widget.borderRadius ?? const Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  const Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.grey.shade400,
                            padding: EdgeInsets.zero,
                            backgroundColor: widget.backgroundColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop<DateTime>();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: widget.buttonTextColor ?? Colors.black,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          width: 0.0,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.grey.shade400,
                            padding: EdgeInsets.zero,
                            backgroundColor: widget.backgroundColor,
                          ),
                          onPressed: () {
                            Navigator.pop<DateTime>(
                              context,
                              startDateTime,
                            );
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: widget.buttonTextColor ?? Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
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
