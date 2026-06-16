import { LUA__log, LUA__SLEEP } from "../declaration/lstd";

export class lstd {
    static Log(message : string): void {
        LUA__log(message);
    }
    static Sleep(time : number): void {
        LUA__SLEEP(time);
    }
}