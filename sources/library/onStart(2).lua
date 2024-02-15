-- library.onStart(2)
-- define key functions for use elsewhere
---


---
function UpdateScreens(lcl_ScreenList, other)
    for i = 1, #lcl_ScreenList, 1 do
        RenderScreen(
            lcl_ScreenList[i],
            other[i].somedata,
            other[i].somedatatoo,
            other[i].otherComments,
            other[i].status_code,
            other[i].product_iconPath
        )
    end
end --- function

---
function AbbreviateName(long_name_string)
    return long_name_string:gsub('Uncommon', 'UNC'):gsub('Advanced', 'ADV')
end

--- eof ---
