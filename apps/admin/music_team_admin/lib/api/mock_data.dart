import 'package:music_team_admin/models/service/service_model.dart';
import 'package:music_team_admin/models/service/song_record.dart';
import 'package:music_team_admin/models/notifications/team_notification.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/models/user/user_role.dart';
import 'package:music_team_admin/models/common/year_month_day.dart';

List<TeamNotification> notificationsTestEntries = [
  TeamNotification(
      id: 'team-notification-1',
      title: 'Please sign up for March and April team!',
      content: 'As I mentioned above, please sign up!'),
  TeamNotification(
      id: 'team-notification-2',
      title: 'Roster is ready, team!',
      content: 'Please check your slots.'),
];

ServiceModel serviceModelTestEntry = ServiceModel(
  date: YearMonthDay(year: 2023, month: 3, day: 5),
  duty: {},
  rehearsalDates: [YearMonthDay(year: 2023, month: 3, day: 4)],
  songs: [
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-2',
        songName: 'Slient Night',
        note: 'on key G, only guitar and vocal'),
  ],
);

List<UserModel> testUsers = [
  UserModel(
      uid: 'user-1',
      name: 'Jeff',
      email: 'jeff@gmail.com',
      phone: '89289093',
      roles: [UserRole.lead, UserRole.bass]),
  UserModel(
      uid: 'user-2',
      name: 'Grace Young',
      email: 'graceyoung@gmail.com',
      phone: '89289222',
      roles: [UserRole.vocal]),
  UserModel(
      uid: 'user-3',
      name: 'James',
      email: 'james@gmail.com',
      phone: '89289282',
      roles: [UserRole.guitar, UserRole.bass]),
  UserModel(
      uid: 'user-4',
      name: 'Grace Yu',
      email: 'grace.yu@gmail.com',
      phone: '89289282',
      roles: [UserRole.piano, UserRole.drums]),
  UserModel(
      uid: 'user-5',
      name: 'Yong Bin',
      email: 'yongbin@gmail.com',
      phone: '89289282',
      roles: [UserRole.lead, UserRole.guitar]),
  UserModel(
      uid: 'user-6',
      name: 'Gavin',
      email: 'gavin@gmail.com',
      phone: '89282182',
      roles: [UserRole.drums]),
  UserModel(
      uid: 'user-7',
      name: 'Kelvin',
      email: 'kelvin@gmail.com',
      phone: '+22289282',
      roles: [UserRole.vocal, UserRole.piano]),
  UserModel(
      uid: 'user-8',
      name: 'Simon',
      email: 'simon@gmail.com',
      phone: '89289282',
      roles: [UserRole.pa]),
];

// Map<String, UserModel> userMap = {
//   'user-1': testUsers[0],
//   'user-2': testUsers[1],
//   'user-3': testUsers[2],
//   'user-4': testUsers[3],
//   'user-5': testUsers[4],
//   'user-6': testUsers[5],
//   'user-7': testUsers[6],
//   'user-8': testUsers[7],
// };
