class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Add your OpenWeatherMap API key here
  // Get one for free at: https://openweathermap.org/api
  static const String apiKey = 'YOUR_API_KEY_HERE';
  
  // Endpoints
  static const String weatherEndpoint = '/weather';
  static const String forecastEndpoint = '/forecast';
}
