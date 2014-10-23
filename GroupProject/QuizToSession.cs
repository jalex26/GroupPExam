using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class QuizToSession
    {
        List<XMLQuizContent> Quiz = new List<XMLQuizContent>();

        public void XMLQuizContent()
        {
            if(HttpContext.Current.Session["Quiz"] !=null)
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