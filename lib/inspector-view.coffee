{$$$, View} = require 'atom'

module.exports =
class InspectorView extends View
  @content: ->
    @div tabIndex: -1, class: 'hex-inspector tool-panel panel-bottom', =>
      @div class: 'block', =>
        @span outlet: 'descriptionLabel', class: 'description', 'Hex Inspector'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'Byte:'
        @span outlet: 'byteValue', class: 'inspector-value', 'FF'

  initialize: ->
    @handleEvents()
    @showInspector()

  handleEvents: ->
    @on 'core:cancel core:close', @detach
    # old editor
    atom.workspaceView.on 'selection:changed', @setInspectorDataFromSelection
    # react editor
    atom.workspace.eachEditor (editor) =>
      @subscribe editor, 'selection-added selection-screen-range-changed', @setInspectorDataFromSelection

  isAttached: -> @hasParent()

  showInspector: =>
    @attach() unless @isAttached()

  attach: =>
    atom.workspaceView.prependToBottom(this)
    atom.workspaceView.addClass('inspector-visible')

  detach: =>
    return unless @isAttached()

    atom.workspaceView.focus()
    atom.workspaceView.removeClass('inspector-visible')
    super()

  setInspectorDataFromSelection: =>
    if @isAttached()
      console.log("setInspectorDataFromSelection")
