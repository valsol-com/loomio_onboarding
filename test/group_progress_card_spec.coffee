describe 'Group progress card', ->

  page = require './helpers/page_helper.coffee'

  beforeEach ->
    page.loadPath 'setup_progress_card'

  it 'is only visible to group coordinators', ->
    page.expectText '.group-progress-card' 'Activate your group'

  it 'is not visible to non-coordinators', ->

  it 'adds a strikethrough and a tick to completed tasks', ->

  it 'displays a celebratory message when setup is complete', ->

  it 'can be dismissed', ->
