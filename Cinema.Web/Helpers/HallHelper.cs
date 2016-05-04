using System.Collections.Generic;
using Cinema.DataAccess;

namespace Cinema.Web.Helpers
{
    public static class HallHelper
    {
        public static Dictionary<int, Dictionary<int, int>> CreateHallPlan(List<Sector> sectors)
        {
            var hallPlan = new Dictionary<int, Dictionary<int, int>>();
            foreach (Sector sector in sectors)
            {
                for (int i = sector.FromRow; i <= sector.ToRow; i++)
                {
                    if (!hallPlan.ContainsKey(i))
                    {
                        hallPlan.Add(i, new Dictionary<int, int>());
                    }
                    for (int j = sector.FromPlace; j <= sector.ToPlace; j++)
                    {
                        hallPlan[i].Add(j, sector.SeatTypeId);
                    }
                }
            }
            return hallPlan;
        }
    }
}