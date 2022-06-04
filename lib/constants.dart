class Constants {
  static const base = "http://insigniapp.digitaezonline.com/";

  static const tokenURL = base + "api/v1/auth/login";
  static const getMeURL = base + "api/v1/auth/me";
  static const updateDetails = base + "api/v1/auth/updateDetails";
  static const ForgotPasswordURL = base + "api/v1/auth/forgotPassword";
  static const profileUploads = base + "uploads/profile/";
  static const getOfficeTiming = base + "api/v1/officeTiming/getOfficeTiming";
  static const getEmployeeOfTheDay =
      base + "api/v1/rewards/getEmployeeOfTheDay";
  static const getEmployeeOfTheMonth =
      base + "api/v1/rewards/getEmployeeOfTheMonth";
  static const Rewards = base + "api/v1/rewards";
  static const Wallet = base + "api/v1/wallet";
  static const productUploads = base + "uploads/products/";
  static const product = base + "api/v1/products?status=Active";
  static const dish = base + "api/v1/dish?status=Active";
  static const dishUploads = base + "uploads/dish/";
  static const dishVote = base + "api/v1/poll";
  static const attendance = base + "api/v1/attendance";
  static const leave = base + "api/v1/leaveRequests";
}
