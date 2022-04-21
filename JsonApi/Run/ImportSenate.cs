using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

using Util;

namespace NewsSearch {

    public class ImportSenate {

        public static string Run(string path) {
            var myPath = @"C:\news-search\doc\Senate 3 9 2019.csv";

            var csvRows = System.IO.File.ReadAllLines(myPath, Encoding.Default).ToList();

            //            member_full last_name   first_name party   state address phone email   website class bioguide_id leadership_position last_updated
            //            0           1           2           3       4       5    6      7       8       9       10          11

            //            ID
            //FirstName
            //LastName
            //Party
            //State
            //Address
            //Phone
            //Email
            //Website
            //ClasS
            //BioGuideID
            //LeaderShipPosition

            SqlUtil.Command("DELETE FROM Senate");
            foreach (var row in csvRows.Skip(1)) {
                var columns = row.Split(',');

                //var field1 = columns[0]; Prefix, "The Honorable"
                var firstName = columns[2];
                var lastName = columns[1];
                var party = columns[3];
                var state = columns[4];
                var address = columns[5];
                var Phone = columns[6];
                var Email = columns[7];
                var Website = columns[8];
                var Class = columns[9];
                var bioGuideId = columns[10];
                string LeadershipPosition = columns[11];

                var fields = "";
                //for (int i = 1; i < 12; i++) {
                    fields += "'";
                    fields += firstName.Replace("'", "''") + "', '";
                    fields += lastName.Replace("'", "''") + "', '";
                    fields += party.Replace("'", "''") + "', '";
                    fields += state.Replace("'", "''") + "', '";
                    fields += address.Replace("'", "''") + "', '";
                    fields += Phone.Replace("'", "''") + "', '";
                    fields += Email.Replace("'", "''") + "', '";
                    fields += Website.Replace("'", "''") + "', '";
                    fields += Class.Replace("'", "''") + "', '";
                    fields += bioGuideId.Replace("'", "''") + "', '";
                    fields += LeadershipPosition.Replace("'", "''") + "'";
                //}

                SqlUtil.Command("INSERT INTO Senate VALUES (" + fields + ")");
            }
            return "Success " + csvRows.Count.ToString() + " members";
        }
    }
}