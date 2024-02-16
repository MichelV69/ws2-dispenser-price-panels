--- ###   system.onStart(1).lua   ### ---
function boot( lcl_productData )

WS2_Software = {}
WS2_Software.id = "dispenser_price_board"
WS2_Software.title = "Dispenser Price Board"
WS2_Software.version = "0.0.11"
WS2_Software.revision = "16 Feb 2024 09h21 AST"
WS2_Software.author = "Michel Vaillancourt <902pe_gaming@wolfstar.ca>"

system.print("\n --------------- \n")
local msgTitleAndVersion = WS2_Software.title .. "\n" .. WS2_Software.version
system.print(msgTitleAndVersion)

---
local lclFontName = "Montserrat-Light"        --export
FontName          = [["]] .. lclFontName .. [["]]
FontSize          = 32                        --export

---
Slotlist          = { slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10 }
ScreenList        = {}
DatabankList      = {}

--- sanity / configuration check
for i = 1, #Slotlist, 1 do
    local thisSlot = Slotlist[i]

    console(WS2_Software.id .. ": found [" .. thisSlot.getClass() .. "] in Slot [" .. i .. "].")

    if thisSlot.getClass() == "ScreenUnit" then
        table.insert(ScreenList, thisSlot)
    end
    if thisSlot.getClass() == "DatabankUnit" then
        table.insert(DatabankList, thisSlot)
    end
end

if #ScreenList == 0 then
    error "No Screen connected.  Cannot continue."
else
    console(WS2_Software.id .. ": found [" .. #ScreenList .. "] connected Screens.")
end

-- if #DatabankList == 0 then
--    error "No databank connected.  Cannot continue."
-- else
--     console(WS2_Software.id .. ": found [" .. #DatabankList .. "] connected Databanks.")
-- end

for i = 1, #ScreenList, 1 do
    ScreenList[i].activate()
    ScreenList[i].setCenteredText(msgTitleAndVersion .. "\n\n BOOTING")
end

UpdateScreens(ScreenList, lcl_productData)
unit.setTimer("500ms", 0.5)
end

--- ### EOF system.onStart(1).lua ### ---
