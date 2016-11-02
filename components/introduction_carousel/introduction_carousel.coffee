angular.module('loomioApp').directive 'introductionCarousel', ->
  scope: { group: '=?' }
  restrict: 'E'
  templateUrl: 'generated/components/introduction_carousel/introduction_carousel.html'
  replace: true
  controller: ($scope, Session, $rootScope, Records) ->
    $rootScope.$broadcast 'toggleSidebar', false

    $scope.slides =
      ['Gather', 'Discuss', 'Propose', 'Act']
    $scope.slideIndex = 0
    $scope.maxSlideIndex = $scope.slides.length - 1

    $scope.show = ->
      $scope.group.isParent() &&
      Session.user().isMemberOf($scope.group) &&
      !Session.user().hasExperienced("welcomeModal") &&
      !Session.user().hasExperienced("introductionCarousel") &&
      $scope.group.createdAt.isAfter(moment("2016-10-31"))

    $scope.dismiss = ->
      Records.users.saveExperience("introductionCarousel")
      $rootScope.$broadcast 'toggleSidebar', true

    $scope.nextSlide = ->
      applyAnimationClasses("go-left", "go-right")
      newIndex = if $scope.slideIndex == $scope.maxSlideIndex then 0 else $scope.slideIndex + 1
      $scope.transition(newIndex)

    $scope.prevSlide = ->
      applyAnimationClasses("go-right", "go-left")
      newIndex = if $scope.slideIndex == 0 then $scope.maxSlideIndex else $scope.slideIndex - 1
      $scope.transition(newIndex)

    $scope.isCurrentSlideIndex = (index) ->
      $scope.slideIndex == index

    $scope.transition = (index) ->
      if (index < $scope.slideIndex)
        applyAnimationClasses("go-right", "go-left")
      else
        applyAnimationClasses("go-left", "go-right")
      $scope.slideIndex = index

    applyAnimationClasses = (add, remove) ->
      $element = document.querySelector('.introduction-carousel__slides')
      $element.classList.remove(remove)
      $element.classList.add(add)
