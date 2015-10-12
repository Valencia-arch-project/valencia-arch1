/////////////////////////////////////////////////////////////////////////
//   Not very special, just initiates fusion, cuz science              //
//   A lil bit hacky, but it doesnt need to be realistic               //
//   By MadSnail Disease                                               //
/////////////////////////////////////////////////////////////////////////




/turf/simulated/wall/refractor
	name = "refractor"
	desc = "It scatter muons to initiate a fusion cascade" //sounds smrt enough for me
	//icon =
	//icon_state =
	opacity = 0
	density = 1
	blocks_air = 0
	thermal_conductivity = 0
	heat_capacity = 650000

/turf/simulated/wall/refractor/bullet_act(var/obj/item/projectile/Proj)
	var/datum/gas_mixture/G = src.loc.return_air()
	if (istype(Proj, /obj/item/projectile/bullet/muon) && G.gas["heavywater"] >= 0.01)
		new /obj/effect/fusion(src.loc)
	else
		..()