using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;

using Util;

namespace Pipeline {
    
    public class Step {

        //private string pythonPath = @"C:\news-search\pipeline\python\";
        //private string pythonPath = @"C:\project\news-search\pipeline\python\";
        private string pythonPath = @"C:\project\lincoln-project-press\Pipeline\python\";

        public string Name;
        public string Description;
        public string PythonScriptName;
        public DateTime StartTime;

        public Process Process;

        public DateTime EndTime;

        public int Completed;
        public int Remaining;

        public bool Running;

        public Step(string name, string description, string pythonScriptName) {
            Name = name;
            Description = description;
            PythonScriptName = pythonScriptName;

            StartTime = System.DateTime.Now;
        }

        public string Status() {
            if (this.Process == null)
                return Name + " not started";

            var running = this.Process.HasExited ? "completed" : "running";
            return Name + " " + running;
        }

        // Maybe return some kind of Success or Failure?
        public virtual void Run() {
            Process = Python.RunNonBlocking(pythonPath + PythonScriptName, "");
        }    
    }
} 