import 'package:via_app/model/volunteer_opportunity.dart';

enum ActionStatus { agendada, concluida, cancelada }
class UserAction {
  final String id;
  final VolunteerOpportunity opportunity;
  final VolunteerSchedule schedule;
  final ActionStatus status;

  UserAction({
    required this.id,
    required this.opportunity,
    required this.schedule,
    required this.status,
  });
}

final List<UserAction> mockUserActions = [
  UserAction(
    id: '1',
    opportunity: mockOpportunities[0],
    schedule: mockOpportunities[0].schedules[0],
    status: ActionStatus.agendada,
  ),
  UserAction(
    id: '2',
    opportunity: mockOpportunities[1],
    schedule: mockOpportunities[1].schedules[0],
    status: ActionStatus.concluida,
  ),
  UserAction(
    id: '3',
    opportunity: mockOpportunities[2],
    schedule: mockOpportunities[2].schedules[0],
    status: ActionStatus.cancelada,
  ),
];