using System;
using System.Collections.Generic;
using Util;
using Newtonsoft.Json;


namespace NewsSearch {

    public class term {
        public int id;
        public string name;
        public string type;
        public int stories;
        
        public static List<term> MakeTerms(string appName, string appId) {
            var terms = new List<term>();
            var reader = SqlUtil.Query(
                "SELECT ID, Type, Name, Stories FROM EntitiesWithStoriesView WHERE AppID = " + appId + " AND Name <> '" + appName +
                "' ORDER BY CASE[Type] WHEN 'Person' THEN 0 WHEN 'Organization' THEN 1 ELSE 2 END, Stories DESC");
            while (reader.Read()) {
                var term = new term();
                term.id = (Int32)reader["ID"];
                term.name = reader["Name"].ToString();
                term.type = reader["Type"].ToString();
                term.stories = (Int32)reader["Stories"];

                terms.Add(term);
            }
            reader.Close();

            // Add Term for whole app - all stories
            var appTerm = new term();
            appTerm.id = 0;
            appTerm.name = appName;
            appTerm.type = "Organization";
            appTerm.stories = SqlUtil.Int("SELECT Count(*) FROM AppStoryView WHERE AppID = " + appId);
            terms.Add(appTerm);

            return terms;
        }

        

        public static void MakeTermFiles(string path, string appId, string appSlug, Dictionary<string, List<string>> sentencesDict) {

            string term = SqlUtil.String("SELECT TermName FROM AppTermView WHERE AppID = " + appId);

            FileUtil.ClearDirectory(path + "terms\\");

            //var linkDict = GetLinkDict();

            var entityId = "0";
            var slug = "";
            var stories = new List<story>();
            var reader = SqlUtil.Query("SELECT * FROM AllStoriesForTermView WHERE AppID = " + appId +
                " AND(StoryID IN (SELECT ID FROM StoryForAppView WHERE AppID = " + appId + ")) AND Slug <> '" + appSlug + "'" +
                " ORDER BY EntityID, Date");
            while (reader.Read()) {
                if (entityId != reader["EntityID"].ToString()) {
                    if (entityId != "0")
                        FileForTerm(stories, path, slug);

                    stories.Clear();
                    entityId = reader["EntityID"].ToString();
                    slug = reader["Slug"].ToString();
                }
                var story = new story();
                story.id = (Int32)reader["StoryID"];
                story.mediaId = (Int32)reader["MediaID"];
                story.date = reader["Date"].ToString();
                story.sentence = GetSentence(sentencesDict[story.id.ToString()], term);
                story.author = reader["Author"].ToString();
                story.title = reader["Title"].ToString();

                var linkIds = new List<int>();
                //linkDict.TryGetValue(story.id, out linkIds);
                //if (linkIds != null)
                //    story.links = linkIds;
                //else
                //    story.links = new List<int>();

                stories.Add(story);
            }
            FileForTerm(stories, path, slug);
            reader.Close();

            MakeTermFileForApp(path, appSlug, sentencesDict, term);
        }
        
        private static string GetSentence(List<string> sentences, string term) {
            
            foreach(string sentence in sentences) {
                var idx = sentence.ToLower().IndexOf(term.ToLower());
                if (idx > 0) {
                    var final = sentence.Insert(idx + term.Length, "</span>");
                    final = final.Insert(idx, "<span class='selected-term'>");
                    return final;
                }
            }
            return "";
        }

        private static void FileForTerm(List<story> stories, string path, string slug) {
            string json = JsonConvert.SerializeObject(stories);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            System.IO.Directory.CreateDirectory(path + "terms\\");
            //System.IO.File.WriteAllText(path + "terms\\" + slug + ".json", niceJson);
            FileUtil.WriteFile(path + "terms\\" + slug + ".json", niceJson);
        }

        private static void MakeTermFileForApp(string path, string appSlug, Dictionary<string, List<string>> sentencesDict, string term) {
            // Add all stories for the term for the app
            var stories = new List<story>();
            var reader = SqlUtil.Query("SELECT ID, MediaOutletID, Date, Title, Author  FROM AppStoryView WHERE App = '" + appSlug + "' ORDER BY Date");
            while (reader.Read()) {
                var story = new story();
                story.id = (Int32)reader["ID"];
                story.mediaId = (Int32)reader["MediaOutletID"];
                story.date = reader["Date"].ToString();
                story.sentence = GetSentence(sentencesDict[story.id.ToString()], term);
                story.author = reader["Author"].ToString();
                story.title = reader["Title"].ToString();
                //story.links = new List<int>();
                stories.Add(story);
            }

            FileForTerm(stories, path, appSlug);
            reader.Close();
        }
    }
}
