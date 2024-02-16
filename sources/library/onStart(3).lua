-- library.onStart(3)
-- define screen layout for use elsewhere
---
function RenderScreen(thisScreen, screenPosition, productDataRecord, itemDataTable)
    local ScreenTable                        = {}
    productDataRecord.locDisplayNameWithSize = AbbreviateName(productDataRecord.locDisplayNameWithSize)

    -- R  G  B
    local greenText                          = '0.5, 1.0, 0.5'
    local blueText                           = '0.5, 0.5, 1.0'
    local orangeText                         = '1.0, 0.5, 0.5'
    local simpleBlack                        = '0.2, 0.2, 0.2'

    --Parameters (1)
    ScreenTable[1]                           = [[
        local FontName=]] .. FontName .. [[
        local FontSize=]] .. FontSize .. [[
        local S_Title="]] .. WS2_Software.title .. [["
        local S_Version="]] .. WS2_Software.version .. [["
        local S_Revision="]] .. WS2_Software.revision .. [["
        local timeStamp="]] .. EpochTime() .. [["
        local notDeadYet="]] .. screenPulseTick() .. [["
        ]]

    -- general layout(2)
    ScreenTable[2]                           = [[
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

        local shadowPX = 4
        setDefaultShadow(layers["header_text"], Shape_Text, shadowPX/2, ]] .. blueText .. [[, 1)
        setDefaultShadow(layers["report_text"], Shape_Text, shadowPX, ]] .. blueText .. [[, 1)
        setDefaultShadow(layers["footer_text"], Shape_Text, shadowPX/2, ]] .. greenText .. [[, 1)
        setDefaultShadow(layers["images"], Shape_Image, shadowPX*2, ]] .. simpleBlack .. [[, 1)
    ]]
    --get data to publish (3 & 4)
    ScreenTable[3]                           = [[
         local this_screenPosition = ']] .. screenPosition .. [['
         local this_productDataRecord = ']] .. productDataRecord .. [['
         local this_itemDataTable = ']] .. itemDataTable .. [[)
     ]]

    -- header and footer (4)
    ScreenTable[4]                           = [[
      local vpos = 1
      publish_to = getRowColsPosition(layout, 1, vpos)
      textMessage = S_Title .. " v" .. S_Version .. " (" .. S_Revision .. ")"
      addText(layers["header_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)

      col = tidy(layout.cols_wide/3) - 1.5
      row = layout.rows_high - 3

      publish_to = getRowColsPosition(layout, col, row)
      textMessage = "screen last updated: ["..timeStamp.."]"
      addText(layers["footer_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)
    ]]

    --- format data for display (5)
    ScreenTable[5]                           = [[

            local productIcon = loadImage(this_productDataRecord.iconPath)
            addImage(layers["images"], productIcon, layout.margin_left, layout.margin_top, layout.margin_left + layout.square_size , layout.margin_top + layout.square_size )

            eightCols = tidy(layout.cols_wide/8)
            row = layout.rows_high /3

            publish_to = getRowColsPosition(layout, eightCols, row)
            textMessage = "blank1"
            addText(layers["report_text"], FontTextBigger, textMessage, publish_to.x_pos, publish_to.y_pos)

            horiz_offset = 1
            vert_offset = 2
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)

            textMessage = "blank2"
            addText(layers["report_text"], FontTextBigger, textMessage, publish_to.x_pos, publish_to.y_pos)

            horiz_offset = 2
            vert_offset = 3
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
            textMessage = this_productDataRecord.locDisplayNameWithSize
            addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

            horiz_offset = 2
            vert_offset = 4
            publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
            textMessage = "blank3"
            addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)
            ]]

    --- tick-timer, etc (6)
    ScreenTable[6]                           = [[
      col = tidy(layout.cols_wide/3)
      row = layout.rows_high - 4
      publish_to = getRowColsPosition(layout, col, row)
      textMessage = notDeadYet
      addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

      drawBorder(layers, layout)
      ]]

    --Animation (7)
    ScreenTable[7]                           = [[
        requestAnimationFrame(5)
        ]]

    --RENDER
    function ScreenRender(thisScreen)
        thisScreen.clear()
        local screenTemplate = table.concat(ScreenTable)
        thisScreen.setRenderScript(screenTemplate)
    end -- function ScreenRender

    ScreenRender(thisScreen)
end -- function renderScreen

---
--- eof ---
