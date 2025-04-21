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