class Validators {
  static String? validateRecipient(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    final phoneRegex = RegExp(r'^\+20\d{10}$');

    if (value.isEmpty) return 'Recipient is required';

    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'Enter valid email or Egyptian phone number';
    }

    return null;
  }

  static String? validatePoints(String value, int availableBalance) {
    if (value.isEmpty) return 'Points required';

    final points = int.tryParse(value);
    if (points == null) return 'Invalid number';

    if (points < 100) return 'Minimum 100 points';

    if (points > availableBalance) {
      return 'Insufficient balance';
    }

    return null;
  }

  static String? validateNote(String value) {
    if (value.length > 150) {
      return 'Maximum 150 characters';
    }
    return null;
  }
}
