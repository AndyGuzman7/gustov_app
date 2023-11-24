abstract class ModelConvert<T> {
  Map<String, dynamic> toJson();
  T fromSnapshot(Map<String, dynamic> snapshot);
}

abstract class DropdownInfo<T> {
  T get value;
  String get tag;
}
