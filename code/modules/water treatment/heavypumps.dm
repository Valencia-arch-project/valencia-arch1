/obj/machinery/portable_atmospherics/powered/waterpump
	name = "Huge Water Pump"

	icon = 'icons/obj/atmos.dmi' //TODO: make real sprite in 'icons/atmos/watertreatment.dmi'
	icon_state = "scrubber:0"
	density = 1

	var/on = 0
	var/volume_rate = 5000

	volume = 50000

	power_rating = 7500 //7500 W ~ 10 HP
	power_losses = 300 //increased from 150 to account for "cheating" T20C constant temp of output water

	var/minrate = 0
	var/maxrate = 10 * ONE_ATMOSPHERE

	var/global/gid = 1 //number of existing
	var/id = 0 //specific id of an instance

/obj/machinery/portable_atmospherics/powered/waterpump/New()
	..()
	cell = null

	id = gid
	gid++

	name = "[name] (ID [id])"

/obj/machinery/portable_atmospherics/powered/waterpump/attack_hand(var/mob/user as mob)
		usr << "\blue You can't directly interact with this machine. Use the water control console."

/obj/machinery/portable_atmospherics/powered/waterpump/update_icon()
	src.overlays = 0

	if(on && !(stat & (NOPOWER|BROKEN)))
		icon_state = "scrubber:1"
	else
		icon_state = "scrubber:0"

/obj/machinery/portable_atmospherics/powered/waterpump/power_change()
	var/old_stat = stat
	..()
	if (old_stat != stat)
		update_icon()

/obj/machinery/portable_atmospherics/powered/waterpump/process()

	src.draw_water()

	if(!on || (stat & (NOPOWER|BROKEN)))
		update_use_power(0)
		last_flow_rate = 0
		last_power_draw = 0
		return 0

	var/power_draw = -1

	var/datum/gas_mixture/environment = loc.return_air()

	var/transfer_moles = min(1, volume_rate/environment.volume)*environment.total_moles

	for (var/obj/machinery/atmospherics/pipe/simple/P in src.loc) //runs a check to make sure you wont overload the pipe system you're pumping into
		var/datum/gas_mixture/air = P.return_air()
		if(air.return_pressure() >= 50*ONE_ATMOSPHERE)
			power_draw += pump_gas(src, air_contents, P, transfer_moles, active_power_usage)

	if (power_draw > 0) //accounts for not setting it = to something, but adding to it repeatedly
		power_draw++    //basically just says "if it uses power, make sure its not starting from -1, but from 0"

	if (power_draw < 0)
		last_flow_rate = 0
		last_power_draw = 0
	else
		use_power(power_draw)
		update_connected_network()

/obj/machinery/portable_atmospherics/powered/waterpump/attackby(var/obj/item/I as obj, var/mob/user as mob)

	if(istype(I, /obj/item/weapon/wrench))
		user << "\blue You rethink this idea; it might end badly..."
		return
	else
		return

/obj/machinery/portable_atmospherics/powered/waterpump/proc/draw_water() //Draws water from water treatment, on z level 1

	if(!on || (stat & (NOPOWER|BROKEN)))
		update_use_power(0)
		last_flow_rate = 0
		last_power_draw = 0
		return 0

	var/power_draw = -1

	var/datum/gas_mixture/air = src.return_air()

	var/transfer_moles = air_contents.volume - air //pumps enough to refill distro pump to the brim

	if(transfer_moles == 0) return

	var/turf/T = get_turf(src)
	var/new_z = T.z
	var/obj/machinery/portable_atmospherics/watertank/W

	while(checkTurfForDistro(locate(T.x, T.y, new_z))) //IT IS EXTREMELY IMPORTANT THAT THE DISTRO PUMPS BE STACKED ACROSS Z LEVELS CONSECUTIVELY (same x,y but different z)
		new_z--

	var/turf/WT = locate(T.x, T.y, new_z)

	for(var/obj/machinery/portable_atmospherics/watertank/C in WT.loc) //I did it this way so all the other distro pumps work. If one them is placed wrong, all of them work
		W = C //PLEASE FOR THE LOVE OF GOD CENTER THE DISTRO PUMPS OVER THE CENTER OF THE TANK

	power_draw += pump_gas(src, W.tank_contents, air, transfer_moles, active_power_usage)

	if (power_draw > 0) //accounts for not setting it = to something, but adding to it repeatedly
		power_draw++    //basically just says "if it uses power, make sure its not starting from -1, but from 0"

	if (power_draw < 0)
		last_flow_rate = 0
		last_power_draw = 0
	else
		use_power(power_draw)
		update_connected_network()

/obj/machinery/portable_atmospherics/powered/waterpump/proc/checkTurfForDistro(var/turf/T)
	for(var/obj/machinery/portable_atmospherics/powered/waterpump/W in T.loc)
		if (W) return 1
	return 0

/*
/obj/machinery/portable_atmospherics/powered/waterpump/massive  //A huge distro station for the entire server. IN CASE OF EMERGENCY DELETE NOTES
	name = "Massive Water Pump"

	icon = 'icons/obj/atmos.dmi'
	icon_state = "scrubber:0"
	density = 1

	var/on = 0
	var/volume_rate = 500000

	volume = 5000000 //HOLY JESUS THIS IS LARGE

	power_rating = 750000 //7500 W ~ 10 HP
	power_losses = 30000 //increased from 300 to account for HOW FUCKING HUGE IT IS

	var/maxrate = 1000 * ONE_ATMOSPHERE
*/