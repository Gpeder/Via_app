class DateHelper {
  static String formatShortDate(DateTime date) {

    const weekdays = [
      '',
      'Seg',
      'Ter',
      'Qua',
      'Qui',
      'Sex',
      'Sáb',
      'Dom'
    ];
    
    const months = [
      '',
      'jan', 'fev', 'mar', 'abr', 'mai', 'jun', 
      'jul', 'ago', 'set', 'out', 'nov', 'dez'
    ];

    String weekDayStr = weekdays[date.weekday];
    String monthStr = months[date.month];
    
    return '$weekDayStr, ${date.day} $monthStr';
  }
}
