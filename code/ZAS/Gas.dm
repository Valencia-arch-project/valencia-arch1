/xgm_gas/oxygen
	id = "oxygen"
	name = "Oxygen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.032	// kg/mol

	flags = XGM_GAS_OXIDIZER

/xgm_gas/nitrogen
	id = "nitrogen"
	name = "Nitrogen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.028	// kg/mol

/xgm_gas/carbon_dioxide
	id = "carbon_dioxide"
	name = "Carbon Dioxide"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.044	// kg/mol

/xgm_gas/phoron
	id = "phoron"
	name = "Phoron"
	specific_heat = 200	// J/(mol*K)

	//Hypothetical group 14 (same as carbon), period 8 element.
	//Using multiplicity rule, it's atomic number is 162
	//and following a N/Z ratio of 1.5, the molar mass of a monatomic gas is:

	//isnt the N/Z ratio 1.6?
	molar_mass = 0.405	// kg/mol

	tile_overlay = "phoron"
	overlay_limit = 0.7
	flags = XGM_GAS_FUEL | XGM_GAS_CONTAMINANT

/xgm_gas/volatile_fuel
	id = "volatile_fuel"
	name = "Volatile Fuel"
	specific_heat = 253	// J/(mol*K)	C8H18 gasoline. Isobaric, but good enough.
	molar_mass = 0.114	// kg/mol. 		same.

	flags = XGM_GAS_FUEL

/xgm_gas/sleeping_agent
	id = "sleeping_agent"
	name = "Sleeping Agent"
	specific_heat = 40	// J/(mol*K)
	molar_mass = 0.044	// kg/mol. N2O

	tile_overlay = "sleeping_agent"
	overlay_limit = 1

/xgm_gas/oxygen_agent_b
	id = "oxygen_agent_b"
	name = "Oxygen Agent-B"	//what is this?
	specific_heat = 300	// J/(mol*K)
	molar_mass = 0.032	// kg/mol

/xgm_gas/water
	id = "water"
	name = "Water"
	specific_heat = 5207 // all the others were fudged so I made it relative to oxygen's fake specific heat and what it is irl  --MadSnailDisease
	molar_mass = 0.018

	tile_overlay = "water"
	overlay_limit = 0.6

/xgm_gas/heavy_water
	id = "heavywater"
	name = " Heavy Water"
	specific_heat = 5207 //I'm salty that I have to recode this, so I'm assuming its about the same
	molar_mass = 0.045 //approx 2.5 standard MM assuming equal deuterium/tritium combo

	tile_overlay = "water"
	overlay_limit = 0.1
