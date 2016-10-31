describe 'Introduction carousel', ->

  page = require '../../../angular/test/protractor/helpers/page_helper.coffee'
  staticPage = require '../../../angular/test/protractor/helpers/static_page_helper.coffee'

  it 'is visible to members of parent groups', ->
    page.loadPath 'setup_group'
    page.expectText '.introduction-carousel', 'Gather'

  it 'is not visible to members of subgroups', ->
    page.loadPath 'setup_subgroup'
    page.expectNoElement '.introduction-carousel'

  it 'can be dismissed', ->
    page.loadPath 'setup_group'
    page.click '.introduction-carousel__button--get-started'
    browser.refresh()
    page.expectNoElement '.introduction-carousel'
