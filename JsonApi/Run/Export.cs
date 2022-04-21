using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Newtonsoft.Json;
using Util;

namespace NewsSearch {
    

    public class story {
        public int id;
        public int mediaId;
        public string date;
        public string sentence;
        public string author;
        public string title;
        //public List<int> links;
    }

    public class StoryDetails {
        public int id;
        public int mediaId;
        public string date;
        //public List<int> links; // Not used?  Already in story....

        public string headline;
        public string image;
        public string link;
        public string mediaOutlet;
        public int biasRatingId;
        public int wordCount;
        public string author;
        public string authorUrl;
        public List<int> termIds;
        public List<string> sentences;
    }

    public class media {
        public int id;
        public string name;
        public string bias;
    }
    
    public class Dimensions {
        public string appName;
        public string appSlug;
        public int featureId;

        public List<term> terms;
        public List<media> media;
        public List<Event> events;

        public Dimensions(string appName, string appSlug) {
            this.appName = appName;
            this.appSlug = appSlug;
        } 
    }

    

    public enum Sentences { MakeSentenceFiles, DontMakeSentenceFiles };
        

    public class Export {

        private static Dictionary<string, List<string>> sentencesDict; 

        private static bool headerPrinted = false;

        private static string appName;
        private static string appSlug;
        private static string appId;

        private static List<string> storyIdsForApp;


        public static void MakeJson(string rootPath, Sentences sentences, string slug) {
            MakeNewsSearchJson(rootPath, slug, Sentences.MakeSentenceFiles);
        }


        public static void MakeNewsSearchJson(string rootPath, string appSlug, Sentences sentences ) {
            Export.appSlug = appSlug;

            app.MakeApps(rootPath);

            var reader = SqlUtil.Query("SELECT ID, Name, ShortName FROM App WHERE ShortName = '" + appSlug + "'");
            reader.Read();
            appName = reader["Name"].ToString();
            appId = reader["ID"].ToString();


            sentencesDict = GetSentences();

            MakeStoryIdsForApp();

            var path = rootPath + Export.appSlug + "\\";

            // 1 Dimensions
            var dimensions = new Dimensions(appName, appSlug);
            dimensions.terms = term.MakeTerms(appName, appId);
            dimensions.media = MakeMedia();
            dimensions.events = Event.MakeEvents(appId);

            dimensions.featureId = SqlUtil.Int("SELECT DiffBotStoryID FROM FeatureView WHERE App = '" + appSlug + "' ORDER BY DATE DESC");
            
            string json = JsonConvert.SerializeObject(dimensions);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            System.IO.Directory.CreateDirectory(path);
            System.IO.File.WriteAllText(path + "dimensions.json", niceJson);
            
            // 2 Single file for each Term, with a list of stories
            term.MakeTermFiles(path, appId, appSlug, sentencesDict);
            
            // 3 Single file for each story
            if (sentences == Sentences.MakeSentenceFiles) {
                var stories = MakeStoryDetails(path);
                MakeStoryFiles(stories, path + "story\\");
            }
            
            Console.WriteLine(AppSummary(rootPath, appSlug, appName));
        }


        // Say what's on the disc for the app
        private static string AppSummary(string rootPath, string slug, string appName) {
            if (!headerPrinted) {
                Console.WriteLine("".PadRight(52) + "               Term    Story   Term     Story");
                Console.WriteLine("".PadRight(52) + " Media  Term   Files   Count   Stories  Files");
                headerPrinted = true;
            }

            string dimensions = System.IO.File.ReadAllText(rootPath + slug + "\\dimensions.json");
            var dims = JsonConvert.DeserializeObject<Dimensions>(dimensions);

            var mediaCount = dims.media.Count.ToString();
            var termCount = dims.terms.Count.ToString();
            var termFiles = System.IO.Directory.GetFiles(rootPath + slug + "\\terms").Length.ToString();

            // The count of stories for the term for the app
            var appStoryCount = dims.terms.Find(x => x.name == appName).stories.ToString();

            string appTermFile = System.IO.File.ReadAllText(rootPath + slug + "\\terms\\" + slug + ".json");
            var stories = JsonConvert.DeserializeObject<List<story>>(appTermFile).Count.ToString();

            var storyFiles = System.IO.Directory.GetFiles(rootPath + slug + "\\story").Length.ToString();
            
            string text = "Made files for " + appSlug.PadRight(36) + 
                mediaCount.PadLeft(7) + " " + termCount.PadLeft(5) + "    " + termFiles.PadLeft(4) + appStoryCount.PadLeft(8) + stories.PadLeft(8) + storyFiles.PadLeft(8);

            return text;
        }

                
        private static void MakeStoryIdsForApp() {
            storyIdsForApp = new List<string>();
            var reader = SqlUtil.Query("SELECT ID FROM StoryForAppView WHERE Slug = '" + appSlug + "'");
            while (reader.Read()) {
                storyIdsForApp.Add(reader["ID"].ToString());
            }
        }


        private static List<media> MakeMedia() {
            var medias = new List<media>();
            var reader = SqlUtil.Query("SELECT ID, Name, BiasRating FROM MediaOutletView ORDER BY Sort, Name");
            while (reader.Read()) {
                var media = new media();
                media.id = (Int32)reader["ID"];
                media.name = reader["Name"].ToString();
                media.bias = reader["BiasRating"].ToString();
                medias.Add(media);
            }
            reader.Close();
            return medias;
        }
                        

