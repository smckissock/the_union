using System.Collections.Generic;
using Util;

namespace NewsSearch {

    public class Event {
        public string name;
        public string description;
        public string type;
        public string date;


        public static List<Event> MakeEvents(string appId) {
            var events = new List<Event>();
            var reader = SqlUtil.Query("SELECT ID, Name, EventType, Description, Date FROM EventView WHERE AppID = '" + appId + "' ORDER BY Ordering, EventType, Date");
            while (reader.Read()) {
                var ev = new Event();
                //ev.id = (Int32)reader["ID"];
                ev.name = reader["Name"].ToString();
                ev.type = reader["EventType"].ToString();
                ev.description = reader["Description"].ToString();
                ev.date = reader["Date"].ToString();
                events.Add(ev);
            }
            reader.Close();
            return events;
        }
    }
}
