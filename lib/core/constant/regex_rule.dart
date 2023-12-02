import '../../core/constant/regex_validation.dart';

/* ----- blok program ini adalah pengaturan validasi ---------*/

class RegexRule {
  static RegexValidation emptyValidationRule =
      RegexValidation(regex: r'^(?!\s*$).+', errorMesssage: 'Wajib diisi');
  static RegexValidation numberValidationRule = RegexValidation(
      regex: r'^[0-9]*$', errorMesssage: 'Hanya boleh diisi angka');
  static RegexValidation emailValidationRule = RegexValidation(
      regex:
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorMesssage: 'format email salah');
  static RegexValidation alphabetValidationRule = RegexValidation(
    regex: r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
    errorMesssage: 'Hanya boleh diisi alfabet',
  );
  static RegexValidation nikValidationRule = RegexValidation(
      regex: r'^[0-9]{16}', errorMesssage: 'NIK harus 16 digit');
}

/* ----- blok program ini adalah pengaturan validasi ---------*/

