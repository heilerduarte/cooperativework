/**
* Name: Agentes recogen tapas en modo cooperarivo con obstaculos
* Based on the internal empty template. 
* Author: Emmanuel y Heiler
* Tags: 
*/
model prueba16
global {
    string algorithm <- "A*" among: ["A*", "Dijkstra", "JPS", "BF"] parameter: true;
    int neighborhood_type <- 4 among: [4, 8] parameter: true;
    int numero_de_tierra <- 3;
    int numero_de_tapas <- 3;
    bool cooperation_started <- false;
    list<point> ubi_tierras <- [];
    list<point> ubi_tapas <- [];
    list<point> tapas_llevadas <- [];
    list<point> tierras_ocupadas <- [];
    point people_location_1;
    point people_location_2;
    point common_tapa <- nil;
    path  path_actual <-nil;
    point common_tierra <- nil;
    bool carrying_tapa_1 <- false;
    bool carrying_tapa_2 <- false;
    bool agents_met <- false;
    point tapa_recogida_1 <- nil;
    point tapa_recogida_2 <- nil;
    init {
        create people number: 1 {
            location <- {5, 5, 0}; 
            people_location_1 <- location;
        }
        create people2 number: 1 {
            location <- {5, 95, 0}; 
            people_location_2 <- location;
        }
        create tierra number: numero_de_tierra;
        create tapa number: numero_de_tapas;
    }
}
species people skills: [moving] {
    bool move_right <- true;
    int steps_taken <- 0;
    
    point tapa_location;
    aspect default {
        draw triangle(7) color: #cyan;
        if (current_path != nil) {
            draw current_path.shape color: #red;
        }
    }
	reflex move_to_next when: cooperation_started {
	    if (carrying_tapa_1) {
	        if (common_tierra = nil) {
	            if (length(ubi_tierras) > 0) {
	                common_tierra <- first(ubi_tierras);
	                remove first(ubi_tierras) from: ubi_tierras;
	            } else {
	                common_tierra <- nil;
	            }
	        }
	        if (common_tierra != nil) {
	            do goto (on:cell where not each.is_obstacle, target:common_tierra, speed:speed, recompute_path: false);
	            if (distance_to(location, common_tierra) = 0) {
	                location <- common_tierra;
	                carrying_tapa_1 <- false;
	                common_tierra <- nil;
	                tapa_recogida_1 <- nil;
	            } else if (tapa_recogida_1 != nil) {
	                tapa_recogida_1 <- location;
	            }
	        }
	    } else {
	        if (common_tapa = nil) {
	            if (length(ubi_tapas) > 0) {
	                common_tapa <- min_of(ubi_tapas where (!(each in tapas_llevadas)), each distance_to location);
	                common_tapa <- first(ubi_tapas);
	                remove first(ubi_tapas) from: ubi_tapas;
	            } else {
	                common_tapa <- nil;
	            }
	        }
	        if (common_tapa != nil) {
	            do goto (on:cell where not each.is_obstacle, target:common_tapa, speed:speed, recompute_path: false);
	            if (distance_to(location, common_tapa) < 1) {
	                location <- common_tapa;
	                carrying_tapa_1 <- true;
	                tapa_recogida_1 <- common_tapa;
	                common_tapa <- nil;
	                write "Tapa recogida en " + location + " por people";
	            }
	        }
	    }
	}
    reflex move when: (!agents_met) {
        point next_location <- next_step(location);
        if (next_location != location) {
            location <- next_location;
            steps_taken <- steps_taken + 1;
            people_location_1 <- location; 
        }
    }
    reflex check_agents_met {
        if (distance_to(location, people_location_2) < 1) {
            agents_met <- true;
            cooperation_started <- true;
            common_tapa <- nil;
            common_tierra <- nil;
        }
    }
    point next_step(point current_location) {
        point next_location <- current_location;
        if (move_right) {
            next_location <- current_location + {10, 0, 0};
            if (next_location.x >= 100) {
                next_location <- current_location + {0, 10, 0};
                move_right <- false;
            }
        } else {
            next_location <- current_location + {-10, 0, 0};
            if (next_location.x < 0) {
                next_location <- current_location + {0, 10, 0};
                move_right <- true;
            }
        }
        if (next_location.y >= 100) {
            next_location <- current_location;
        }
        return next_location;
    }
}
species people2 skills: [moving] {
    bool move_right <- true;
    int steps_taken <- 0;
    
    point tapa_location;
    aspect default {
        draw circle(3) color: #green;
        if (current_path != nil) {
            draw current_path.shape color: #green;
        }
    }
	reflex move_to_next when: cooperation_started {
	    if (carrying_tapa_2) {
	        if (common_tierra = nil) {
	            if (length(ubi_tierras) > 0) {
	                common_tierra <- first(ubi_tierras);
	            } else {
	                common_tierra <- nil;
	            }
	        }
	        if (common_tierra != nil) {
	            do goto (on:cell where not each.is_obstacle, target:common_tierra, speed:speed, recompute_path: false);
	            if (distance_to(location, common_tierra) < 1) {
	                location <- common_tierra;
	                carrying_tapa_2 <- false;
	                common_tierra <- nil;
	                tapa_recogida_2 <- nil;
	            } else if (tapa_recogida_2 != nil) {
	                tapa_recogida_2 <- location;
	            }
	        }
	    } else {
	        if (common_tapa = nil) {
	            if (length(ubi_tapas) > 0) {
	                common_tapa <- min_of(ubi_tapas where (!(each in tapas_llevadas)), each distance_to location);
	                common_tapa <- first(ubi_tapas);
	            } else {
	                common_tapa <- nil;
	            }
	        }
	        if (common_tapa != nil) {
	            do goto (on:cell where not each.is_obstacle, target:common_tapa, speed:speed, recompute_path: false);
	            if (distance_to(location, common_tapa) < 1) {
	                location <- common_tapa;
	                carrying_tapa_2 <- true;
	                tapa_recogida_2 <- common_tapa;
	                common_tapa <- nil;
	                write "Tapa recogida en " + location + " por people";
	            }
	        }
	    }
	}
    reflex move when: (!agents_met) {
        point next_location <- next_step(location);
        if (next_location != location) {
            location <- next_location;
            steps_taken <- steps_taken + 1;
            people_location_2 <- location; 
        }
    }
    reflex check_agents_met {
        if (distance_to(location, people_location_1) < 1) {
            agents_met <- true;
            cooperation_started <- true;
            common_tapa <- nil; 
            common_tierra <- nil;
        }
    }
    point next_step(point current_location) {
        point next_location <- current_location;
        if (move_right) {
            next_location <- current_location + {10, 0, 0};
            if (next_location.x >= 100) {
                next_location <- current_location + {0, -10, 0};
                move_right <- false;
            }
        } else {
            next_location <- current_location + {-10, 0, 0};
            if (next_location.x < 0) {
                next_location <- current_location + {0, -10, 0};
                move_right <- true;
            }
        }
        if (next_location.y < 0) {
            next_location <- current_location;
        }
        return next_location;
    }
}
species tierra skills: [moving]  {
    cell cel_tierra <- one_of(cell where (not each.is_obstacle and not each.esta_ocupado));
    init {
        cel_tierra.esta_ocupado <- true;
        location <- cel_tierra.location;
        ubi_tierras <- ubi_tierras + location;
    }
    aspect base {
        draw square(2.5) color: #brown;
    }
}
species tapa skills: [moving] {
    cell cel_tapa <- one_of(cell where (not each.is_obstacle and not each.esta_ocupado));
    init {
        cel_tapa.esta_ocupado <- true;
        location <- cel_tapa.location;
        ubi_tapas <- ubi_tapas + location;
    }
    aspect base {
        draw square(2.5) color: #pink;
    }
	reflex follow_people when: cooperation_started{
	    if (carrying_tapa_1 and tapa_recogida_1 != nil and tapa_recogida_1 = location) {
	        location <- {200, 200, 0}; 
	    }
	    if (carrying_tapa_2 and tapa_recogida_2 != nil and tapa_recogida_2 = location) {
	        location <- {200, 200, 0}; 
	    }
	}
}
grid cell width: 10 height: 10 neighbors: neighborhood_type optimizer: algorithm {
    bool is_obstacle <- flip(0.08);
    bool esta_ocupado <- is_obstacle;
    bool puedenavegar <- !is_obstacle;
    rgb color <- is_obstacle ? #black : #white;
}
experiment goto_grid type: gui {
    output {
        display objects_display type: gui antialias: false {
            grid cell border: #black;
            species people aspect: default;
            species people2 aspect: default;
            species tierra aspect: base;
            species tapa aspect: base;
        }
    }
}