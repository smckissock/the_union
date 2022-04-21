using System.Collections.Generic;
using Util;
using Newtonsoft.Json;


namespace NewsSearch {

    public class app {
        public string name;
        public string slug;

        public static void MakeApps(string rootPath) {
            var apps = new List<app>();
            var reader = SqlUtil.Query("SELECT Name, ShortName FROM App ORDER BY ID");
            while (reader.Read()) {
                var app = new app();
                app.name = reader["Name"].ToString();
                app.slug = reader["ShortName"].ToString();
                apps.Add(app);
            }
            string json = JsonConvert.SerializeObject(apps);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            System.IO.File.WriteAllText(rootPath + "apps.json", niceJson);
        }
    }
}
