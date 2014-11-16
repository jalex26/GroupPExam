using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ObjectMultiple : ObjectParentQuiz<string>
    {
        //im thinking of making a Parent class and this will be the children class,
        // the problem is how to make the parent class a collection or list. For now this would be my option,
        //every type of question will be on its own object
        //int _QuestionId;
        public string _Question { get; set; }
        public string _Option1 { get; set; }
        public string _Option2 { get; set; }
        public string _Option3 { get; set; }
        public string _Option4 { get; set; }
        public string _Correct { get; set; }
        public string _UserAnswer { get; set; }

        public ObjectMultiple(int QuestionId, string Question, string Option1, string Option2, string Option3, string Option4, string Correct)
        {
            //this.QuizId = QuizId;
            this._QuestionId = QuestionId;
            this._Question = Question;
            this._Option1 = Option1;
            this._Option2 = Option2;
            this._Option3 = Option3;
            this._Option4 = Option4;
            this._Correct = Correct;
        }
    }
    public static class Randomizer
    {// fisher-yates shuffle method
        public static void Shuffle<T>(this IList<T> list)
        {
            Random rng = new Random();
            int n = list.Count;
            while (n > 1)
            {
                n--;
                int k = rng.Next(n + 1);
                T value = list[k];
                list[k] = list[n];
                list[n] = value;
            }
        }
    }
}