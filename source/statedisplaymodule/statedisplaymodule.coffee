statedisplaymodule = {name: "statedisplaymodule"}

#region modulesFromTheEnvironment
#endregion

#region DOMElements
feedbackBlock = null
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
    feedbackBlock = document.getElementById("feedback-block")
    return
    
#region internalFunctions
#endregion

#region exposedFunctions
statedisplaymodule.displayFeedback = (feedback) ->
    log "statedisplaymodule.displayFeedback"
    feedbackBlock.innerHTML = feedback
#endregion

module.exports = statedisplaymodule