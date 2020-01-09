blemodule = {name: "blemodule"}

#region modulesFromTheEnvironment
#endregion

#region internalProperties
ble = null
cfg = null
#endregion


#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["blemodule"]?  then console.log "[blemodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
blemodule.initialize = () ->
    log "blemodule.initialize"
    cfg = allModules.configmodule
    return
    
#region internalFunctions
getCurrentBluetoothObject = -> ble = navigator.bluetooth
#endregion

#region exposedFunctions
blemodule.scan = ->
    getCurrentBluetoothObject()
    options = {}
    options.acceptAllAdvertisements = true
    try
        scan = await ble.requestLEScan(options)
        log JSON.stringify(scan, null, 4)
    catch error then log('Argh! ' + error)

blemodule.start = ->
    log "blemodule.start"


#endregion

module.exports = blemodule