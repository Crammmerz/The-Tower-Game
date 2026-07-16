# 🏰 The Tower Game

A Godot-powered survival project where you are reincarnated as a tower in a collapsing world.
Your only goal: survive against endless waves of slimes.

## Usage / Permissions

This repository is a portfolio/demo project intended to showcase development work. The project is provided for viewing and educational purposes only. Do not copy, modify, distribute, or use the code or assets to create a game or derivative project without explicit written permission from the copyright holder.

This project is intended as a portfolio/demo showcasing development work in Godot, emphasizing clean architecture and scalability.

## Overview

In The Tower Game you play as a sentient tower fighting to withstand waves of hostile slimes. The game focuses on replayable survival gameplay with scalable difficulty, modular systems, and progress-based upgrades.

## Demo

No demo available yet. To play locally, see the "Getting started" section below.

## Features

- Infinity Mode: Endless waves — survive as long as you can.
- Dynamic Horde Mechanics: Slimes spawn and scale in difficulty over time.
- Progression System: Gain XP and upgrade your tower to handle stronger waves.
- Modular Architecture: Manager-based design for clarity and scalability. (WaveManager, ProgressionManager, PlayerStateManager, GameManager, UIManager, AudioManager).
- Signal-Driven Flow: Systems communicate via signals for clean separation of concerns.
- OOP Principles: Built with reusable, maintainable code structure.

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

## Team

- @Crammmerz — Developer / Maintainer
- @raarowkey — Arts / Graphics Designer
- @ven — UI Designer
- @jihnxy — Game Level Designer

If you'd like to contact a team member about permissions or collaboration, open an issue or reach out via their GitHub profile.

## Contributing

Contributions are welcome in the form of feedback. For code or asset reuse requests, you MUST obtain written permission from the copyright holder before proceeding.

Please open issues for bugs or feature requests. If you want to contribute code (with permission), fork the repo and open a pull request describing your changes.

## Notes & Roadmap

- Currently designed for Infinity Mode (endless survival). Future plans may include additional modes, enemy types, and abilities.
- XP scaling uses a gentle multiplier (~1.2) to balance long-term play.

## License

All rights reserved. See the LICENSE file for full details.
This project is provided for educational and portfolio purposes only.
Do not copy, modify, or distribute without explicit permission.

## Contact

Created and maintained by @Crammmerz.
For collaboration or permissions, open an issue or reach out via GitHub profile.
