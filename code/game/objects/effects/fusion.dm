/obj/effect/fusion
	name = "particles under fusion"
	desc = "Lets not walk into it"
	//icon =
	//icon_state =
	density = 0
	unacidable = 1
	anchored = 1.0

/obj/effect/fusion/process()
	for(var/mob/M in src.loc)
		M.gib() //owie
	for(var/turf/T in oview(1))
		if(istype(T, /turf/simulated/wall/magnet))
			return
		if(/obj/effect/fusion in T.loc)
			return
		var/datum/gas_mixture/G = T.return_air()
		for(var/xgm_gas/A in G.gas)
			if(A.id == "heavywater")
				var/B = G.total_moles
				G.adjust_gas(A.id, -G.gas[A.id])
				G.gas["helium"] += B
				G.temperature = 1e8 //fusion is hot af //maybe change later if its broken and glitchy
				new /obj/effect/fusion(T.loc)
				return
		return