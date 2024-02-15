-- library.onStart(2)
-- define key functions for use elsewhere
---

function UpdateScreens(screenListTable, productDataTable)
    for i = 1, #screenListTable do
        --Table take apart the screen's device name to get the position and product ID
        local screenPosition = top
        local productID = -1
        local foundMatch = {}
        local screenName = screenListTable[i]

        -- now that we have the productID, check it against the productData set for a match
        local foundMatch = screenName:split(".")

         >> FIX ... skipped a step!

        if #foundMatch then
            screenPosition = foundMatch[1]
            productID = foundMatch[2]
            local itemDataTable = System.getItem(productID)
            local batchPrice = pricePerUnit * unitsPerSale
            if batchPrice => 0 then
                RenderScreen(screenPosition, productDataTable, itemDataTable, batchPrice)
            end
        end
    end
end --- function UpdateScreens

---
function AbbreviateName(long_name_string)
    return long_name_string:gsub('Uncommon', 'UNC'):gsub('Advanced', 'ADV')
end --- function AbbreviateName

--- eof ---

