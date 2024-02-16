-- library.onStart(1)
-- define support functions and globals for use elsewhere
productData          = {}
productData[1]       = {}
productData[2]       = {}
productData[3]       = {}
productData[4]       = {}
productData[5]       = {}

PrecisionDigits      = 2
PrecisionValue       = 10 ^ PrecisionDigits
GramsToKG            = 1000
Minutes              = {}
Minutes[1]           = 60
Minutes[2]           = Minutes[1] * 2
Minutes[5]           = Minutes[1] * 5

ScreenPulseTable     = {}
ScreenPulseTable[1]  = "[-=+     ]"
ScreenPulseTable[2]  = "[ -=+    ]"
ScreenPulseTable[3]  = "[  -=+   ]"
ScreenPulseTable[4]  = "[   -=+  ]"
ScreenPulseTable[5]  = "[    -=+ ]"
ScreenPulseTable[6]  = "[     -=+]"
ScreenPulseTable[7]  = "[     -+=]"
ScreenPulseTable[8]  = "[     +=-]"
ScreenPulseTable[9]  = "[    +=- ]"
ScreenPulseTable[10] = "[   +=-  ]"
ScreenPulseTable[11] = "[  +=-   ]"
ScreenPulseTable[12] = "[ +=-    ]"
ScreenPulseTable[13] = "[+=-     ]"
ScreenPulseTable[14] = "[=+-     ]"
ScreenPulseTable[15] = "[=-+     ]"
AnimationPulseIndex  = 1

---
function roundUpToPrecision(valueToRound)
    if valueToRound == nil then return 0 end
    local roundedValue = (math.ceil(valueToRound * PrecisionValue) / PrecisionValue)
    return roundedValue
end

---
function roundDownToPrecision(valueToRound)
    if valueToRound == nil then return 0 end
    local roundedValue = (math.floor(valueToRound * PrecisionValue) / PrecisionValue)
    return roundedValue
end

---
function screenPulseTick()
    AnimationPulseIndex = AnimationPulseIndex + 1
    if AnimationPulseIndex > #ScreenPulseTable then AnimationPulseIndex = 1 end
    return ScreenPulseTable[AnimationPulseIndex]
end

---
function string:split(inSplitPattern, outResults)
    if not outResults then
        outResults = {}
    end
    local theStart = 1
    local theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
    while theSplitStart do
        table.insert(outResults, string.sub(self, theStart, theSplitStart - 1))
        theStart = theSplitEnd + 1
        theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
    end
    table.insert(outResults, string.sub(self, theStart))
    return outResults
end

---
function console(messageTxt)
    system.print(messageTxt)
end

--- eof ---
