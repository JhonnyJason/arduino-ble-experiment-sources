uicommandsmodule = {name: "uicommandsmodule"}

#region modulesFromTheEnvironment
ble = null
#endregion

#region internalProperties
#region DOMElements
requireDeviceButton = null
disconnectButton = null
startBenchmarksButton = null
#endregion
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

    requireDeviceButton = document.getElementById("require-device-button")
    disconnectButton = document.getElementById("disconnect-button")
    startBenchmarksButton = document.getElementById("start-benchmarks-button")
    
    requireDeviceButton.addEventListener("click", requireDeviceButtonClicked)
    disconnectButton.addEventListener("click", disconnectButtonClicked)
    startBenchmarksButton.addEventListener("click", startBenchmarksButtonClicked)
    setInitialState()
    return
#region internalFunctions
setInitialState = ->
    log "setInitialState"
    disabled = {}
    # disabled.requireDeviceButton = true
    disabled.disconnectButton = true
    disabled.startBenchmarksButton = true
    setDisabledButtons(disabled)

setDisabledButtons = (disabled) ->
    log "setDisabledButtons"
    if disabled.requireDeviceButton then requireDeviceButton.disabled = true
    else requireDeviceButton.disabled = false
    if disabled.disconnectButton then disconnectButton.disabled = true
    else disconnectButton.disabled = false
    if disabled.startBenchmarksButton then startBenchmarksButton.disabled = true
    else startBenchmarksButton.disabled = false
    return

requireDeviceButtonClicked = ->
    log "requireDeviceButtonClicked"
    log("We should require the device!")
    ble.requireDevice()

disconnectButtonClicked = ->
    log "disconnectButtonClicked"
    log("We should disconnect!")
    
startBenchmarksButtonClicked = ->
    log "startBenchmarksButtonClicked"
    log("We should start the benchmarks!")

#endregion

#region exposedFunctions
#endregion

module.exports = uicommandsmodule