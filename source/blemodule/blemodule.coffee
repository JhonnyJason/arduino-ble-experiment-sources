blemodule = {name: "blemodule"}

#region modulesFromTheEnvironment
cfg = null
stateDisplay = null
uiState = null
#endregion

#region internalProperties
connectedDevice = null
connectedServer = null
dataCharacteristic = null
isConnected = false
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["blemodule"]?  then console.log "[blemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log(ostr(obj))
print = (arg) -> console.log(arg)
#endregion
##############################################################################
blemodule.initialize = () ->
    log "blemodule.initialize"
    cfg = allModules.configmodule
    uiState = allModules.uistatemodule
    stateDisplay = allModules.statedisplaymodule
    return
    
#region internalFunctions
saveDataCharacteristic = ->
    log "saveDataCharacteristic"
    service = await connectedServer.getPrimaryService(cfg.dataService)
    dataCharacteristic = await service.getCharacteristic(cfg.dataCharacteristic)

connectDevice = (device) ->
    log "connectDevice"
    device.addEventListener("gattserverdisconnected", deviceDisconnected)
    server = await device.gatt.connect()

    #region checkSomeDeviceInfo
    log "device name: " + device.name
    log "device id: " + device.id
    log "device.gatt.connected: " + device.gatt.connected
    #endregion

    stateDisplay.displayFeedback("connected")    
    connectedDevice = device
    connectedServer = server
    isConnected = true
    return

deviceDisconnected = (arg) ->
    log "deviceDisconnected"
    log arg
    uiState.setDisconnected()
#endregion

#region exposedFunctions
blemodule.requireDevice = ->
    log "ble.requireDevice"
    ble = navigator.bluetooth
    try 
        device = await ble.requestDevice(cfg.deviceOptions)
        await connectDevice(device)
        await saveDataCharacteristic()
        uiState.setConnected()
    catch error
        message = "" + error
        stateDisplay.displayFeedback(message)
        print "Error on requestDevice!"
        print message

blemodule.disconnect = ->
    log "blemodule.disconnect"
    return unless isConnected and connectDevice
    await connectedDevice.gatt.disconnect()
    log "succeessfully disconnected"
    uiState.setDisconnected()

blemodule.stopData = ->
    log "blemodule.stopData"
    await dataCharacteristic.stopNotifications()
    return

blemodule.startData = ->
    log "blemodule.stopData"
    await dataCharacteristic.startNotifications()
    return

blemodule.onData = (fun) ->
    log "blemodule.onData"
    dataCharacteristic.addEventListener('characteristicvaluechanged', fun)
    return
#endregion

module.exports = blemodule