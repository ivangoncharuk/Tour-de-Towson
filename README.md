# Tour-de-Towson

Tour-de-Towson is my take on the Tour de France in a top-down 2-D Pixel art game. The game will simulate the modern rules of the Tour De France competition, with the twist of being set in the state of Maryland. Players will need to use real-world tactics used in the tour in order to come out on top.

## The Tour de France
[Information Source](https://www.youtube.com/watch?v=5RH3LELmEWE)<br />
The Tour de France, running since 1903, is one of the most difficult and impressive road-bike races throughout the year. It takes the competitors through 21 stages of the French country-side.
### Modern Tour De France
- 23 days
  - 21 stages
  - each stage has around 5-6 hours of travel time
  - 2 rest days
    - typically in the first and second weekend of racing
- around 3500 km or 2000 mi in length
- each stage is classified into categories
  - flat stages
    - typically used as *transition* stages used to move between the different moutain ranges and other obstacles
    - typical tours will see 6-10 flat stages
    - very flat and even profile, small amounts of elevation
  - hilly stages
    - located near the foot hills of larger mountains, or small mountain ranges in france
    - typical tours will see 3-4 flat stages
    - prefer "classics" riders, riders that can both climb small mountains and sprint
  - mountain stages
    - most famous
    - 6-8 times per race
    - most difficult, challenging, and important stages
    - between 3000-6000 m of climbing elevation gain
    - located in the alps
    - most influencial, only the best climbers can contest for stage win
  - individual time trial stages (ITT's)
    - some of the most important
    - demanding short courses
    - can occur 1 to 3 times per tour
    - rider must rely on their own skills against the clock
    - ITTs vary between 10-40 km
    - some are extremely flat, some are hilly, sometimes there are mountain climbs
  - team time trial stages
    - similar format to ITTs
    - each team is a group of 8 riders under one sponsor
    - time stops after the first four riders cross finish line
    - not as common as other types of stages, i.e. havent been featured in the tour since 2019
- prizes
  - the Maillot jaune (yellow jersey)
    - worn by the race leader, has the least cummulative time throughout all the stages that has been contested so far
    - winner of the Maillot jaune is the winner of the tour
  - the Green jersey
    - typically sprinters wear this one
  - the Polka-dot jersey
    - top rider in the mountains
  - the white jersey
    - similar to yellow jersey, uses cummulative time
    - only for young riders under age 25
  - top riders are so competitively close, the tour can finish within a matter of minutes or even seconds
    - last few stages extremely important


Top-down bike pixel art game for Towson Game Design Club. Inspired[^tourdefrance-gameplay] by the Tour-De-France, you will be controlling a bicyclist competing against other bicyclists or AI's around the city of Towson, Maryland (*or other locations*). With unqiue gameplay and control mechanics like the [Peleton](https://en.wikipedia.org/wiki/Peloton)[^visualization], potentially being able to coordinate with a team to perform a [double pased line](https://youtu.be/h7wPa1Hl5ZA?t=361 "The Tour De France Explained in Animation"), this game is a personal side project and my first *seriously taken* shot at a fun video-game. 

[^visualization]: **The vision for how the game might look later in development:** <br />
<a href="http://www.youtube.com/watch?feature=player_embedded&v=7wPa1Hl5ZA&t=319s
" target="_blank"><img src="http://img.youtube.com/vi/h7wPa1Hl5ZA/0.jpg" 
alt="The Tour De France Explained in Animation" width="60" height="45" border="5" /></a>

[^tourdefrance-gameplay]: **Tour-de-France 2021 Gameplay** <br />
<a href="http://www.youtube.com/watch?feature=player_embedded&v=hQliQs7Bu9EE&t=187s
" target="_blank"><img src="http://img.youtube.com/vi/QliQs7Bu9EE/0.jpg" 
alt="Tour de France 2020 Gameplay (PS4 HD) [1080p60FPS]" width="60" height="45" border="5" /></a>

## Goals
- Create the racing mechanic
  - A map with a player and AI's racing eachother for the best time.
- Have a consistant, simple, but visually appealing artwork style and animation
  - pixel art for bike
  - animation for pedaling
  - animation for [pedaling with effort](https://youtu.be/bJfLTzZswz0?t=393)
  - modular road system
    - straight roads
    - curved roads
    - sharp cornered roads
    - non-pavement roads
  - different types of roads, with different coefficient's of friction
  - different % grades for roads (as an export variable) which is useful for mountain stages
- Plan and create an elegant UI theme
- Implement real bike physics
- Implement Tour De France scoring system
- Implement graphics for drafting, where [breakaways](https://www.youtube.com/watch?v=su0KtKDQyqE) are key in order to win

## Physics [*source*](https://www.real-world-physics-problems.com/bicycle-physics.html)

The goal is to:
- create a system for handling how much energy a biker is exerting
  - this is the game mechanic that makes the tour competitive.
- Convert racing *car* physics into a racing *bike* physics:

### Bike Stability
When analyzing bicycle stability, the game will use two parameters of the bike.
- the lean angle
  - left and right angle the bike **frame** makes with a vertical plane
- the steering angle
  - the angle the front wheel makes with the plane of the bike
<br /> ![stability](https://www.real-world-physics-problems.com/images/bicycle_physics_2.png "Stability") <br />

### Controling the player
Controlling the player is still under development.
*here are some ideas*:
- slider for maintaining a certain speed
  - higher speeds will require you to *manually* pedal the bike by smashing your keys
  - higher key smashing rate will pedal faster
- direction to mouse position will be how you determine the steering angle

### Lean angle
To have a way to determine how much the animation for the **leaning** of the bike and how bikes would fall over when turning a corner too hard, determining the lean angle is needed:
<br /> ![lean angle](https://www.real-world-physics-problems.com/images/bicycle_physics_6.png "Bicycle Physics") <br /> 
- θ is the lean angle
- R is the radius of the turn measured from the center of mass G of the bike-rider system
- a_c is the centripetal acceleration of the center of mass G of the bike-rider system
- m is the mass of the bike-rider system
- g is the acceleration due to gravity, on earth, which is 9.8 m/s^2
- L is the distance from point G to the effective contact point P between bicycle and ground
- N is the normal force between bicycle and ground
- F is the friction force between bicycle and ground, in the direction of a_c
The equation for the lean angle: <br />![equation](https://www.real-world-physics-problems.com/images/bicycle_physics_10.png)<br />


### Power
We need to have a method of how much energy is required for the player to turn the bike pedals.
- Force is determined by
<br /> ![equation](https://www.real-world-physics-problems.com/images/bicycle_physics_18.png) <br />
- Power is determined by 
<br /> ![equation](https://www.real-world-physics-problems.com/images/bicycle_physics_19.png) <br />


## Development Board

### Start Menu
- [ ] Mode Switcher(race against AI or multiplayer)
- [ ] Map/Level Selector

### Gameplay
- [x] Countdown timer to start the race
- [x] A way to pause the game
- [ ] A winning game state after # of laps
- [ ] Implement way to save/load the game
- [ ] Create a track in reference to Towson's roads or paths through the campus[^map]
- [ ] [Create AI that follows context based steering](http://kidscancode.org/godot_recipes/ai/context_map/ "Context Based Steering")
- [ ] Create controls and game logic that can immitate a tour-de-france type game[^tourdefrance-gameplay]
- [ ] Implement multiplayer (decision: peer-to-peer or server-client)

[^map]: Realistic top down view of roads and paths that might look like Towson's campus from a birds-eye view in pixel art.  

### Sound
- [x] Some music for the game. Can be used for the start screen or anything else (**undecided**). *Credit to IcySoap for music*
- [ ] General sound effects

### Visuals
- [ ] Artwork / Animation for player states (moving, idle, turning (accurate leaning)
- [ ] Obstacles (i.e. traffic cones, moving pedestrians, potholes)
- [ ] Add tileable roads and pathways for map creation
- [ ] Dynamic stamina bar

### Misc
- [ ] Contributor.md file (for contributor credit)
- [ ] Create project game design document and integrate it with github.
- [ ] Create theme for UI
