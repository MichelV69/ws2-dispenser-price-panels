-- library.onStart(3)
-- define screen layout for use elsewhere
---
FontName = "RefrigeratorDeluxe"
FontSize = 24
orgLogoURL = "assets.prod.novaquark.com/145024/8ab0175a-333a-4980-970f-accc4940f234.jpg"

function RenderScreen(thisScreen, screenPosition, productDataRecord, itemDataTable)
    local ScreenTable                        = {}
    productDataRecord.locDisplayNameWithSize = AbbreviateName(productDataRecord.ProductName)

    local formattedSalePrice                 = tostring(productDataRecord.pricePerUnit * productDataRecord.unitsPerSale)
        :format("%,04d")

    if productDataRecord.altArtworkURL == nil then
        productDataRecord.altArtworkURL = "--"
    end

    -- R  G  B
    local greenText        = '0.5, 1.0, 0.5'
    local blueText         = '0.5, 0.5, 1.0'
    local orangeText       = '1.0, 0.5, 0.5'
    local simpleBlack      = '0.2, 0.2, 0.2'

    --Parameters (1)
    ScreenTable[1]         = [[
        local FontName="]] .. FontName .. [["
        local FontSize=]] .. FontSize .. [[
        local S_Title="]] .. WS2_Software.title .. [["
        local S_Version="]] .. WS2_Software.version .. [["
        local S_Revision="]] .. WS2_Software.revision .. [["
        local timeStamp="]] .. EpochTime() .. [["
        local notDeadYet="]] .. screenPulseTick() .. [["
        ]]

    -- general layout(2)
    ScreenTable[2]         = [[
        --Layers
        local layers={}
        layers["background"]  = createLayer()
        layers["shading"]     = createLayer()
        layers["images"]      = createLayer()
        layers["footer_text"] = createLayer()
        layers["header_text"] = createLayer()
        layers["report_text"] = createLayer()

        setBackgroundColor(15/255, 24/255, 29/255)

        --util functions
        function tidy(valueToRound)
            precisionDigits = 2
            precisionValue  = 10^precisionDigits
            if valueToRound == nil then return 0 end
            local roundedValue = (math.floor(valueToRound * precisionValue) / precisionValue)
            return roundedValue
            end --- function tidy

        ---
        function getRowColsPosition(layout, col, row)
            if col > layout.cols_wide then col = layout.cols_wide end
            x_pos = (layout.col_width * col) + layout.margin_left
            if row > layout.rows_high then row = layout.rows_high end
            y_pos = (layout.row_height * row) + layout.margin_top
            return {x_pos = x_pos, y_pos = y_pos}
            end --- function getRowColsPosition

        ---
        function drawBorder(layers, layout)
            -- draw two boxes, one inside the other
            rounding_px = 18
            setDefaultFillColor(layers["shading"], Shape_BoxRounded, 0, 1, 0, 1)

            topLeftCorner_X = layout.col_width
            topLeftCorner_Y = layout.row_height
            boxWidth_px   = (layout.cols_wide - 2) * layout.col_width
            boxHeight_px  = (layout.rows_high - 2) * layout.row_height

            addBoxRounded(layers["shading"],
                topLeftCorner_X, topLeftCorner_Y,
                boxWidth_px, boxHeight_px,
                rounding_px)

            -- smaller "write inside"
            setDefaultFillColor(layers["shading"], Shape_BoxRounded, 0.2, 0.2, 0.2, 1)

            topLeftCorner_X = layout.col_width * 2
            topLeftCorner_Y = layout.row_height * 2
            boxWidth_px   = (layout.cols_wide - 4) * layout.col_width
            boxHeight_px  = (layout.rows_high - 4) * layout.row_height

            addBoxRounded(layers["shading"],
                topLeftCorner_X, topLeftCorner_Y,
                boxWidth_px, boxHeight_px,
                rounding_px)

            end  --- function drawStatusBorder

        --Scr Resolution
        local rx, ry= getResolution()
        local layout = {}
        layout.cols_wide = tidy(rx/(FontSize*1.2))
        layout.col_width = tidy(rx/layout.cols_wide)

        layout.rows_high = tidy(ry/(FontSize*1.2))
        layout.row_height = tidy(ry/layout.rows_high)

        layout.margin_top = tidy((ry * 0.1) / 2)
        layout.margin_bottom = layout.margin_top
        layout.margin_left = tidy((rx * 0.1) / 2)
        layout.margin_right = layout.margin_left

        layout.square_size = 128

        --Font Setups
        local offsetStepPX = 24
        local fontSizeStep = 0.33
        local FontText=loadFont(FontName , FontSize)
        local FontTextSmaller=loadFont(FontName , FontSize * (1 - fontSizeStep))
        local FontTextBigger=loadFont(FontName , FontSize * (1 + fontSizeStep))
        local FontTextMax=loadFont(FontName , FontSize * (3 + fontSizeStep))

        local shadowPX = 4
        setDefaultShadow(layers["header_text"], Shape_Text, shadowPX/2, ]] .. blueText .. [[, 1)
        setDefaultShadow(layers["report_text"], Shape_Text, shadowPX, ]] .. blueText .. [[, 1)
        setDefaultShadow(layers["footer_text"], Shape_Text, shadowPX/2, ]] .. greenText .. [[, 1)
        setDefaultShadow(layers["images"], Shape_Image, shadowPX*2, ]] .. simpleBlack .. [[, 1)
        local displayedLogo = loadImage("]] .. orgLogoURL .. [[")

    ]]
    --get data to publish (3 & 4)
    ScreenTable[3]         = [[
         local this_screenPosition = ']] .. screenPosition .. [['
         local this_product_ID = ']] .. productDataRecord.ID .. [['
         local this_product_Name = ']] .. productDataRecord.ProductName .. [['
         local this_product_pricePerUnit = ']] .. productDataRecord.pricePerUnit .. [['
         local this_product_unitsPerSale = ']] .. productDataRecord.unitsPerSale .. [['
         local this_product_altArtworkURL = ']] .. productDataRecord.altArtworkURL .. [['
         local this_item_locDisplayNameWithSize = ']] .. itemDataTable.locDisplayNameWithSize .. [['
         local this_item_iconPath = ']] .. itemDataTable.iconPath .. [['
         local this_item_tier = ']] .. itemDataTable.tier .. [['
     ]]

    -- header and footer (4)
    ScreenTable[4]         = [[
      local vpos = 1
      publish_to = getRowColsPosition(layout, 1, vpos)
      textMessage = S_Title .. " v" .. S_Version .. " (" .. S_Revision .. ")"
      addText(layers["header_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)

      col = tidy(layout.cols_wide/3) - 1.5
      row = layout.rows_high - 3

      publish_to = getRowColsPosition(layout, col, row)
      textMessage = "screen last updated: [" .. timeStamp .. "]"
      addText(layers["footer_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)
    ]]

    --- format data for display (5)
    local isABluePrint_txt = "local lcl_isABluePrint = 0"
    if isABluePrint(productDataRecord.ID) then
        isABluePrint_txt = "local lcl_isABluePrint = 1"
    end
    ScreenTable[5] = isABluePrint_txt .. [[
            ---
            local productIcon = loadImage(this_item_iconPath)
            local displayedImage = displayedLogo
            local imageLeft = layout.margin_left
            local imageTop  = layout.margin_top
            if this_screenPosition:lower() == "top" then
                displayedImage = productIcon
                imageLeft = imageLeft + 2
                imageTop  = imageTop  + 6
            end
            local imageWide = imageLeft + layout.square_size
            local imageTall = imageTop  + layout.square_size
            addImage(layers["images"], displayedImage, imageLeft, imageTop, imageWide , imageTall )

            ---
            eightCols = tidy(layout.cols_wide/8)
            row = layout.rows_high /3
            local fontToDisplay = FontTextBigger

            publish_to = getRowColsPosition(layout, eightCols, row)
            textMessage = "T" .. this_item_tier .. " " .. this_product_Name .. "@" .. this_product_pricePerUnit .. "Q/L."
            if this_screenPosition:lower() == "top" then
                fontToDisplay = FontTextMax
                textMessage = this_product_unitsPerSale .. "L " .. this_item_locDisplayNameWithSize
                if lcl_isABluePrint == 1 then
                    publish_to = getRowColsPosition(layout, eightCols - 2, row)
                    textMessage = this_product_unitsPerSale .. " " .. this_product_Name .. " BP."
                end
            end
            addText(layers["report_text"], fontToDisplay, textMessage, publish_to.x_pos, publish_to.y_pos)

            ---
            horiz_offset = 1
            vert_offset = 2
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
            textMessage = "Terminal is ready for transaction. Click on Dispenser to begin."
            if this_screenPosition:lower() == "top" then
                textMessage = " for " .. ]] .. formattedSalePrice .. [[ .. "Q per batch."
                if lcl_isABluePrint == 1 then
                    textMessage = textMessage .. " (some assembly required)"
                end
            end
            addText(layers["report_text"], FontTextBigger, textMessage, publish_to.x_pos, publish_to.y_pos)

            ---
            horiz_offset = 2
            vert_offset = 3
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
            textMessage = " "

            if this_screenPosition:lower() == "top"
                and lcl_isABluePrint == 1 then
                    displayedImage = loadImage(this_product_altArtworkURL)
                    local imageLeft = layout.margin_left + 256
                    local imageTop  = layout.margin_top  + 128
                    local imageWide = imageLeft + layout.square_size * 2
                    local imageTall = imageTop  + layout.square_size * 2
                    addImage(layers["images"], displayedImage, imageLeft, imageTop, imageWide , imageTall )
            end
            addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

            ---
            horiz_offset = 2
            vert_offset = 4
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
            textMessage = "REMINDER: Do Not Make Purchases in VR without pre-arranged LOCAL storage!"
            if this_screenPosition:lower() == "top" then
                textMessage = " "
            end
            addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)
            ]]

    --- tick-timer, etc (6)
    ScreenTable[6] = [[
      col = tidy(layout.cols_wide/3)
      row = layout.rows_high - 4
      publish_to = getRowColsPosition(layout, col, row)
      textMessage = notDeadYet
      addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

      drawBorder(layers, layout)
      ]]

    --Animation (7)
    ScreenTable[7] = [[
        requestAnimationFrame(5)
        ]]

    --RENDER
    function ScreenRender(thisScreen)
        local screenTemplate = table.concat(ScreenTable)
        thisScreen.setRenderScript(screenTemplate)
    end -- function ScreenRender

    ScreenRender(thisScreen)
end -- function renderScreen

---
--- eof ---
