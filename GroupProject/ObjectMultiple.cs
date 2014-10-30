using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ObjectMultiple
    {
        int _QuestionId;
        string _Question;
        string _Option1;
        string _Option2;
        string _Option3;
        string _Option4;
        string _Correct;
        string _UserAnswer;

        public int QuestionId
        {
            get { return _QuestionId; }
            set { _QuestionId = value; }
        }
        public string Question
        {
            get { return _Question; }
            set { _Question = value; }
        }
        public string Option1
        {
            get { return Option1; }
            set { Option1 = value; }
        }
        public string Option2
        {
            get { return Option2; }
            set { Option2 = value; }
        }
        public string Option3
        {
            get { return Option3; }
            set { Option3 = value; }
        }
        public string Option4
        {
            get { return Option4; }
            set { Option4 = value; }
        }
        public string Correct
        {
            get { return Correct; }
            set { Correct = value; }
        }
        public string UserAnswer
        {
            get { return UserAnswer; }
            set { UserAnswer = value; }
        }

        public ObjectMultiple(int QuestionId, string Question, string Option1, string Option2, string Option3, string Option4, string Correct)
        {
            this.QuestionId = QuestionId;
            this.Question = Question;
            this.Option1 = Option1;
            this.Option2 = Option2;
            this.Option3 = Option3;
            this.Option4 = Option4;
            this.Correct = Correct;
        }
        public ObjectMultiple()
        {// nothing here
        }
            
    }
}