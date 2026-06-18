# THE NETHER STAR

The N.E.T.H.E.R S.T.A.R, which stands for:<br>
**N**etwork of<br>
**E**xploring<br>
**T**rans-craft<br>
**H**elmed by the<br>
**E**ngine of<br>
**R**eactive-choice<br>
for the
**S**elf-governing<br>
**T**hruster-driven<br>
**A**erial<br>
**R**ace-craft<br>
is a Computer-Craft and Valkyerian Skies driven set of craft with the goal of reaching the Minecraft Nether world border _through_ the terrain.

It is composed of the main craft, the "**_star_**" as per the acronym, which is carrying the player and power equipment.
It is also composed of drones which use LIDAR technology to scan and map a path through the environment and manipulate terrain.

The Nether Star is planned for a **_30,000,000_** block journey (**_200 hours~_**) to the world border, this is a lot of time for edge cases and things to go wrong. Because of the potential for failure this code base has strict coding guidelines to ensure stability.

# YOUTUBE

The whole series is recorded on YouTube!
[First episode](https://www.youtube.com/watch?v=XKLAW1AcXmE&t=204s)

## PROGRAMMING REQUIREMENTS

- The Kernel must not reference any other module except for the Flight Management System. No exceptions.
- Programmed in TypeScript, compiled to lua with strict types enabled.
- No usage of the "as" operator (except for external libraries, more below).
- While making a logical branch, you must thoroughly consider all pathways
- You must explicitly type every single function or variable. No exceptions.
- No heterogeneous arrays or tables
- No circumstances should the "any" type be used unless referring to external libraries where the type cannot be known
  - In such a case it is absolutely imperative to make a container for the object associated with a type so it cannot cause issues
  - As consequence, reduce use of external libraries to absolute minimum
- No recursion at all
- Nesting limited to 2 except for one-liners (like errors or returns)
- The only time you can declare an object with more then one type is with null. Ex: `const mag : number|null = vector.Magnitude();` and the variable can only be used once the null is verified to be logical impossible.
- AI can only help conceptually and cannot write any code

### PRIORITY REQUIREMENTS

- Each system must undergo "symbiotic stabilization". Basically, Have a contract with at least one non-flight system (Like the Flight Management System or the Crisis Management System) to cross-check and maintain eachothers stability.
  - The FMS and CMS do this symbiotic stabilization with eachother, if one fails the other catches it.
- Each craft has the main requirement of maintaining its own orientation and stability. This is aviation. It must not spin out of control and crash. This is the priority.
- When that is fulfilled the craft's next directive is navigation, whether following waypoints or using the advanced pathfinding system with the lidar scanners.
- The third priority is communication. Communicate your safety or your results to other craft.
- The fourth priority is anything else, which is usually nothing.

_A computer which needs to significantly do something else should be both physically, mentally, and programmatically separated from this stack. For example, the main orchestrator onboard the Nether Star and the display computer displaying information are separate from the flight computer, only communicating via the Cross Craft Communication System._
