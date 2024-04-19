-- library.onStart(1)
-- define support functions and globals for use elsewhere

productDataTable     = {}
productDataTable[1]  = {}
productDataTable[2]  = {}
productDataTable[3]  = {}
productDataTable[4]  = {}
productDataTable[5]  = {}
productDataTable[6]  = {}
productDataTable[7]  = {}
productDataTable[8]  = {}
productDataTable[9]  = {}

PrecisionDigits      = 2
PrecisionValue       = 10 ^ PrecisionDigits
GramsToKG            = 1000
Seconds              = 1
Minutes              = {}
Minutes[1]           = 60 * Seconds
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
function splitStringBy(demark, inString)
    local fields = {}
    for field in inString:gmatch('([^' .. demark .. ']+)') do
        fields[#fields + 1] = field
    end
    return fields
end

---
function console(messageTxt)
    system.print(WS2_Software.id .. "::" .. messageTxt)
end

function AbbreviateName(long_name_string)
    if long_name_string == nil then long_name_string = " " end
    return long_name_string:gsub('Uncommon', 'UNC'):gsub('Advanced', 'ADV')
end --- function AbbreviateName
--- eof ---

