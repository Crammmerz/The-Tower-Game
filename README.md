# 🏰 The Tower Game

A Godot-powered survival game where you are reincarnated as a tower in a collapsing world. Survive endless waves of slimes and protect humanity by upgrading your tower and managing resources.

## Overview

In The Tower Game you play as a sentient tower fighting to withstand waves of hostile slimes. The game focuses on replayable survival gameplay with scalable difficulty, modular systems, and progress-based upgrades.

## Demo

No demo available yet. To play locally, see the "Getting started" section below.

## Features

- Infinity Mode: Endless waves — survive as long as you can.
- Dynamic Horde Mechanics: Slimes spawn and scale in difficulty over time.
- Progression System: Gain XP and upgrade your tower to handle stronger waves.
- Modular Architecture: Manager-based OOP design (WaveManager, ProgressionManager, PlayerStateManager, GameManager, UIManager, AudioManager).
- Signal-driven flow for clear communication between systems.

## Technical Details

- Engine: Godot (tested on Godot 4.x — open project with the latest stable Godot 4 release).
- Language: GDScript
- Project file: project.godot

Managers included:
- WaveManager — controls slime spawning and wave behavior
- ProgressionManager — XP, leveling, and progression scaling
- PlayerStateManager — tower health, upgrades, and states
- GameManager — global game flow and state
- UIManager — HUD and UI updates (signal-based)
- AudioManager — handles SFX and music

Design principles: separation of concerns, modularity, and clear naming for scalability.

## Getting started (Run locally)

Requirements:
- Godot Engine 4.x (stable)

To run:
1. Clone the repository:
   git clone https://github.com/Crammmerz/The-Tower-Game.git
2. Open Godot and choose "Import" -> select the repository folder, or open `project.godot` directly.
3. Select the main scene (if prompted) and run the project (F5).

## Controls

- Use the on-screen UI to interact with the tower upgrades and abilities.
- Keyboard/mouse/gamepad mappings can be configured in the Godot project settings.

## Contributing

Contributions are welcome. Please open issues for bugs or feature requests. If you want to contribute code, fork the repo and open a pull request describing your changes.

## Notes & Roadmap

- Currently designed for Infinity Mode (endless survival). Future plans may include additional modes, enemy types, and abilities.
- XP scaling uses a gentle multiplier (~1.2) to balance long-term play.

## License

No license specified. If you want to make this project open-source under a specific license, add a LICENSE file (MIT, GPL, etc.).

## Contact

Created by @Crammmerz


