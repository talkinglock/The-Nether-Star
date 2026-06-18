export class Mathc {
    static Clamp(value : number, min : number, max : number)
    {
        // transcribed from PHOBOS utilities module
        // uber fast
        if (value < min)
        {
            return min;
        }
        if (value > max)
        {
            return max;
        }
        return value;
    }
    static Sign(value : number)
    {
        if (value < 0)
        {
            return - 1;
        }
        else
        {
            return 1;
        }
    }
}