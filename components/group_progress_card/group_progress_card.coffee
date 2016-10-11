angular.module('loomioApp').directive 'groupProgressCard', ->
  scope: {group: '='}
  restrict: 'E'
  templateUrl: 'generated/components/group_progress_card/group_progress_card.html'
  replace: true
  controller: ($scope, Session, Records) ->
    group = $scope.group
    $scope.dismissed = false

    $scope.show = ->
      Session.user().isAdminOf($scope.group) &&
      !Session.user().hasExperienced("dismissProgressCard")

    $scope.userHasProfilePicture = ->
      Session.user().hasProfilePhoto()

    $scope.dismiss = ->
      Records.users.saveExperience("dismissProgressCard")
      $scope.dismissed = true

    $scope.setupComplete = ->
      $scope.group.setupComplete() &&
      $scope.userHasProfilePicture()
