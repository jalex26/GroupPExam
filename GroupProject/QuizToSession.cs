using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace GroupProject
{
    public class QuizToSession
    {
        List<XMLQuizContent> Quiz = new List<XMLQuizContent>();

        public QuizToSession()
        {
            if (HttpContext.Current.Session["Quiz"] !=null)
            {
                Quiz = (List<XMLQuizContent>)HttpContext.Current.Session["Quiz"];
            }
        }
        public void Save()
        {
            HttpContext.Current.Session["Quiz"] = Quiz;
        }
    }
}