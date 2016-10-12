describe 'Group progress card', ->

  page = require '../../../angular/test/protractor/helpers/page_helper.coffee'
  staticPage = require '../../../angular/test/protractor/helpers/static_page_helper.coffee'

  it 'is only visible to group coordinators', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.expectText '.group-progress-card', 'ACTIVATE YOUR GROUP'

  it 'is only visible to group coordinators', ->
    page.loadPath 'setup_progress_card_member'
    page.expectNoText '.group-page', 'ACTIVATE YOUR GROUP'

  it 'adds a tick to completed tasks', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.expectText '.group-progress-card', '✅'

  it 'displays a celebratory message when setup is complete', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.clickLast '.thread-preview__link'
    page.click '.start-proposal-button__button'
    page.fillIn '.proposal-form__title-field', 'New proposal'
    page.click '.proposal-form__start-btn'
    page.click '.group-theme__name--compact a'
    page.expectText '.group-progress-card', "Nice! You're group is good to go!"

  it 'can be dismissed', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.click '.group-progress-card__dismiss'
    page.expectNoText '.group-page', 'ACTIVATE YOUR GROUP'
