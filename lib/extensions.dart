extension validation on String
{
  bool isValidEmail()
  {
    return (contains("@") && length > 5 && endsWith(".com"));
  }
  bool isValidPassword() {
    return (trim().length > 7);
  }

}