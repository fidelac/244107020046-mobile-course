String routeFromMessage(Map<String, dynamic> data) {
  final route = data['route'] as String? ?? '/';

  if (route.isEmpty) {
    return '/';
  }

  return route.startsWith('/') ? route : '/$route';
}