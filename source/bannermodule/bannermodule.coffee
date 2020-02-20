bannermodule = {name: "bannermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["bannermodule"]?  then console.log "[bannermodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion

############################################################
settingsIcon = null
chartIcon = null

############################################################
settingspage = null
chartpage = null

############################################################
bannermodule.initialize = () ->
    log "bannermodule.initialize"
    settingspage = allModules.settingspagemodule
    chartpage = allModules.chartpagemodule
    settingsIcon = document.getElementById("settings-icon")
    chartIcon = document.getElementById("chart-icon")
    settingsIcon.addEventListener("click", settingsIconClicked)
    chartIcon.addEventListener("click", chartIconClicked)
    return

############################################################
settingsIconClicked = ->
    log "settingsIconClicked"
    settingspage.turnUp()
    return    

chartIconClicked = ->
    log "chartIconClicked"
    chartpage.turnUp()
    return

module.exports = bannermodule