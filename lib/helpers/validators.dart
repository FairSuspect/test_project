/// Валидаторы текстовых полей
class Validators {
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) return "Это поле должно быть заполнено";
    return null;
  }
}
