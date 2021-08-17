String addQuatationMarkIfNeeded(String str) {
  if (!str.startsWith("\"") && !str.endsWith("\"")) {
    return '"' + str + '"';
  }

  if (!str.startsWith("\"") && str.endsWith("\"")) {
    return '"' + str;
  }

  if (str.startsWith("\"") && !str.endsWith("\"")) {
    return str + '"';
  }

  return str;
}
