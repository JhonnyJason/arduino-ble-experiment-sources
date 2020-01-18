uistatemodule = {name: "uistatemodule"}

#region modulesFromTheEnvironment
uiCommands = null
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["uistatemodule"]?  then console.log "[uistatemodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
uistatemodule.initialize = () ->
    log "uistatemodule.initialize"
    uiCommands = allModules.uicommandsmodule
    return
    
#region internalFunctions
#endregion

#region exposedFunctions
uistatemodule.setDisconnected = ->
    log "uistatemodule.setStateDisconnected"
    uiCommands.setStateDisconnected()

uistatemodule.setConnected = ->
    log "uistatemodule.setStateConnected"
    uiCommands.setStateConnected()
#endregion

module.exports = uistatemodule