using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Pipeline {

    public class Term {

        public string Name;
        public bool Active;

        public Term(string name, bool active = true) {
            Name = name;
            Active = active;
        }
    }
}
