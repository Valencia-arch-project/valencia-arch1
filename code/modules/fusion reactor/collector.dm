/////////////////////////////////////////////////////////////////////////
//   The particle collector for the reactor                            //
//   Largely hacky because the magnets keep the heat off of the walls  //
//   By MadSnailDisease                                                //
/////////////////////////////////////////////////////////////////////////
/obj/machinery/power/collector
	name = "neutron collector"
	desc = "A hunk of graphite that converts heat from fusion rections into energy"
	icon = 'icons/turf/wall_masks.dmi'
	//icon_state =

/obj/machinery/power/collector/process()
	var/turf/T = locate(src.x, src.y - 1, src.z) //please for the love of god put this at the top of the reactor
	if(/obj/effect/fusion in T.loc)
		var/datum/gas_mixture/G = T.return_air()
		if(G.gas["heavywater"] >= 0)
			var/output = G.temperature / 2
			add_avail(output)
			return
		else
			return
	else
		return