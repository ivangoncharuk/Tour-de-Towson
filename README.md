# Tour-de-Towson

Top-down bike pixel art game for Towson Game Design Club. Inspired[^tourdefrance-gameplay] by the Tour-De-France, you will be controlling a bicyclist competing against other bicyclists or AI's around the city of Towson, Maryland (*or other locations*). With unqiue gameplay and control mechanics like the [Peleton](https://en.wikipedia.org/wiki/Peloton)[^visualization], potentially being able to coordinate with a team to perform a [double pased line](https://youtu.be/h7wPa1Hl5ZA?t=361 "The Tour De France Explained in Animation"), this game is a personal side project and my first *seriously taken* shot at a fun video-game. 
Before complex things like the **peleton** and **team tactics** can be implemented the goal is to first:
- Create a simple arcade-racing type game
  - multiplayer and AI
- Have a consistant, simple, but visually appealing artwork style
- Modular tiles for map creation
- Convert racing *car* physics into a racing *bike* physics
  - (lots of math)
- Anything else important I may have missed.

[^visualization]: **The vision for how the game might look later in development:** <br />
<a href="http://www.youtube.com/watch?feature=player_embedded&v=7wPa1Hl5ZA&t=319s
" target="_blank"><img src="http://img.youtube.com/vi/h7wPa1Hl5ZA/0.jpg" 
alt="The Tour De France Explained in Animation" width="60" height="45" border="5" /></a>

[^tourdefrance-gameplay]: **Tour-de-France 2021 Gameplay** <br />
<a href="http://www.youtube.com/watch?feature=player_embedded&v=hQliQs7Bu9EE&t=187s
" target="_blank"><img src="http://img.youtube.com/vi/QliQs7Bu9EE/0.jpg" 
alt="Tour de France 2020 Gameplay (PS4 HD) [1080p60FPS]" width="60" height="45" border="5" /></a>

## CurrentFeature List:
- [x] Player that can move around with car-like movement
- [x] Checkpoint system
- [x] Developer Control panel on player for fine-tuning
- [x] Player HUD
- [x] Timer

## Planned features:

### Start Sceen
- [ ] Mode Switcher(race against AI or multiplayer)
- [ ] Map/Level Selector

### Gameplay
- [ ] Countdown timer to start the race
- [ ] A way to pause the game
- [ ] A winning game state after winning match
- [ ] Implement way to save/load the game
- [ ] Make the player movement fit more with bicycle than a car[^movement]
- [ ] Create a track in reference to Towson's roads or paths through the campus[^map]
- [ ] [Create AI that follows context based steering](http://kidscancode.org/godot_recipes/ai/context_map/ "Context Based Steering")
- [ ] Create controls and game logic that can immitate a tour-de-france type game[^tourdefrance-gameplay]
- [ ] Use real life physics to determine the bike logic[^physics]
- [ ] Implement multiplayer (decision: peer-to-peer or server-client)

[^movement]: A pedaling mechanic or something that isn't just holding
<kbd>W</kbd> <kbd>A</kbd> <kbd>S</kbd> <kbd>D</kbd> to move around.
https://www.real-world-physics-problems.com/bicycle-physics.html

[^map]: Realistic top down view of roads and paths that might look like Towson's campus from a birds-eye view in pixel art.  

[^physics]: Implement a [lean angle](https://www.real-world-physics-problems.com/bicycle-physics.html "Bicycle Physics") for animating the leaning and maybe have a way for the player to fall over.


### Sound
- [x] Some music for the game. Can be used for the start screen or anything else (**undecided**). *Credit to IcySoap for music*
- [ ] General Sound Effects

### Visuals
- [ ] Artwork / Animation for player states (moving, idle, turning (accurate leaning)
- [ ] Obstacles (i.e. traffic cones, moving pedestrians, potholes)
- [ ] Add tileable roads and pathways for map creation
- [ ] Dynamic stamina bar

## Misc
- [ ] Contributor.md file (for contributor credit)
- [ ] Create project game design document and integrate it with github.
- [ ] Create theme for UI
- [ ] 

## Current sneak peek of the game
[Sneak Peak](https://user-images.githubusercontent.com/85744041/157512213-ebdfb25e-010a-4f2f-942b-20cb5ab7601c.png)


