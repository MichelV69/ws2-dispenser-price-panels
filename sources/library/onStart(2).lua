-- library.onStart(2)
-- define key functions for use elsewhere
---

function UpdateScreens(screenListTable, productDataTable)
    for i = 1, #screenListTable do
        --Table take apart the screen's device name to get the position and product ID
        local screenPosition = top
        local productID = -1
        local screenDataTable = {}
        local thisScreen = screenListTable[i]

        -- now that we have the productID, check it against the productData set for a match
        screenDataTable = splitStringBy(".", thisScreen.getName())
        console("thisScreen.getName(): [" .. thisScreen.getName() .. "]")
        local sdt_name = 1
        local sdt_itemID = 2
        screenPosition = screenDataTable[sdt_name]
        productID = screenDataTable[sdt_itemID]

        -- productData[5].ID = 1793858647 -- Blueprints
        -- productData[5].ProductName = "RPG-3400 Merchant Prince"
        -- productData[5].pricePerUnit = 0.00
        -- productData[5].unitsPerSale = 0
        local foundMatch = false
        local productDataRecord = {}
        if #screenPosition and
            #productID then
            console("might have foundMatch")
            for i = 1, #productDataTable do
                console(">>" .. productDataTable[i].ID .. "|" .. productID .. "<<")
                if tonumber(productDataTable[i].ID) == tonumber(productID) then
                    console("DID foundMatch")
                    productDataRecord = productDataTable[i]
                    foundMatch = true
                    i = #productDataTable + 2
                end
            end
        end

        local batchPrice = -1
        if foundMatch then
            local itemDataTable = system.getItem(productID)
            batchPrice = productDataRecord.pricePerUnit * productDataRecord.unitsPerSale
            if batchPrice >= 0 then
                RenderScreen(thisScreen, screenPosition, productDataRecord, itemDataTable)
            end
        end
    end
end --- function UpdateScreens

---
function AbbreviateName(long_name_string)
    if long_name_string == nil then long_name_string = " " end
    return long_name_string:gsub('Uncommon', 'UNC'):gsub('Advanced', 'ADV')
end --- function AbbreviateName

--- eof ---

