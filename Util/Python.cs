using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Util {

    public class Python {

        //C:\news-search\trump-russia\python\news.py

        public static void Run(string script, string args) {
        //public static void Run(string script) {

            string python = @"C:\Users\Scott\AppData\Local\Programs\Python\Python36-32\python.exe";

            ProcessStartInfo start = new ProcessStartInfo();
            start.FileName = python;

            //start.Arguments = string.Format("{0}", cmd); 
            start.Arguments = string.Format("{0} {1}", script, args);
            start.UseShellExecute = false;
            start.RedirectStandardOutput = true;
            using (Process process = Process.Start(start)) {
                using (StreamReader reader = process.StandardOutput) {
                    string result = reader.ReadToEnd();
                    Console.Write(result);

                    Console.Write("DONE");
                    Console.Read();
                }
            }
        }


        public static Process RunNonBlocking(string script, string args) {
            //public static void Run(string script) {

            //string python = @"C:\Users\Scott\AppData\Local\Programs\Python\Python36-32\python.exe";
            string python = @"C:\Program Files (x86)\Python37-32\python.exe";

            ProcessStartInfo start = new ProcessStartInfo();
            start.FileName = python;

            //start.Arguments = string.Format("{0}", cmd); 
            start.Arguments = string.Format("{0} {1}", script, args);

            // These two lines are different from above
            start.UseShellExecute = true;
            start.RedirectStandardOutput = false;

            return Process.Start(start);
            
            //using (Process process = Process.Start(start)) {
            //    using (StreamReader reader = process.StandardOutput) {
            //        string result = reader.ReadToEnd();
            //        Console.Write(result);

            //        Console.Write("DONE");
            //        Console.Read();
            //    }
            //}
        }
    }
}
