angular.module('loomioApp').directive 'introductionCarousel', ->
  scope: {}
  restrict: 'E'
  templateUrl: 'generated/components/introduction_carousel/introduction_carousel.html'
  replace: true
  controller: ($scope, $timeout, $interval, $rootScope, $location, Session, Records) ->

    $scope.$on 'launchIntroCarousel', (event, group) ->
      $scope.group = group
      $timeout($scope.showIntroCarousel = true).then ->
        return unless document.querySelector('.introduction-carousel').focus()
      $rootScope.$broadcast('toggleSidebar', false)
      $rootScope.$broadcast('toggleNavbar', false)

    $scope.slides =
      ['Welcome', 'Gather', 'Discuss', 'Propose', 'Act']
    $scope.slideIndex = 0
    $scope.maxSlideIndex = $scope.slides.length - 1

    $scope.dismiss = ->
      Records.users.saveExperience("introductionCarousel")
      $scope.showIntroCarousel = false
      $rootScope.$broadcast 'toggleNavbar', true
      $rootScope.$broadcast 'toggleSidebar', true
      $location.search('welcome=youhavearrived')

    $scope.nextSlide = (haltAnimation) ->
      applyAnimationClasses("go-left", "go-right")
      $scope.transition($scope.slideIndex + 1, haltAnimation)

    $scope.prevSlide = (haltAnimation) ->
      applyAnimationClasses("go-right", "go-left")
      $scope.transition($scope.slideIndex - 1, haltAnimation)

    $scope.isCurrentSlideIndex = (index) ->
      $scope.slideIndex == index

    $scope.transition = (index, haltAnimation) ->
      $interval.cancel(timer) if haltAnimation
      if (index < $scope.slideIndex)
        applyAnimationClasses("go-right", "go-left")
      else
        applyAnimationClasses("go-left", "go-right")
      $scope.slideIndex = index

    applyAnimationClasses = (add, remove) ->
      return unless $element = document.querySelector('.introduction-carousel__slides')
      $element.classList.remove(remove)
      $element.classList.add(add)

    timer = $interval(->
      $scope.nextSlide($scope.slideIndex == $scope.maxSlideIndex - 1)
    , 8000)
