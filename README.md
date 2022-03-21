# Tour-de-Towson

Tour-de-Towson is my take on the Tour de France in a top-down 2-D Pixel art game. The game will simulate the modern rules of the Tour De France competition, with the twist of being set in the state of Maryland. Players will need to use real-world tactics used in the tour in order to come out on top.
----
## Goals
- Create the racing mechanic
  - A map with a player and AI's racing each other for the best time.
- Have a consistent, simple, but visually appealing artwork, style, and animation
  - pixel art for bike
  - animation for pedaling
  - animation for [pedaling with effort](https://youtu.be/bJfLTzZswz0?t=393)
  - modular road system
    - straight roads
    - curved roads
    - sharp cornered roads
    - non-pavement roads
  - different types of roads that reflect different coefficient's of friction
- Plan and create an elegant UI theme
- Implement real bike physics
- Implement Tour De France scoring system
- Implement graphics for drafting, where [breakaways](https://www.youtube.com/watch?v=su0KtKDQyqE) are key in order to win
---

# Implementation
- create a system for handling how much energy a biker is exerting
  - this is the game mechanic that makes the tour competitive.
- Convert racing *car* physics into a racing *bike* physics
## Bike Stability
When analyzing bicycle stability, the game will use two parameters of the bike.
- the lean angle
  - left and right angle the bike **frame** makes with a vertical plane
- the steering angle
  - the angle the front wheel makes with the plane of the bike
<br /> ![stability](https://www.real-world-physics-problems.com/images/bicycle_physics_2.png "Stability") <br />

## Controlling the player
Controlling the player is still under development.
*here are some ideas*:
- slider for maintaining a certain speed
  - higher speeds will require you to *manually* pedal the bike by smashing your keys
  - higher key smashing rate will pedal faster
- direction to mouse position will be how you determine the steering angle
## Physics
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
[*source*](https://www.real-world-physics-problems.com/bicycle-physics.html)

----
# The Tour de France
The Tour de France, running since 1903, is one of the most difficult and impressive road-bike races throughout the year. It takes the competitors through 21 stages of the French country-side. Here is some useful information compiled from this [YouTube video](https://www.youtube.com/watch?v=5RH3LELmEWE "The Tour De France Explained | The stages, riders, and teams (2021)"):
## The modern Tour De France
- 23 days
  - 21 stages
  - each stage has around 5-6 hours of travel time
  - 2 rest days
    - typically in the first and second weekend of racing
- around 3500 km or 2000 mi in length
- top riders are so competitively close, the tour can finish within a matter of minutes or even seconds
  - last few stages extremely important
## Stage Categories:
### flat stages
- typically used as *transition* stages used to move between the different mountain ranges and other obstacles
- typical tours will see 6-10 flat stages
- very flat and even profile, small amounts of elevation

### hilly stages
- located near the foot hills of larger mountains, or small mountain ranges in france
- typical tours will see 3-4 flat stages
- prefer "classics" riders, riders that can both climb small mountains and sprint

### mountain stages
- most famous
- 6-8 times per race
- most difficult, challenging, and important stages
- between 3000-6000 m of climbing elevation gain
- located in the alps
- most influential, only the best climbers can contest for stage win
### ITTs (individual time trial stages)
- some of the most important
- demanding short courses
- can occur 1 to 3 times per tour
- rider must rely on their own skills against the clock
- ITTs vary between 10-40 km
- some are extremely flat, some are hilly, sometimes there are mountain climbs
### team time trial stages
- similar format to ITTs
- each team is a group of 8 riders under one sponsor
- time stops after the first four riders cross finish line
- not as common as other types of stages, i.e. haven't been featured in the tour since 2019
### Prizes
#### Maillot Jaune (yellow jersey)
worn by the race leader, has the least cumulative time throughout all the stages that has been contested so far
  - winner of the Maillot Jaune is the winner of the tour
#### the Green jersey
  - typically sprinters wear this one
#### the Polka-dot jersey
  - top rider in the mountains
#### the white jersey
  - similar to yellow jersey, uses cumulative time
  - only for young riders under age 25

