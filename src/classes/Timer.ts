import { Time } from "./Time";

export class Timer
{
    private StartTime : number;
    private EndTime : number;
    private time : Time;
    constructor(TimeUntilEndSeconds : number, time : Time)
    {
        this.StartTime = time.GetTimeSeconds();
        this.EndTime = this.StartTime + TimeUntilEndSeconds;
        this.time = time;
    }

    public IsFinished(): boolean
    {
        if (this.time.GetTimeSeconds() > this.EndTime)
        {
            return true;
        }
        return false;
    }
}