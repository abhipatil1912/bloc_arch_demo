abstract class ApiConst {
  //!NOTE [ set the base url for dev and prod env ]
  //  static const baseURL = String.fromEnvironment('FLAVOR') == 'APP'
  //     ? "https://app.api.com";
  //     : "https://dev.api.com"

  //? base url
  static const baseURL = "https://625e3d7d6c48e8761ba71c0f.mockapi.io";

  //? auth api
  static const register = "";

  //? users [ for development & production ]
  static const users =
      String.fromEnvironment('FLAVOR') == 'APP' ? "/app-users" : "/dev-users";
}
