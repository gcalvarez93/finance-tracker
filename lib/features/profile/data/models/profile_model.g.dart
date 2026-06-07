// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      language: json['language'] as String,
      notifications: json['notifications'] as bool,
      notificationsGeneral: json['notificationsGeneral'] as bool,
      notificationsTransactions: json['notificationsTransactions'] as bool,
      notificationsBudgets: json['notificationsBudgets'] as bool,
      notificationsReports: json['notificationsReports'] as bool,
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'language': instance.language,
      'notifications': instance.notifications,
      'notificationsGeneral': instance.notificationsGeneral,
      'notificationsTransactions': instance.notificationsTransactions,
      'notificationsBudgets': instance.notificationsBudgets,
      'notificationsReports': instance.notificationsReports,
    };
