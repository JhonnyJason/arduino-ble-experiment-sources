statedisplaymodule = {name: "statedisplaymodule"}

#region modulesFromTheEnvironment
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["statedisplaymodule"]?  then console.log "[statedisplaymodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
statedisplaymodule.initialize = () ->
    log "statedisplaymodule.initialize"
    return
    
#region internalFunctions
#endregion

#region exposedFunctions
#endregion

module.exports = statedisplaymodule