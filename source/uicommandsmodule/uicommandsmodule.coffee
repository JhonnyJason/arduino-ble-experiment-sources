uicommandsmodule = {name: "uicommandsmodule"}

#region modulesFromTheEnvironment
ble = null
benchmarks = null
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
    benchmarks = allModules.benchmarkmodule
    
    requireDeviceButton = document.getElementById("require-device-button")
    disconnectButton = document.getElementById("disconnect-button")
    startBenchmarksButton = document.getElementById("start-benchmarks-button")
    
    requireDeviceButton.addEventListener("click", requireDeviceButtonClicked)
    disconnectButton.addEventListener("click", disconnectButtonClicked)
    startBenchmarksButton.addEventListener("click", startBenchmarksButtonClicked)
    setInitialState()
    return

isBenchmarking = false

#region internalFunctions
setInitialState = ->
    log "setInitialState"
    startBenchmarksButton.textContent = "Start Benchmarks"
    isBenchmarking = false
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
    ble.requireDevice()

disconnectButtonClicked = ->
    log "disconnectButtonClicked"
    ble.disconnect()
    
startBenchmarksButtonClicked = ->
    log "startBenchmarksButtonClicked"
    if isBenchmarking then benchmarks.stop()
    else benchmarks.start()
    return
    
#endregion

#region exposedFunctions
uicommandsmodule.setStateBenchmarking = ->
    log "uicommandsmodule.setStateBenchmarking"
    startBenchmarksButton.textContent = "Stop Benchmarks"
    isBenchmarking = true

uicommandsmodule.setStateConnected = ->
    log "uicommandsmodule.setStateConnected"
    startBenchmarksButton.textContent = "Start Benchmarks"
    isBenchmarking = false
    disabled = {}
    setDisabledButtons(disabled)

uicommandsmodule.setStateDisconnected = ->
    log "uicommandsmodule.setStateDisconnected"
    setInitialState()

#endregion

module.exports = uicommandsmodule