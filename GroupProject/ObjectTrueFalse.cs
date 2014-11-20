using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ObjectTrueFalse: ObjectParentQuiz<string>
    {
        public string _Question { get; set; }
        public string _Answer { get; set; }

        public ObjectTrueFalse()
        {
            // empty constructor
        }

        public ObjectTrueFalse(int QuestionId, string Question, string Answer)
        {
            this._QuestionId = QuestionId;
            this._Question = Question;
            this._Answer = Answer;
        }
    }
}