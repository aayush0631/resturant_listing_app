/// A utility class that provides reusable form field validation methods.
///
/// This class is designed to centralize validation logic so that:
/// - Code duplication is avoided across multiple forms.
/// - Validation rules remain consistent throughout the app.
/// - Future updates to validation logic can be made in one place.
///
/// All methods return:
/// - `null` → when validation passes
/// - `String` → error message when validation fails
///
/// Usage:
/// ```dart
/// validator: Validator.email
/// ```
/// or
/// ```dart
/// validator: (value) => Validator.required(value, 'Username')
/// ```
class Validator {

  /// Validates that the input is not null or empty.
  ///
  /// This is a **base validator** used by other validators to ensure
  /// the field has a value before applying further checks.
  ///
  /// Parameters:
  /// - [value]: The input string from the form field.
  /// - [fieldName]: The name of the field to display in the error message.
  ///
  /// Returns:
  /// - Error message if empty
  /// - `null` if valid
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => Validator.required(value, 'Email')
  /// ```
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates an email address.
  ///
  /// This method:
  /// 1. Ensures the field is not empty using [required]
  /// 2. Validates the format using a regular expression
  ///
  /// Rules:
  /// - Must contain '@'
  /// - Must have a valid domain (e.g., gmail.com)
  ///
  /// Returns:
  /// - Error message if invalid
  /// - `null` if valid
  ///
  /// Usage:
  /// ```dart
  /// validator: Validator.email
  /// ```
  static String? email(String? value) {
    final requiredValidation = required(value, 'Email');
    if (requiredValidation != null) {
      return requiredValidation;
    }

    /// Regex explanation:
    /// - Local part: letters, numbers, ., _, +, %, -
    /// - '@' symbol
    /// - Domain name
    /// - Top-level domain (min 2 characters)
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._+%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validates a person's name.
  ///
  /// This method:
  /// 1. Ensures the field is not empty using [required]
  /// 2. Applies length constraints
  /// 3. Restricts characters to alphabets and spaces only
  ///
  /// Rules:
  /// - Minimum 2 characters
  /// - Maximum 100 characters
  /// - Only letters and spaces allowed
  ///
  /// Returns:
  /// - Error message if invalid
  /// - `null` if valid
  ///
  /// Usage:
  /// ```dart
  /// validator: Validator.name
  /// ```
  static String? name(String? value) {
    final requiredValidation = required(value, 'Name');
    if (requiredValidation != null) {
      return requiredValidation;
    }

    final trimmed = value!.trim();

    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (trimmed.length > 100) {
      return 'Name must be less than 100 characters';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmed)) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }

  /// Validates the number of guests.
  ///
  /// This method:
  /// 1. Ensures the field is not empty using [required]
  /// 2. Converts the input to an integer
  /// 3. Applies range constraints
  ///
  /// Rules:
  /// - Must be a valid number
  /// - Minimum: 1 guest
  /// - Maximum: 20 guests
  ///
  /// Returns:
  /// - Error message if invalid
  /// - `null` if valid
  ///
  /// Usage:
  /// ```dart
  /// validator: Validator.noOfGuests
  /// ```
  static String? noOfGuests(String? value) {
    final requiredValidation = required(value, 'No of Guests');
    if (requiredValidation != null) {
      return requiredValidation;
    }

    final guest = int.tryParse(value!.trim());

    if (guest == null || guest < 1) {
      return 'Please enter a valid number';
    }

    if (guest > 20) {
      return 'Max guests is 20';
    }

    return null;
  }
}