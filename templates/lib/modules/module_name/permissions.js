import Users from 'meteor/vulcan:users';

const membersActions = [
  '%MODULE_NAME_U%s.new',
  '%MODULE_NAME_U%s.edit.own',
  '%MODULE_NAME_U%s.remove.own',
];
Users.groups.members.can(membersActions);

const adminActions = [
  '%MODULE_NAME_U%s.edit.all',
  '%MODULE_NAME_U%s.remove.all'
];
Users.groups.admins.can(adminActions);
