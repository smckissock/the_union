using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Pipeline {

    public class Pipeline {

        private App app;

        public List<Step> Steps;

        public Pipeline(App app) {
            this.app = app;
        }

        // Create date range for pipeline and run it
        public void StartPipelineSteps() {
            
            Steps = new List<Step>();

            Steps.Add(new Step("010 Run MediaCloud batches", "Using MediaCloudBatches where Runtime is NULL, run on them on MediaCloud, and insert MediaCloudStories",
                "010_make_media_cloud_batch.py"));

            //Steps.Add(new Step("020 Make Diffbot batches from MediaCloud stories", "",
            //    "020_make_diffbot_batches_from_media_cloud_stories.py"));

           // Steps.Add(new Step("030 Run MediaCloud stories on diffbot", "",
           //     "030_run_media_cloud_stories_on_diffbot.py"));

       //     Steps.Add(new Step("040 Download MediaCloud stories from diffbot", "",
         //        "040_download_media_cloud_stories_from_diffbot.py"));

       // Steps.Add(new Step("070 Run Newspaper for missing DiffBot", "",
        //   "070_run_newspaper_for_missing_diffbot.py"));

       //  Steps.Add(new Step("080 Download Diffbot terms", "",
        //     "080_add_entities.py"));

      // Steps.Add(new Step("090 Run Newspaper", "",
      //    "090_run_newspaper.py"));
            
      //    Steps.Add(new Step("100 Run Sentences", "",
      //     "100_run_sentences.py"));


            // Run stored procedures to import entities now!! 

            //Steps.Add(new Step("GetPublications", "Using MediaCloudBatches where Runtime is NULL, run on them on MediaCloud, and insert MediaCloudStories",
            //    "GetPublications.py"));

            foreach (Step step in Steps)
                step.Run();
        }
    }
}
