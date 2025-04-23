/// Determines whether there is electricity on a given date based on a 2-days-on, 1-day-off pattern.
///
/// The function calculates the number of days between the given date and the start date,
/// and then uses modulo 3 to determine whether the given date falls on an "on" day or an "off" day.
///
/// Args:
///   date (DateTime): The date to check for electricity.
///   startDate (DateTime): The start date of the electricity usage pattern.
///
/// Returns:
///   bool: True if there is electricity on the given date, false otherwise.
bool hasElectricity(DateTime date, DateTime startDate) {
  // Normalize both dates to start of day to avoid time issues
  final normalizedDate = DateTime(date.year, date.month, date.day);
  final normalizedStartDate = DateTime(startDate.year, startDate.month, startDate.day);
  
  // Calculate the number of days since the start date
  final difference = normalizedDate.difference(normalizedStartDate).inDays;
  
  // Handle negative differences (dates before start date)
  final adjustedDifference = difference < 0 ?
    ((difference % 3) + 3) % 3 : // Handle negative values
    difference;
  
  // For a 2-days-on, 1-day-off pattern, we use modulo 3
  // If the remainder is 0 or 1, it's an ON day (first two days of the pattern)
  // If the remainder is 2, it's an OFF day (third day of the pattern)
  final dayInPattern = adjustedDifference % 3;
  
  return dayInPattern == 0 || dayInPattern == 1;
}