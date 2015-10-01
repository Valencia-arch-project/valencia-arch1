/obj/machinery/portable_atmospherics/watertank
	name = "Water Tank"
	desc = "A massive water tank the holds \"clean\" water"

	icon = 'icons/atmos/watertreatment.dmi'

	volume = 500000 //pretty damn big

	anchored = 1

	var/datum/gas_mixture/tank_contents

/obj/machinery/portable_atmospherics/watertank/New()
	..()
	tank_contents.adjust_gas("water", (volume/22.4)) //assuming volume in liters, should be the volume divided by moles per liter of 22.4, so just enough moles to fill it up 100%
	src.update_icon()

/obj/machinery/portable_atmospherics/watertank/update_icon()

	src.overlays = 0

	if(src.tank_contents.total_moles <= 0)
		src.tank_contents.total_moles = 0
		var/I = src.icon_state
		//icon_state =
		overlays += I
	else if(src.tank_contents.total_moles < (src.volume/22.4)/4)
		var/I = src.icon_state
		//icon_state =
		overlays += I
	else if(src.tank_contents.total_moles < (src.volume/22.4)/2)
		var/I = src.icon_state
		//icon_state =
		overlays += I
	else if(src.tank_contents.total_moles < 3*(src.volume/22.4)/4)
		var/I = src.icon_state
		//icon_state =
		overlays += I
	else if(src.tank_contents.total_moles <= (src.volume/22.4))
		var/I = src.icon_state
		//icon_state =
		overlays += I
	else
		src.tank_contents.total_moles = (src.volume/22.4)
		var/I = src.icon_state
		//icon_state =
		overlays += I

/obj/machinery/portable_atmospherics/watertank/t_left
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/t_center
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/t_right
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/left
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/center
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/right
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/b_left
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/b_center
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/b_right
	//icon_state =

/obj/machinery/portable_atmospherics/watertank/center/process()

	..()
	src.stabalize_contents()

/obj/machinery/portable_atmospherics/watertank/center/proc/stabalize_contents() //its weird, but it basically normalizes the pressure over all of the surrounding tanks
	var/total_moles = 0
	var/I = 0

	for(var/obj/machinery/portable_atmospherics/watertank/W in view(1))
		total_moles += W.tank_contents.total_moles
		I++

	var/individual_moles = total_moles/I

	for(var/obj/machinery/portable_atmospherics/watertank/W in view(1))
		W.tank_contents.total_moles = individual_moles