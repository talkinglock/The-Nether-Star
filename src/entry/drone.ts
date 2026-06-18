// Entry point for the drone. Loads configuration and starts the flight computer
// Imports:
import { PIDControllerVector } from "../../thirdparty/tswrappers/pidcontroller";
import { Configuration } from "../classes/Configuration";
import { FlightManagementSystem } from "../classes/MainSystems/FlightManagementSystem";
import { Quaternion } from "../classes/Math/Quaternion";
import { Vector3 } from "../classes/Math/Vector3";
import { Thruster } from "../classes/Thruster";

const config: Configuration = {
  SASRotationLoop: { P: 0.3, I: 0, D: 0, Min: -1, Max: 1 },
  SASTranslationLoop: { P: 0.2, I: 0.01, D: 0, Min: -1, Max: 1 },
  SASPIDRestrustsBeforeReattemptingPID: 10,
  SASPIDTotalRetrustsBeforeStoppingPIDAttempts: 5,
  SASBackupQuaternion: Quaternion.fromAxisAngles(new Vector3(0, 1, 0), Math.PI),
  SASManualRotationMultiplier: 0.5,
  SASManualTranslationMultiplier: 0.5,

  MaximumForwardSpeed: 30,
  MinimumThrusterRotationAuthority: 0.2,
  RCSFailMajorityMultiplier: 0.5,
  RCSFailMinorityMultiplier: 0.5,
  tickRate: 0.05,
  Thrusters: [
    new Thruster(
      "redstone_relay_2",
      "top",
      new Vector3(-1, 1, -1),
      new Vector3(0, -1, 0)
    ),
    new Thruster(
      "redstone_relay_5",
      "top",
      new Vector3(1, 1, -1),
      new Vector3(0, -1, 0)
    ),
    new Thruster(
      "redstone_relay_12",
      "top",
      new Vector3(-1, 1, 1),
      new Vector3(0, -1, 0)
    ),
    new Thruster(
      "redstone_relay_3",
      "top",
      new Vector3(1, 1, 1),
      new Vector3(0, -1, 0)
    ),

    new Thruster(
      "redstone_relay_6",
      "bottom",
      new Vector3(-1, -1, -1),
      new Vector3(0, 1, 0)
    ),
    new Thruster(
      "redstone_relay_7",
      "bottom",
      new Vector3(1, -1, -1),
      new Vector3(0, 1, 0)
    ),
    new Thruster(
      "redstone_relay_11",
      "bottom",
      new Vector3(-1, -1, 1),
      new Vector3(0, 1, 0)
    ),
    new Thruster(
      "redstone_relay_10",
      "bottom",
      new Vector3(1, -1, 1),
      new Vector3(0, 1, 0)
    ),

    new Thruster(
      "redstone_relay_2",
      "back",
      new Vector3(-1, 1, -1),
      new Vector3(0, 0, 1)
    ),
    new Thruster(
      "redstone_relay_5",
      "back",
      new Vector3(1, 1, -1),
      new Vector3(0, 0, 1)
    ),
    new Thruster(
      "redstone_relay_6",
      "back",
      new Vector3(-1, -1, -1),
      new Vector3(0, 0, 1)
    ),
    new Thruster(
      "redstone_relay_7",
      "back",
      new Vector3(1, -1, -1),
      new Vector3(0, 0, 1)
    ),

    new Thruster(
      "redstone_relay_12",
      "right",
      new Vector3(-1, 1, 1),
      new Vector3(0, 0, -1)
    ),
    new Thruster(
      "redstone_relay_3",
      "back",
      new Vector3(1, 1, 1),
      new Vector3(0, 0, -1)
    ),
    new Thruster(
      "redstone_relay_11",
      "right",
      new Vector3(-1, -1, 1),
      new Vector3(0, 0, -1)
    ),
    new Thruster(
      "redstone_relay_10",
      "back",
      new Vector3(1, -1, 1),
      new Vector3(0, 0, -1)
    ),

    new Thruster(
      "redstone_relay_5",
      "left",
      new Vector3(1, 1, -1),
      new Vector3(-1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_3",
      "right",
      new Vector3(1, 1, 1),
      new Vector3(-1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_7",
      "left",
      new Vector3(1, -1, -1),
      new Vector3(-1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_10",
      "right",
      new Vector3(1, -1, 1),
      new Vector3(-1, 0, 0)
    ),

    new Thruster(
      "redstone_relay_12",
      "back",
      new Vector3(-1, 1, 1),
      new Vector3(1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_2",
      "right",
      new Vector3(-1, 1, -1),
      new Vector3(1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_11",
      "back",
      new Vector3(-1, -1, 1),
      new Vector3(1, 0, 0)
    ),
    new Thruster(
      "redstone_relay_6",
      "right",
      new Vector3(-1, -1, -1),
      new Vector3(1, 0, 0)
    ),
  ],
};

let fms: FlightManagementSystem = new FlightManagementSystem(config);

fms.Bootstrap();
