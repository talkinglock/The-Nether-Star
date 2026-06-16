# THE NETHER STAR
The N.E.T.H.E.R S.T.A.R, which stands for:
**N**etwork of
**E**xploring
**T**rans-craft
**H**elmed by the
**E**ngine of
**R**eactive-choice
for the
**S**elf-governing
**T**hruster-driven
**A**erial
**R**ace-craft
is a Computer-Craft and Valkyerian Skies driven set of craft with the goal of reaching the Minecraft Nether world border *through* the terrain.

It is composed of the main craft, the "***star***" as per the acronym, which is carrying the player and power equipment.
It is also composed of drones which use LIDAR technology to scan and map a path through the environment and manipulate terrain.

The Nether Star is planned for a  ***30,000,000*** block journey (***200 hours~***) to the world border, this is a lot of time for edge cases and things to go wrong. Because of the potential for failure this code base has strict coding guidelines to ensure stability.


# YOUTUBE
The whole series is recorded on YouTube!
[First episode](https://www.youtube.com/watch?v=XKLAW1AcXmE&t=204s)

## PROGRAMMING REQUIREMENTS

- Programmed in TypeScript, compiled to lua with strict types enabled.
- No usage of the "as" operator (except for external libraries, more below).
- For every logical branch there must be a contingency for the opposite or no path chosen.
- Must explicitly type every single function and variable. No exceptions.
- No heterogeneous arrays or tables
- No circumstances should the "any" type be used unless referring to external libraries where the type cannot be known
- - In such a case it is absolutely imperative to make a container for the object associated with a type so it cannot cause issues
- - As consequence, reduce use of external libraries to absolute minimum
- Avoid creating short-lived objects inside loops. Define outside the loop and assign inside.
- No recursion at all
- Nesting limited to 2 except for one-liners (like errors or returns)
- The only time you can declare an object with more then one possible type is with null. Ex: ```const mag : number|null = vector.Magnitude();``` and the variable can only be used once the null is verified to be logical impossible.
- AI can only help conceptually and cannot write any code 

### PRIORITY REQUIREMENTS
- Each craft has the main requirement of maintaining its own orientation and stability. This is aviation. It must not spin out of control and crash. This is the priority.
- When that is fulfilled the craft's next directive is navigation, whether following waypoints or using the advanced pathfinding system with the lidar scanners.
- The third priority is communication. Communicate your safety or your results to other craft.
- The fourth priority is anything else, which is usually nothing.

*A computer which needs to significantly do something else should be both physically, mentally, and programmatically separated from this stack. For example, the main orchestrator onboard the Nether Star and the display computer displaying information are separate from the flight computer, only communicating via the Cross Craft Communication System.*
