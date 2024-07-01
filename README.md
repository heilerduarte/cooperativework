# Cooperative Cap Collection with Obstacles

## Overview

This project is a simulation model where agents work cooperatively to collect and transport caps (tapas) to designated areas (tierras) while navigating through a grid with obstacles. The agents utilize pathfinding algorithms to determine the best routes and engage in cooperative behaviors once they meet.

## Features

- **Pathfinding Algorithms:** Choose between A*, Dijkstra, JPS, and BF algorithms for path optimization.
- **Neighborhood Types:** Select 4 or 8 neighborhood connectivity for movement decisions.
- **Dynamic Obstacles:** Grid cells have a probability of being obstacles that agents need to navigate around.
- **Agent Cooperation:** Agents initiate cooperative behavior upon meeting to efficiently collect and transport caps.

## Parameters

- `algorithm`: The pathfinding algorithm used by agents. Options: ["A*", "Dijkstra", "JPS", "BF"]. Default: "A*".
- `neighborhood_type`: Determines the type of neighborhood connectivity. Options: [4, 8]. Default: 4.
- `numero_de_tierra`: The number of destination areas (tierras). Default: 3.
- `numero_de_tapas`: The number of caps (tapas) to be collected. Default: 3.

## Global Variables

- `cooperation_started`: Indicates whether the cooperative behavior has started. Default: false.
- `ubi_tierras`, `ubi_tapas`: Lists storing the locations of tierras and tapas.
- `tapas_llevadas`: List of caps that have been transported.
- `tierras_ocupadas`: List of occupied tierras.
- `people_location_1`, `people_location_2`: Current locations of the two agents.
- `common_tapa`, `common_tierra`: Common targets for caps and tierras during cooperation.
- `path_actual`: Current path being followed by an agent.
- `carrying_tapa_1`, `carrying_tapa_2`: Flags indicating if agents are carrying a cap.
- `agents_met`: Flag indicating if the agents have met.
- `tapa_recogida_1`, `tapa_recogida_2`: Locations where the caps were picked up.

## Species and Behaviors

### People (Agent 1)
- **Skills:** Moving
- **Reflexes:**
  - `move_to_next`: Moves towards the next target (cap or tierra) during cooperation.
  - `move`: Moves in a predefined pattern before cooperation starts.
  - `check_agents_met`: Checks if the agents have met to start cooperation.
- **Aspect:** Visual representation as a cyan triangle.

### People2 (Agent 2)
- **Skills:** Moving
- **Reflexes:**
  - `move_to_next`: Moves towards the next target (cap or tierra) during cooperation.
  - `move`: Moves in a predefined pattern before cooperation starts.
  - `check_agents_met`: Checks if the agents have met to start cooperation.
- **Aspect:** Visual representation as a green circle.

### Tierra (Destination Area)
- **Skills:** Moving
- **Initialization:** Randomly assigned to unoccupied grid cells.
- **Aspect:** Visual representation as a brown square.

### Tapa (Cap)
- **Skills:** Moving
- **Initialization:** Randomly assigned to unoccupied grid cells.
- **Reflexes:**
  - `follow_people`: Follows the agents when they are carrying the cap.
- **Aspect:** Visual representation as a pink square.

## Grid Configuration

- **Cell Size:** 10x10 units
- **Neighbors:** Determined by `neighborhood_type`
- **Obstacles:** 8% probability of each cell being an obstacle
- **Colors:** Obstacles are black, navigable cells are white.

## Experiment: Goto Grid

### Type: GUI

- **Output Display:**
  - Displays the grid with agents, caps, and destination areas.
  - Provides a visual representation of the agents' movements and interactions.

## How to Run

1. Initialize the model with desired parameters.
2. Start the simulation to observe agents navigating the grid, collecting caps, and transporting them to designated areas.
3. Monitor the output display for real-time visualization of agent behaviors and pathfinding.

## Authors

- Emmanuel y Heiler

## Tags

- Pathfinding, Cooperative Agents, Simulation, Grid Navigation, Obstacles
