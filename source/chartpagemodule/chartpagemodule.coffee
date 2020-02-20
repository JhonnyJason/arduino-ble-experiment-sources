chartpagemodule = {name: "chartpagemodule"}
##############################################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["chartpagemodule"]?  then console.log "[chartpagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

chartpage = null
backFromChartButton = null

##############################################################################
chartpagemodule.initialize = () ->
    log "chartpagemodule.initialize"
    chartpage = document.getElementById("chartpage")
    backFromChartButton = document.getElementById("back-from-chart-button")
    backFromChartButton.addEventListener("click", backFromChartButtonClicked)
    return
    
backFromChartButtonClicked = ->
    log "backFromChartButtonClicked"
    chartpagemodule.turnDown()
    return

#region exposedFunctions
chartpagemodule.turnDown = ->
    log "chartpagemodule.turnDown"
    chartpage.classList.remove("active")
    return

chartpagemodule.turnUp = ->
    log "chartpagemodule.turnUp"
    chartpage.classList.add("active")
    return

#endregion

module.exports = chartpagemodule