--- unit.onStart(1)
--- # USER DATA

--- --- # screen presentation
--- --- # feel free to change these values to something you prefer
local userFontChoice = "default"     --export Set the screen display font
local userFontSizeChoice = "default" --export Set the screen display font size
local userOrgLogoURL = "default"

--- --- # add an item per set of dispenser screens to maintain.
--- --- # any entry with an id, price or units of 0 is ignored / turned off.
--- --- # any entry with an id of "1793858647" ("Blueprints") requires the "ProductName" field to be filled in.
productDataTable[1].ID = 840202986 -- Kergon-X3 fuel
productDataTable[1].pricePerUnit = 23.95
productDataTable[1].unitsPerSale = 3200

productDataTable[2].ID = 2579672037 -- Nitron Fuel
productDataTable[2].pricePerUnit = 6.52
productDataTable[2].unitsPerSale = 3200

productDataTable[3].ID = 409040753 -- Chromium Scrap
productDataTable[3].pricePerUnit = 258.00
productDataTable[3].unitsPerSale = 100

productDataTable[4].ID = 1423148560 -- Sulfur Scrap
productDataTable[4].pricePerUnit = 230.32
productDataTable[4].unitsPerSale = 100

productDataTable[5].ID = 3823417343.01 -- Core Blueprint
productDataTable[5].ProductName = "E19-99-C Hybrid Atmo Space (HAS)"
productDataTable[5].pricePerUnit = 330000.00
productDataTable[5].unitsPerSale = 1
productDataTable[5].altArtworkURL = ""
--
productDataTable[6].ID = 3823417343.02 -- Core Blueprint
productDataTable[6].ProductName = "E19-99-C Orbital Transfer Vehicle (OTV)"
productDataTable[6].pricePerUnit = 330000.00
productDataTable[6].unitsPerSale = 1
productDataTable[6].altArtworkURL = ""
--
productDataTable[7].ID = 3823417343.03 -- Core Blueprint
productDataTable[7].ProductName = "RPG-3400 Merchant Prince"
productDataTable[7].pricePerUnit = 330000.00
productDataTable[7].unitsPerSale = 1
productDataTable[7].altArtworkURL = "assets.prod.novaquark.com/145024/7f0acf62-e650-4136-997d-84cada7efe0a.png"

--- # END of USER DATA Section
--- # Changing anything else anywhere else will break this app
boot(productDataTable, userFontChoice, userFontSizeChoice, userOrgLogoURL)
--- eof ---
