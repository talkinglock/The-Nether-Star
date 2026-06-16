export class Time {
    public TickRate : number;
    public CurrentTick : number = 0;

    constructor(tickRate : number)
    {
        this.TickRate = tickRate;
    }

    public GetTimeSeconds() : number
    {
        const ticksPerSecond : number = 1/this.TickRate;
        return this.CurrentTick / ticksPerSecond;
    }

    public Tick()
    {
        this.CurrentTick++;
    }
}