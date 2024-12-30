# Space Invaders FPGA Project

This repository contains the files necessary to implement a Space Invaders game on the DE10-Lite board using Quartus Prime Lite.

## Project Structure

```plaintext
build/
├── quartus_project.qpf      # Quartus project file
├── quartus_settings.qsf     # Quartus settings file
└── pin_assignment.qsf       # Pin assignments for the DE10-Lite board
src/
├── vga_controller.v         # VGA controller module
├── game_logic.v             # Main game logic module
├── alien_logic.v            # Alien movement and shooting logic
├── bullet_logic.v           # Bullet management logic
├── collision_detector.v     # Collision detection logic
├── score_tracker.v          # Score tracking module
sprites/
├── player_sprite.mem        # Player sprite data
├── alien_sprite.mem         # Alien sprite data
├── bullet_sprite.mem        # Bullet sprite data
└── background.mem           # Background pattern data
```
