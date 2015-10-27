///////////////////////////////////////////////////////////////////////////////////////////////
//   The particle collector for the reactor                                                  //
//   Converts heat (Joules) to energy in standard watt*second conversion with 50% efficency  //
//   By MadSnailDisease                                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////

#define THERMOELECTRIC_CONVERSION_EFFICIENCY 0.5


/obj/machinery/power/collector
	name = "neutron collector"
	desc = "A hunk of graphite that converts heat from fusion rections into energy"
	icon = 'icons/turf/wall_masks.dmi'
	//icon_state =

	var/last_measure = 0

/obj/machinery/power/collector/process()
	var/dt = world.time - last_measure
	last_measure = world.time / 10 //doing the math in seconds, not deciseconds
	var/turf/T = locate(src.x, src.y - 1, src.z) //please for the love of god put this at the top of the reactor
	var/datum/gas_mixture/G = T.return_air()
	var/output = G.temperature * THERMOELECTRIC_CONVERSION_EFFICIENCY / dt //its a Joules/time in seconds = watts conversion
	add_avail(output)
	return