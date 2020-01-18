benchmarkmodule = {name: "benchmarkmodule"}

#region modulesFromTheEnvironment
cfg = null
ble = null
#endregion

#region HTMLElements
benchmarkTable = null
#endregion

PURECPUTIME = 0
DATACPUTIME = 1

#region internalProperties
intervalID = 0
currentState = PURECPUTIME

pureCPUWrites = 0

dataWrites = 0
writtenBytes = []

lastTime = 0
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["benchmarkmodule"]?  then console.log "[benchmarkmodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
benchmarkmodule.initialize = () ->
    log "benchmarkmodule.initialize"
    cfg = allModules.configmodule
    ble = allModules.blemodule

    benchmarkTable = document.getElementById("benchmark-table")
    
    lastTime = Date.now()
    startTimeframing()
    doCPUWrites()
    return

#region internalFunctions
pureCPUWrite = -> 
    pureCPUWrites++
    setTimeout(pureCPUWrite, 0)
    return
doCPUWrites = ->
    log "doCPUWrites"
    # array  = new Array(1024).fill(1)
    # array  = new Array(512).fill(1)
    # array  = new Array(256).fill(1)
    # array  = new Array(128).fill(1)
    # array  = new Array(75).fill(1)
    # array  = new Array(64).fill(1)
    # array  = new Array(32).fill(1)
    # array  = new Array(16).fill(1)
    # array  = new Array(8).fill(1)
    # array  = new Array(4).fill(1)
    # array  = new Array(2).fill(1)
    # array  = new Array(1).fill(1)
    # array.forEach(pureCPUWrite)
    return

checkTimeframe = ->
    log "checkTimeframe"
    time = Date.now()
    deltaT = time - lastTime

    log "elapsedTime: " + deltaT
    log "pureCPUWrites: " + pureCPUWrites
    log "dataWrites: " + dataWrites
    log "writtenBytes: " + writtenBytes.length
    log "-"

    if currentState == PURECPUTIME
        rememberPureCPUTime()

    if currentState == DATACPUTIME
        calculatePureCPUTimeRelations()
    
    doStateSwitch()

    dataWrites = 0
    writtenBytes = []
    pureCPUWrites = 0
    lastTime = time


doStateSwitch = ->
    log "doStateSwitch"
    # if currentState == DATACPUTIME
    #     ble.stopData()
    #     currentState = PURECPUTIME
    return

rememberPureCPUTime = ->
    log "rememberPureCPUTime"

calculatePureCPUTimeRelations = ->
    log "calculatePureCPUTimeRelations"


handleData = (event) ->
    value = event.target.value;
    i = 0
    dataWrites++
    while (i < value.byteLength)
        writtenBytes.push(value.getUint8(i))
        i++
    return


startTimeframing = ->
    log "startTimeframing"
    intervalID = setInterval(checkTimeframe, cfg.timeframeSizeMS);
    return

stopTimeframing = ->
    log "startTimeframing"
    return unless intervalID
    clearInterval(intervalID)
    return
#endregion

#region exposedFunctions
benchmarkmodule.start = ->
    log "benchmarkmodule.start"
    await ble.startData()
    ble.onData(handleData)
    currentState = DATACPUTIME
    return

#endregion

module.exports = benchmarkmodule