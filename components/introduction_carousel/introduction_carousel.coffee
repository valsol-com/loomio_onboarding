angular.module('loomioApp').directive 'introductionCarousel', ->
  scope: { group: '=?' }
  restrict: 'E'
  templateUrl: 'generated/components/introduction_carousel/introduction_carousel.html'
  replace: true
  controller: ($scope, $timeout, Session, $rootScope, Records) ->

    $scope.$on 'launchIntroCarousel', ->
      $scope.showIntroCarousel = true
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

    timer = ""
    automateTransition = ->
      $timeout(5000).then ->
        if $scope.slideIndex == 3
          $scope.$broadcast '$destroy'
        else
          timer = $timeout((->
            $scope.nextSlide()
            timer = $timeout(automateTransition, 5000)
          ), 5000)
          return
    automateTransition()

    $scope.$on '$destroy', ->
      $timeout.cancel(timer)
