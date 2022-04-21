using System;
using System.IO;



namespace Util {

    public class FileUtil {

        public static void WriteFile(string fullPath, string text) {
            try {
                var file = File.ReadAllText(fullPath);
                // Don't write file if it hasn't changed (maybe get hash?)
                if (file.Length == text.Length)
                    return;
            }
            catch (Exception) {
                // Ignore file not found
            }
            System.IO.File.WriteAllText(fullPath, text);
        }


        // Remove directory and contents if they exist, them make an empty directory
        public static void ClearDirectory(string path) {
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            //if (Directory.Exists(path))
            //    System.IO.Directory.Delete(path, true);
            //System.IO.Directory.CreateDirectory(path);
        }
    }
}
