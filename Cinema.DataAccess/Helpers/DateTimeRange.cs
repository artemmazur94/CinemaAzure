using System;

namespace Cinema.DataAccess.Helpers
{
    public class DateTimeRange
    {
        public DateTime Start { get; set; }

        public DateTime End { get; set; }

        public bool Intersects(DateTimeRange test)
        {
            if (Start == End || test.Start == test.End)
            {
                return false;
            }
            if (Start == test.Start || End == test.End)
            {
                return true;
            }
            if (Start < test.Start)
            {
                if (End > test.Start && End < test.End)
                {
                    return true;
                }
                if (End > test.End)
                {
                    return true;
                }
            }
            else
            {
                if (test.End > Start && test.End < End)
                {
                    return true;
                }
                if (test.End > End)
                {
                    return true;
                }
            }
            return false;
        }
    }
}
