-- library.onStart(2)
-- define key functions for use elsewhere
---


---
function UpdateScreens(lcl_ScreenList, lcl_productData)
    for i = 1, #lcl_ScreenList, 1 do

        -- take apart the screen's device name to get the position and product ID
        local screenPosition = top
        local productID = -1
        local foundMatch = {}
        local screenName = lcl_ScreenList[i].getName() 

        -- now that we have the productID, check it against the productData set for a match
        local foundMatch = screenName:split(".")

        if #foundMatch then
        -- IF we get a match, API-pull the product data to pass to the screen Renders

        -- IF we get a match, do some useful calculations before screen render

        -- IF we get a match, RenderScreen(top)

        -- IF we get a match, RenderScreen(bottom)

        end



       -- RenderScreen(
       --     lcl_ScreenList[i],
       --     lcl_productData[i].somedata,
       --     lcl_productData[i].somedatatoo,
       --     lcl_productData[i].otherComments,
       --     lcl_productData[i].status_code,
       --     lcl_productData[i].product_iconPath
       -- )
    end
end --- function

---
function AbbreviateName(long_name_string)
    return long_name_string:gsub('Uncommon', 'UNC'):gsub('Advanced', 'ADV')
end

--- eof ---
