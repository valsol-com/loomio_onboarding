angular.module('loomioApp').directive 'introductionCarousel', ->
  scope: { group: '=?' }
  restrict: 'E'
  templateUrl: 'generated/components/introduction_carousel/introduction_carousel.html'
  replace: true
  controller: ($scope, Session, $rootScope) ->
    $scope.dismissed = false

    $scope.show = ->
      $scope.group.isParent() &&
      Session.user().isMemberOf($scope.group) &&
      !Session.subscriptionSuccess &&
      !Session.user().hasExperienced("introductionCarousel") &&
      !$scope.dismissed

    $scope.dismiss = ->
      $scope.dismissed = true

    $scope.currentSlide = 'Gather'

    $scope.nextSlide = ->
      $scope.currentSlide = switch $scope.currentSlide
        when 'Gather' then 'Discuss'
        when 'Discuss' then 'Propose'
        when 'Propose' then 'Act'
        when 'Act' then 'Gather'

    $scope.prevSlide = ->
      $scope.currentSlide = switch $scope.currentSlide
        when 'Gather' then 'Act'
        when 'Discuss' then 'Gather'
        when 'Propose' then 'Discuss'
        when 'Act' then 'Propose'

    # $scope.slides = [
    #   {image: 'img/gather.png', title: 'Gather', description: "All your Loomio activity happens with a group. Check who's here and invite people if anyone is missing."},
    #   {image: 'img/discuss.png', title: 'Discuss', description: "Start a thread to have a discussion with your group members. Keep each thread focussed on one topic."},
    #   {image: 'img/propose.png', title: 'Propose', description: "Use a proposal to move a thread towards a conclusion: everyone is asked to have their say on a specific course of action."},
    #   {image: 'img/act.png', title: 'Decide & Act', description: "When the proposal closes you'll get a visual summary of everyone's input. Notify everyone of the outcome so the next steps are clear."}
    # ]

    # $scope.currentIndex = 0
    #
    # $scope.setCurrentSlideIndex = (index) ->
    #   $scope.currentIndex = index
    #
    # $scope.isCurrentSlideIndex = (index) ->
    #   $scope.currentIndex == index
    #
    # $scope.prevSlide = ->
    #   $scope.currentIndex = if $scope.currentIndex < $scope.slides.length - 1 then ++$scope.currentIndex else 0
    #
    # $scope.nextSlide = ->
    #   $scope.currentIndex = if $scope.currentIndex > 0 then --$scope.currentIndex else $scope.slides.length - 1
