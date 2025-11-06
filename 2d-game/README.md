# System Design Choices

The 2D game is a vertical platformer that lacks checkpoints and deaths. The goal is to reach the highest point in the level. It is a game that causes the player to fall if they make a wrong move, similar to the game Getting Over It. 

The player begins with the ability to move left and right, as well as jump. As the player progresses, they gain new controls, such as dashing and a double jump. They do not lose these new abilities, which makes it easier to progress upwards if they fall. A label appears indicating that the player has unlocked new abilities when they reach certain zones in the map.

The player encounters environmental hazards, such as gravity shifts, wind, and slippery surfaces, as they progress. Wind slows down the player and makes it difficult to move forward. The slippery surface causes the player to slide when moving, which can lead to the potential of falling off platforms. The slippery surface and wind have enemies attached. The player can remove enemies by jumping on top of the enemy sprite. The player has a choice between destroying the enemies or leaving them alone, which can result in a difficult time progressing if the player falls. Flipping gravity turns the player upside down and inverts their movements.

This game begins with simple information on the type of controls available to the player. The player learns how to use basic movements and when to use the controls that they gain as they progress. They learn how to react to environmental changes and counteract hazards. This game rewards progression and encourages experimentation with specific shortcuts and the use of antigravity to advance more quickly.
