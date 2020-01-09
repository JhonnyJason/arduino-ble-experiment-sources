uicommandsmodule = {name: "uicommandsmodule"}

#region modulesFromTheEnvironment
#endregion

#region internalProperties
ble = null
scanButton = null
#endregion


#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["uicommandsmodule"]?  then console.log "[uicommandsmodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
uicommandsmodule.initialize = () ->
    log "uicommandsmodule.initialize"
    ble = allModules.blemodule
    log ble
    scanButton = document.getElementById("scan-button")
    
    scanButton.addEventListener("click", scanButtonClicked)
    return
#region internalFunctions
scanButtonClicked = ->
    log "scanButtonClicked"
    log ble
    ble.scan()

#endregion

#region exposedFunctions
#endregion

module.exports = uicommandsmodule