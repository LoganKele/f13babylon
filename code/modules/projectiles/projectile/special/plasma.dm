/obj/item/projectile/plasma
	name = "plasma blast"
	icon_state = "plasmacutter"
	damage_type = BRUTE
	damage = 10
	range = 4
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	var/pressure_decrease_active = FALSE
	var/pressure_decrease = 0.25
	var/mine_range = 3 //mines this many additional tiles of rock
	tracer_type = /obj/effect/projectile/tracer/plasma_cutter
	muzzle_type = /obj/effect/projectile/muzzle/plasma_cutter
	impact_type = /obj/effect/projectile/impact/plasma_cutter

/obj/item/projectile/plasma/Initialize(mapload)
	. = ..()
	if(!lavaland_equipment_pressure_check(get_turf(src)))
		name = "weakened [name]"
		damage = damage * pressure_decrease
		pressure_decrease_active = TRUE

/obj/item/projectile/plasma/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)
		if(mine_range)
			mine_range--
			range++
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE

/obj/item/projectile/plasma/adv
	damage = 14
	range = 5
	mine_range = 5

/obj/item/projectile/plasma/adv/mech
	range = 9
	mine_range = 3
	hitscan = TRUE

/obj/item/projectile/plasma/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 24
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

/obj/item/projectile/plasma/weak
	damage = 10
	range = 4
	mine_range = 0
