import 'dart:math';

double degreeToRadians(double degrees) => degrees * (pi / 180);

double roundToBase(double number, int base) {
  double reminder = number % base;
  double result = number;
  if (reminder < (base / 2)) {
    result = number - reminder;
  } else {
    result = number + (base - reminder);
  }
  return result;
}
