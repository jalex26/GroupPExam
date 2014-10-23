using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class XMLQuizContent
    {
        public int XMLQuizID { get; set; }
        public string Title { get; set; }
        public string Subject { get; set; }
        public int CourseID { get; set;}
        public int Time { get; set; }
        public int DifficultyId { get; set; }
    }
}