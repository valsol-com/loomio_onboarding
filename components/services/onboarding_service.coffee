angular.module('loomioApp').factory 'OnboardingService', (Session) ->
  new class OnboardingService

    showIntroCarousel: (group) ->
      Loomio.pluginConfig('loomio_onboarding') &&
      group.isParent() &&
      Session.user().isMemberOf(group) &&
      !Session.user().hasExperienced("introductionCarousel") &&
      group.createdAt.isAfter(moment("2016-11-05"))
