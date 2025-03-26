enum Method { GET, POST, PATCH, PUT, DELETE }

class ApiEndpoint {
  final String path;
  final Method method;

  ApiEndpoint({required this.path, required this.method});
}

class ApiConfig {
  final String url;
  Map<String, dynamic>? headerData;
  final Map<String, ApiEndpoint> apiEndpoints;

  ApiConfig({
    required this.url,
    required this.apiEndpoints,
    this.headerData,
  });
}

class ApiConfiguations {
  Map<String, String> staticURL = {};
  Map<String,  ApiConfig> host = {};

  ApiConfiguations({required this.staticURL, required this.host});
}
