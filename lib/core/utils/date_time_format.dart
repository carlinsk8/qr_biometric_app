extension DateTimeFormatExtension on String {
  /// Formatea un string ISO8601 a 'dd/MM/yyyy HH:mm'
  String toFormattedDateTime() {
    try {
      final dateTime = DateTime.parse(this);
      final formattedDate = '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
      final formattedTime = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      return '$formattedDate $formattedTime';
    } catch (_) {
      return this; // Si no puede parsear, retorna el mismo string
    }
  }
}
