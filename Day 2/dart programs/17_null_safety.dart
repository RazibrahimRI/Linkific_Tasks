void main() {
  String? nullableName; // can be null
  String nonNullableName = 'Razi'; // cannot be null

  nullableName = 'Maybe null';

  // Null-aware operator ?.
  print(nullableName?.length);

  // Null-coalescing operator ??
  String displayName = nullableName ?? 'Default Name';
  print(displayName);

  nullableName = null;
  print(nullableName ?? 'Default Name'); // uses default now

  // Null assertion ! - use only when certain it's not null
  String? maybeText = 'Certain text';
  String certainText = maybeText!;
  print(certainText);
}