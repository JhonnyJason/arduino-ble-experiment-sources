blemodule = {name: "blemodule"}

#region modulesFromTheEnvironment
cfg = null
stateDisplay = null
#endregion

#region internalProperties
deviceOptions = null
activeServer = null
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
    stateDisplay = allModules.statedisplaymodule
    deviceOptions = cfg.deviceOptions
    return
    
#region internalFunctions
# getCurrentBluetoothObject = -> ble = navigator.bluetooth
connectDevice = (device) ->
    log "connectDevice"
    try
        server = await device.gatt.connect()
        message = "" + server
        stateDisplay.displayFeedback(message)
        olog server
        activeServer = server
    catch error
        message = "" + error
        stateDisplay.displayFeedback(message)
        print "Error on connect!"
        print message
#endregion

#region exposedFunctions
blemodule.requireDevice = ->
    log "ble.requireDevice"
    ble = navigator.bluetooth
    try 
        device = await ble.requestDevice(deviceOptions)
        await connectDevice(device)
    catch error
        message = "" + error
        stateDisplay.displayFeedback(message)
        print "Error on requestDevice!"
        print message


blemodule.disconnectDevice = ->
    log "blemodule.disconnectDevice"

#endregion

module.exports = blemodule