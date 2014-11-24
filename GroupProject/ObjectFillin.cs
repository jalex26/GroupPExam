using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ObjectFillin : ObjectParentQuiz<string>
    {
        public string _Question { get; set; }
        public List<string> _Correct { get; set; }
        public List<string> _Option { get; set; }

        public ObjectFillin()
        {
            //constructor
        }

        public ObjectFillin(int QuestionId,string Questi, List<string> Correct, List<string> Options)
        {
            this._QuestionId = QuestionId;
            this._Question = Questi;
            this._Correct = Correct;
            this._Option = Options;
        }
    }
}