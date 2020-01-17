uistatemodule = {name: "uistatemodule"}

#region modulesFromTheEnvironment
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
    return
    
#region internalFunctions
#endregion

#region exposedFunctions
#endregion

module.exports = uistatemodule