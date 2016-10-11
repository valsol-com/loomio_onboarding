angular.module('loomioApp').directive 'groupProgressCard', ->
  scope: {group: '='}
  restrict: 'E'
  templateUrl: 'generated/components/group_page/group_progress_card/group_progress_card.html'
  replace: true
  controller: ($scope, Session) ->

    $scope.userHasProfilePicture = ->
      Session.user().hasProfilePhoto()
