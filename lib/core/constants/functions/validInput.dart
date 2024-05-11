validinput(String val, int max, int min) {
  if (val.length > max) {
    return "It cannot be greater than $max";
  }
  if (val.isEmpty) {
    return "It's required";
  }
  if (val.length < min) {
    return "It cannot be smaller than $min";
  }
}
