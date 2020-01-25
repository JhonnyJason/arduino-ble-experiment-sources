uistatemodule = {name: "uistatemodule"}

#region modulesFromTheEnvironment
uiCommands = null
stateDisplay = null
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
    stateDisplay = allModules.statedisplaymodule
    return
    
#region internalFunctions
#endregion

#region exposedFunctions
uistatemodule.setDisconnected = ->
    log "uistatemodule.setStateDisconnected"
    uiCommands.setStateDisconnected()
    stateDisplay.displayFeedback("not-connected")

uistatemodule.setConnected = ->
    log "uistatemodule.setStateConnected"
    uiCommands.setStateConnected()
    stateDisplay.displayFeedback("connected")

uistatemodule.setBenchmarking = ->
    log "uistatemodule.setStateConnected"
    uiCommands.setStateBenchmarking()
    stateDisplay.displayFeedback("benchmarking...")
#endregion

module.exports = uistatemodule