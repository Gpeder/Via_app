enum UserType { voluntario, organizacao }

class UserProfile {
  final String id;
  final String name;
  final UserType type;
  final String? imageUrl;
  final String location;
  final String bio;
  final List<String> interests;
  final int totalHours;
  final int activitiesCount;
  final int impactPoints;

  UserProfile({
    required this.id,
    required this.name,
    required this.type,
    this.imageUrl,
    required this.location,
    required this.bio,
    required this.interests,
    this.totalHours = 0,
    this.activitiesCount = 0,
    this.impactPoints = 0,
  });
}

final UserProfile mockCurrentUser = UserProfile(
  id: 'user_01',
  name: 'Camila Gomes',
  type: UserType.voluntario,
  imageUrl:
      'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
  location: 'São Paulo - SP',
  bio:
      'Estudante de Psicologia apaixonada por causas sociais e meio ambiente. Acredito que pequenas ações transformam o mundo.',
  interests: ['Meio Ambiente', 'Educação'],
  totalHours: 24,
  activitiesCount: 8,
  impactPoints: 420,
);
