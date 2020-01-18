debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    benchmarkmodule: true
    blemodule: true
    # configmodule: true
    uicommandsmodule: true

export default debugmodule
