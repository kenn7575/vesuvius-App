String generateComment(String baseComment, int copyNumber) {
  return copyNumber == 0 ? baseComment : "$baseComment ($copyNumber)";
}
