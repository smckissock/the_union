using System;
using System.Collections.Generic;

using Util;

namespace Pipeline {

    public class App {

        public string ShortName;
        public string StartDate = "2019-11-01";

        public List<MediaCloudCollection> MediaCloudCollections;

        public Pipeline Pipeline;

        public App() {
        }

        
        public void RunPipeline() {
            Pipeline = new Pipeline(this);
            Pipeline.StartPipelineSteps();
        }

        private void AddMediaCloudBatchRecords() {
            // For each app/term/media collection, return a record with null for run date if it has never been, otherwise last run date 
            var reader = SqlUtil.Query("SELECT * FROM MakeMediaCloudBatchView WHERE AppShortName = '" + this.ShortName + "'");
            while (reader.Read()) {
                var term = reader["Term"].ToString();
                var mediaCloudCollectionId = reader["MediaCloudCollectionID"].ToString();
                var termId = reader["TermID"].ToString();

                var neverRun = reader.IsDBNull(reader.GetOrdinal("LastRun"));

                // Case 1 - never run
                if (neverRun) {
                    InsertMediaCloudBatch(term, mediaCloudCollectionId, termId, this.StartDate);
                    continue;
                }

                // Case 2 - run with end date before today
                var lastRun = ((DateTime)reader["LastRun"]).ToString("yyyy-MM-dd");
                var today = DateTime.Now.ToString("yyyy-MM-dd");
                if (String.Compare(lastRun, today) < 0) {
                    InsertMediaCloudBatch(term, mediaCloudCollectionId, termId, lastRun);
                    continue;
                }

                // Case 3 - it was already run with an today (or a future day!) so do nothing
            }
        }

        private void InsertMediaCloudBatch(string term, string mediaCloudCollectionId, string termId, string startDate) {
            var today = DateTime.Now.ToString("yyyy-MM-dd");
            SqlUtil.Command("INSERT INTO MediaCloudBatch VALUES('" +
                term + "', '" + startDate + "', '" + today + "', NULL, " + mediaCloudCollectionId + ", " + termId + ")");
        }
    }
}