        private static List<StoryDetails> MakeStoryDetails(string path) {
            FileUtil.ClearDirectory(path + "story\\");

            //var where = " WHERE s.ID IN (SELECT DISTINCT StoryID FROM StoryForTermView WHERE AppID = " + appId + ") ";
            var where = " WHERE s.ID IN (SELECT DISTINCT ID FROM StoryForAppView WHERE AppID = " + appId + ") ";

            // This includes linked stories
            //var where = " WHERE s.ID IN (SELECT DISTINCT StoryID FROM AllStoriesForTermView) ";

            //var sentencesDict = GetSentences(where);
            var termIdDict = GetTermIds(where);

            var stories = new List<StoryDetails>();
            //var reader = SqlUtil.Query("SELECT * FROM StoryDetailsView");

            //var reader = SqlUtil.Query("SELECT * FROM StoryDetails2View WHERE ID IN (SELECT DISTINCT ID FROM StoryForAppView WHERE AppID = " + appId + ")");
            var reader = SqlUtil.Query("SELECT * FROM StoryDetails2View WHERE ID IN (SELECT DISTINCT ID FROM AppStoryView WHERE AppID = " + appId + ")");
            while (reader.Read()) {

                var storyId = reader["StoryID"].ToString();

                var story = new StoryDetails();
                story.id = Convert.ToInt32(storyId);
                story.headline = reader["Title"].ToString();
                story.image = reader["Image"].ToString();
                story.link = reader["Link"].ToString();
                story.mediaId = Convert.ToInt32(reader["MediaId"].ToString());
                story.mediaOutlet = reader["MediaOutlet"].ToString();
                story.biasRatingId = Convert.ToInt32(reader["BiasRatingID"]);

                story.author = reader["Author"].ToString();
                story.authorUrl = reader["AuthorUrl"].ToString();
                //story.wordCount = Convert.ToInt32(reader["WordCount"]);

                story.date = reader["Date"].ToString();

                // This should not happen - need to fix
                try {
                    story.sentences = sentencesDict[storyId];
                } catch (Exception) {
                    story.sentences = new List<string>();
                }

                // also should not happen...
                try {
                    story.termIds = termIdDict[storyId];
                }
                catch (Exception) {
                    story.termIds = new List<int>();
                }

                stories.Add(story);
            }
            reader.Close();
            return stories;
        }
        
        private static void MakeStoryFiles(List<StoryDetails> stories, string path) {
            FileUtil.ClearDirectory(path); 
            foreach (StoryDetails story in stories) {
                string json = JsonConvert.SerializeObject(story);
                var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
                FileUtil.WriteFile(path + story.id.ToString() + ".json", niceJson);
            }
        }
        

        // NOT USED
        //private static Dictionary<int, List<int>> GetLinkDict() {
        //    var dict = new Dictionary<int, List<int>>();

        //    int fromId = 0;
        //    List<int> toList = new List<int>(); 
        //    var reader = SqlUtil.Query("SELECT FromID, ToId FROM DiffBotLink ORDER BY FromId");
        //    while (reader.Read()) {
        //        if (fromId != (Int32)reader["FromId"]) {
        //            if (fromId != 0)
        //                dict.Add(fromId, toList);

        //            toList = new List<int>();
        //            fromId = (Int32)reader["FromID"];
        //        }
        //        toList.Add((Int32)reader["ToID"]);
        //    }
        //    dict.Add(fromId, toList);
        //    return dict;
        //}


        //private static Dictionary<string, List<string>> GetSentences(string where) {
        private static Dictionary<string, List<string>> GetSentences() {
                var dict = new Dictionary<string, List<string>>();
            string storyId = "";
            List<string> sentences = null;
            var reader = SqlUtil.Query(
                "SELECT s.ID StoryID, ISNULL(sen.Text, '') Text " +   
                "FROM StoryView s " +
                "LEFT JOIN Sentence sen ON s.ID = sen.DiffBotStoryID " +
                //where +
                "ORDER BY s.ID, LEN(sen.Text) DESC");
            while (reader.Read()) {
                string newId = reader["StoryID"].ToString();
                if (newId != storyId) {
                    sentences = new List<string>();
                    storyId = newId;
                    dict.Add(storyId, sentences);
                }
                sentences.Add(reader["Text"].ToString());
            }
            reader.Close();
            return dict;
        }

        private static Dictionary<string, List<int>> GetTermIds(string where) {
            var dict = new Dictionary<string, List<int>>();
            string storyId = "";
            List<int> terms = null;
            var reader = SqlUtil.Query(
                "SELECT s.ID, ISNULL(EntityID, 0) EntityID " +
                "FROM StoryView s " +
                "LEFT JOIN StoryEntity se ON s.ID = se.StoryID " +
                "LEFT JOIN EntityView e ON se.EntityID = e.ID " +
                where +
                " ORDER BY ID, TypeSort");

            while (reader.Read()) {
                string newId = reader["ID"].ToString();
                if (newId != storyId) {
                    terms = new List<int>();
                    storyId = newId;
                    dict.Add(storyId, terms);
                }
                terms.Add((int)reader["EntityID"]);
            }
            reader.Close();
            return dict;
        }
    }
}
