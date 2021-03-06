url = require 'url'
fs = require 'fs-plus'
HexView = null

module.exports =
  configDefaults:
    bytesPerLine: 16
    
  activate: ->
    atom.project.registerOpener (uriToOpen) ->
      {protocol, host, pathname} = url.parse(uriToOpen)
      pathname = decodeURI(pathname) if pathname
      return unless protocol is 'hex:'

      HexView ?= require './hex-view'
      new HexView(filePath: pathname)

    atom.workspaceView.command 'hex:view', ->
      if atom.workspace.activePaneItem?
        uri = atom.workspace.activePaneItem.getUri()
        if uri and fs.existsSync(uri)
          atom.workspaceView.open("hex://#{uri}")
        else
          console.warn "File (#{uri}) does not exists"
