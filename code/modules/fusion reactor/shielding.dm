/////////////////////////////////////////////////////////////////////////
//   The general walling for the reactor                               //
//   Largely hacky because the magnets keep the heat off of the walls  //
//   By MadSnailDisease                                                //
/////////////////////////////////////////////////////////////////////////

/turf/simulated/wall/heatshield
	name = "heatshield"
	desc = "A reinforced, extremely dense hunk of metal used to contain massive amounts of heat"
	icon = 'icons/turf/wall_masks.dmi'
	//icon_state =
	opacity = 1
	density = 1
	blocks_air = 1
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 650000 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall //DOUBLE THAT SHIT WE AINT DYING TO NO HEAT

/turf/simulated/wall/magnet
	name = "magnet"
	desc = "A reinforced magnet that keeps the fusion away from any surface"
	icon = 'icons/turf/wall_masks.dmi'
	//icon_state =
	opacity = 1
	density = 1
	blocks_air = 1
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 1300000 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall //DOUBLE THAT SHIT WE AINT DYING TO NO HEAT //DOUBLED AGAIN

/turf/simulated/floor/magnet
	name = "Magnet"
	icon = 'icons/turf/floors.dmi'
	//icon_state =
	//icon_regular_floor =  //should be equal to icon_state
	icon_plating = null
	thermal_conductivity = 0.00
	heat_capacity = 1300000 //This is a stupidly high number, but this shit aint melting on my watch