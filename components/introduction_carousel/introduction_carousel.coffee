angular.module('loomioApp').directive 'introductionCarousel', ->
  scope: { group: '=?' }
  restrict: 'E'
  templateUrl: 'generated/components/introduction_carousel/introduction_carousel.html'
  replace: true
  controller: ($scope, $timeout, $interval, $rootScope, Session, Records) ->

    $scope.$on 'launchIntroCarousel', ->
      $timeout($scope.showIntroCarousel = true).then ->
        return unless document.querySelector('.introduction-carousel').focus()
      $rootScope.$broadcast('toggleSidebar', false)
      $rootScope.$broadcast('toggleNavbar', false)

    $scope.slides =
      ['Gather', 'Discuss', 'Propose', 'Act']
    $scope.slideIndex = 0
    $scope.maxSlideIndex = $scope.slides.length - 1

    $scope.dismiss = ->
      Records.users.saveExperience("introductionCarousel")
      $scope.showIntroCarousel = false
      $rootScope.$broadcast 'toggleNavbar', true
      $rootScope.$broadcast 'toggleSidebar', true

    $scope.nextSlide = ->
      applyAnimationClasses("go-left", "go-right")
      newIndex = if $scope.slideIndex == $scope.maxSlideIndex then 0 else $scope.slideIndex + 1
      $scope.transition(newIndex)

    $scope.clickNextSlide = ->
      $interval.cancel(timer)
      $scope.nextSlide()

    $scope.prevSlide = ->
      applyAnimationClasses("go-right", "go-left")
      newIndex = if $scope.slideIndex == 0 then $scope.maxSlideIndex else $scope.slideIndex - 1
      $scope.transition(newIndex)

    $scope.clickPrevSlide = ->
      $interval.cancel(timer)
      $scope.prevSlide()

    $scope.isCurrentSlideIndex = (index) ->
      $scope.slideIndex == index

    $scope.transition = (index) ->
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
      if $scope.slideIndex == 3
        $interval.cancel(timer)
      else
        $scope.nextSlide()
    , 8000)
