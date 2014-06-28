{$$$, View} = require 'atom'

module.exports =
class InspectorView extends View
  @content: ->
    @div tabIndex: -1, class: 'hex-inspector tool-panel panel-bottom', =>
      @div class: 'block', =>
        @span outlet: 'descriptionLabel', class: 'description', 'Hex Inspector : Big Endian'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'byte:'
        @span outlet: 'byteValue', class: 'inspector-value', '131'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'short:'
        @span outlet: 'shortValue', class: 'inspector-value', '-125'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'word:'
        @span outlet: 'wordValue', class: 'inspector-value', '33537'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'int:'
        @span outlet: 'intValue', class: 'inspector-value', '-31999'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'dword:'
        @span outlet: 'dwordValue', class: 'inspector-value', '2197880922'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'longint:'
        @span outlet: 'longintValue', class: 'inspector-value', '-2097086374'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'float:'
        @span outlet: 'floatValue', class: 'inspector-value', '-3.791010e-37'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'double:'
        @span outlet: 'doubleValue', class: 'inspector-value', '-3.327502e-294'

      @div class: 'inspector-container block', =>
        @span class: 'inspector-label', 'binary:'
        @span outlet: 'binaryValue', class: 'inspector-value', '10000011'

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
      @byteValue.text('AF')
