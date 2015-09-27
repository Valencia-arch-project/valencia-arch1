/obj/machinery/portable_atmospherics/powered/waterpump
	name = " Huge Water Pump"

	icon = 'icons/obj/atmos.dmi'
	icon_state = "scrubber:0"
	density = 1

	var/on = 0
	var/volume_rate = 5000

	volume = 50000

	power_rating = 7500 //7500 W ~ 10 HP
	power_losses = 300 //increased from 150 to account for "cheating" T20C constant temp of output water

	var/minrate = 0
	var/maxrate = 10 * ONE_ATMOSPHERE

	var/list/scrubbing_gas = list("water")

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

	air_contents.volume = volume //init cheating version, always has full volume << result of many stacked upon each other over z levels
	air_contents.temperature = T20C //room temp water seems about right

	if(!on || (stat & (NOPOWER|BROKEN)))
		update_use_power(0)
		last_flow_rate = 0
		last_power_draw = 0
		return 0

	var/power_draw = -1

	var/datum/gas_mixture/environment = loc.return_air()

	var/transfer_moles = min(1, volume_rate/environment.volume)*environment.total_moles

	for (var/obj/machinery/atmospherics/pipe/P in src.loc)
		power_draw += pump_gas(src, air_contents, P, transfer_moles, active_power_usage)

	/*
	if (power_draw > 0) //accounts for not setting it = to something, but adding to it repeatedly
		power_draw++    //basically just says "if it uses power, make sure its not starting from -1, but from 0
	*/

	if (power_draw < 0)
		last_flow_rate = 0
		last_power_draw = 0
	else
		use_power(power_draw)
		update_connected_network()

/obj/machinery/portable_atmospherics/powered/waterpump/attackby(var/obj/item/I as obj, var/mob/user as mob)
	if(istype(I, /obj/item/weapon/wrench))
		user << "\blue The bolts are too tight for you to unscrew!"
		return

	..()