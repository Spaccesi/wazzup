enum AppRoute {
  signIn(
    path: '/auth',
    name: 'AUTH',
    title: 'Access page',
  ),
  home(
    path: '/',
    name: 'HOME',
    title: 'Home',
  ),
  chat(
    path: '/chat/:id',
    name: 'CHAT',
    title: 'Chat',
  ),
  createChat(
    path: '/chat/new',
    name: 'CHAT_CREATE',
    title: 'Chat',
  ),
  updateChat(
    path: '/chat/:id/update',
    name: 'CHAT_UPDATE',
    title: 'Chat',
  ),
  profile(
    path: '/profile/:id',
    name: 'PROFILE',
    title: 'Profile',
  ),
  updateProfile(
    path: '/profile/:id/update',
    name: 'PROFILE_UPDATE',
    title: 'Profile',
  ),
  ;

  final String path;
  final String name;
  final String title;
  const AppRoute({
    required this.path,
    required this.name,
    required this.title,
  });
}
