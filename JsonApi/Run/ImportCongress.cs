using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using System.IO;

namespace Util {

    public class ImportCongress {

        public static string Run(string path) {
            var myPath = @"C:\news-search\doc\Congress 3 9 2019.csv";

            var csvRows = System.IO.File.ReadAllLines(myPath, Encoding.Default).ToList();

            //FirstName MiddleName  LastName Suffix  Address City    State Zip+4   St / Dis  BioguideID Party


            SqlUtil.Command("DELETE FROM Congress");
            foreach (var row in csvRows.Skip(1)) {
                var columns = row.Split(',');

                //var field1 = columns[0]; Prefix, "The Honorable"
                var firstName = columns[1];
                var middleName = columns[2];
                var lastName = columns[3];
                var suffix = columns[4];
                var address = columns[5];
                var city = columns[6];
                var state = columns[7];
                var zip = columns[8];
                var stateDistrict = columns[9];
                var bioGuideId = columns[10];
                var party = columns[11];

                var fields = "";
                for (int i = 1; i < 12; i++) {
                    fields += "'";
                    fields += columns[i].Replace("'", "''");
                    fields += "', ";
                }
                fields += "'House'";

                SqlUtil.Command("INSERT INTO Congress VALUES (" + fields + ")");
            }
            return "Success " + csvRows.Count.ToString() + " members";
        }
    }
}
