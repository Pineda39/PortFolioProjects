## Ecological Data Visualization Project
This is the first of four HP project. This project is based on analyzing the ecological data that involves data about temperature changes, energy used and land coverage and fires all over the globe. In this project, I create advanced visualizations of the data in Python, such as Bubble charts, interactive maps, sophisticated line charts and evolution of maps along the time.

## The Data

Source: https://www.fao.org/faostat/en/#data

* `temperature_change_data_11-29-2021.csv` - the change in temperature through time

	* Source: https://www.fao.org/faostat/en/#data/ET
	* Domain: Temperature Change
	* Area Code (ISO3)
	* Area: the country name (all countries available were selected)
	* Element: Temperature Change
	* Months: "Dec–Jan–Feb", "Mar–Apr–May", "Jun–Jul–Aug", "Sep–Oct–Nov", "Meteorological year"
	* Year: 1961 to 2020
	* Unit: °C
	* Value: the change in temperature
	* Flag Description: "Calculated Data" and "Data Not Available"

* `waste_disposal_data_11-29-2021.csv` - CO2 emissions tracking from incinerating (burning) waste disposal

	* Source: https://www.fao.org/faostat/en/#data/GW
	* Domain: Waste Disposal
	* Area Code (ISO3)
	* Area: the country name (all countries available were selected)
	* Element: Emissions (CO2)
	* Item: Incineration
	* Year: 1990 to 2019
	* Unit: kilotonnes
	* Value: CO2 emissions - absolute number
	* Flag Description: "Calculated Data" and "Aggregate, may include official, semi-official, estimated or calculated data"

* `energy_use_data_11-29-2021.csv` - CO2 emissions tracking from various energy industries

	* Source: https://www.fao.org/faostat/en/#data/GN
	* Domain: Energy Use
	* Area Code (ISO3)
	* Area: the country name (all countries available were selected)
	* Element: Emissions (CO2)
	* Item: 'Gas-Diesel oil', 'Motor Gasoline', 'Natural gas (including LNG)', 'Coal', 'Electricity', 'Liquefied petroleum gas (LPG)', 'Fuel oil', 'Gas-diesel oils used in fisheries', 'Fuel oil used in fisheries'
	* Year: 1970 to 2019
	* Unit: kilotonnes
	* Value: CO2 emissions - absolute number
	* Flag Description: "FAO estimate", "International reliable sources" and "Aggregate, may include official, semi-official, estimated or calculated data"

* `fires_data_11-29-2021.csv` - hectares of fires within forests and savannas

	* Source: https://www.fao.org/faostat/en/#data/GI
	* Domain: Fires
	* Area Code (ISO3)
	* Area: the country name (all countries available were selected)
	* Element: Burned Area
	* Item: 'Humid tropical forest', 'Other forest', 'Closed shrubland', 'Grassland', 'Open shrubland', 'Savanna', 'Woody savanna'
	* Year: 1990 to 2019
	* Unit: ha
	* Value: hectares of burned area (in absolute number)
	* Flag Description: "Calculated Data" and "Aggregate, may include official, semi-official, estimated or calculated data"

* `land_cover_data_11-30-2021.csv` - hectares of covered land by land type

	* Source: https://www.fao.org/faostat/en/#data/LC
	* Domain: Land Cover
	* Area Code (ISO3)
	* Area: the country name (all countries available were selected)
	* Element: MODIS land cover types based on the Land Cover Classification System
	* Item: 'Artificial surfaces (including urban and associated areas)', 'Herbaceous crops', 'Woody crops', 'Multiple or layered crops', 'Grassland', 'Tree-covered areas', 'Mangroves', 'Shrub-covered areas', 'Shrubs and/or herbaceous vegetation, aquatic or regularly flooded', 'Sparsely natural vegetated areas', 'Terrestrial barren land', 'Permanent snow and glaciers', 'Inland water bodies', 'Coastal water bodies and intertidal areas'
	* Year: 2001 to 2018
	* Unit: 1000 ha
	* Value: hectares of covered land
	* Flag Description: "Calculated Data", "Data not available" and "Aggregate, may include official, semi-official, estimated or calculated data"
