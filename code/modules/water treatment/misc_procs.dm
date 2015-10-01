/////////////////////////////////////////////////
//   Miscellanious procs                       //
//   Used mostly in the handling of water      //
//   Written by MadSnailDisease                //
/////////////////////////////////////////////////


//runs a check on the arguement to see if the pipes at that loc have ONLY water in them
/proc/waterisclean(var/turf/T)

	if(istype(src, /area))
		return 0

	var/datum/gas_mixture/pipe

	for(var/obj/machinery/atmospherics/pipe/simple/P in T.loc)
		pipe = P.return_air()

	for(var/xgm_gas/G in pipe.gas)
		if (G.id != "water")
			return 0

	return 1