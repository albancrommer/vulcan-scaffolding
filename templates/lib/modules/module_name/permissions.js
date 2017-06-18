import Users from 'meteor/vulcan:users';

const membersActions = [
  '%MODULE_NAME_U%.new',
  '%MODULE_NAME_U%.edit.own',
  '%MODULE_NAME_U%.remove.own',
];
Users.groups.members.can(membersActions);

const adminActions = [
  '%MODULE_NAME_U%.edit.all',
  '%MODULE_NAME_U%.remove.all'
];
Users.groups.admins.can(adminActions);
