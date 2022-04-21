using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Pipeline {

    public class MediaCloudCollection {

        public string Name;
        public string CollectionId;

        public MediaCloudCollection (string name, string collectionId) {
            Name = name;
            CollectionId = collectionId;
        }
    }
}
