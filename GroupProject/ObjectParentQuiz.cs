using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ObjectParentQuiz
    {
        public string _XMLQuizID { get; set; }
        public int _QuestionId { get; set; }
        
        public ObjectParentQuiz()
        {
            //constructor
        }
        public ObjectParentQuiz(string XMLQuizID)
        {
            this._XMLQuizID = XMLQuizID;
        }
    }

    public class ObjectParentQuiz<T> :ObjectParentQuiz
    {
    }
}