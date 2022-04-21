using System;
using Pipeline;
using Util;
using System.Data;
using System.Data.SqlClient;

namespace NewsSearch {

    class Program {
        
        static void Main(string[] args) {

            //var rdr = SqlUtil.Query("SELECT AppSlug FROM AppView  WHERE AppTypeName = 'Never Trump' OR AppTypeName = 'Senate Republicans'");
            //var rdr = SqlUtil.Query("SELECT AppSlug FROM AppView  WHERE AppTypeName = 'Person'");
            //while (rdr.Read()) {
            //    var slug = rdr[0].ToString();
            //    Export.MakeJson("c:\\project\\lincoln-project-press\\data\\", Sentences.MakeSentenceFiles, slug);
            //}
            //Console.WriteLine("Done");
            //Console.ReadKey();


            //THE REST OF THIS RUNS THE IMPORTER

            var app = new App();
            app.RunPipeline();

            while (true) {
                foreach (Step step in app.Pipeline.Steps)
                    Console.WriteLine(step.Status());
                System.Threading.Thread.Sleep(10000);
                Console.WriteLine("");
                Console.WriteLine(DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
            }
        }
    }
}