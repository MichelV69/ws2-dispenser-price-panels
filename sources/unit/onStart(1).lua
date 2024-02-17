--- unit.onStart(1)
--- # USER DATA

--- --- # screen presentation
--- --- # feel free to change these values to something you prefer
local userFontChoice = "default"  --export Set the screen display font
local userFontSizeChoice = "default" --export Set the screen display font size

--- --- # add an item per set of dispenser screens to maintain.
--- --- # any entry with an id, price or units of 0 is ignored / turned off.
--- --- # any entry with an id of "1793858647" ("Blueprints") requires the "ProductName" field to be filled in.
productDataTable[1].ID = 840202986 -- Kergon-X3 fuel
productDataTable[1].pricePerUnit = 0.00
productDataTable[1].unitsPerSale = 0

productDataTable[2].ID = 2579672037 -- Nitron Fuel
productDataTable[2].pricePerUnit = 0.00
productDataTable[2].unitsPerSale = 0

productDataTable[3].ID = 409040753 -- Chromium Scrap
productDataTable[3].pricePerUnit = 0.00
productDataTable[3].unitsPerSale = 0

productDataTable[4].ID = 1423148560 -- Sulfur Scrap
productDataTable[4].pricePerUnit = 0.00
productDataTable[4].unitsPerSale = 0

productDataTable[5].ID = 1793858647 -- Blueprints
productDataTable[5].ProductName = "RPG-3400 Merchant Prince"
productDataTable[5].pricePerUnit = 0.00
productDataTable[5].unitsPerSale = 0

--- # END of USER DATA Section
--- # Changing anything else anywhere else will break this app
boot(productDataTable, userFontChoice, userFontSizeChoice)
--- eof ---

