/////////////////////////////////////////////////////////////////////////
//   Not very special, just initiates fusion, cuz science              //
//   A lil bit hacky, but it doesnt need to be realistic               //
//   By Mad Snail Disease                                               //
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
	if (istype(Proj, /obj/item/projectile/bullet/muon))
		var/list/location = getCircle(src.loc, 5)
		for(var/turf/T in location)
			var/datum/gas_mixture/G = T.return_air()
			if (G.gas["heavywater"] >= 0.01)
				new /obj/effect/fusion(src.loc)
		return 1
	else
		..()