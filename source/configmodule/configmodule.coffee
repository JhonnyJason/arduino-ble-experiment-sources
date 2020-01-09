configmodule = {name: "configmodule", uimodule: false}

#region logPrintFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["configmodule"]?  then console.log "[configmodule]: " + arg
    return
#endregion
########################################################
configmodule.initialize = () ->
    log "configmodule.initialize"
    return    

#region exposedProperties
configmodule.deviceName = 'Ardidino1234#'
#endregion

export default configmodule
