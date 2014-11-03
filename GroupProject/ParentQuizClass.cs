using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class ParentQuizClass: List<ParentQuizClass>
    {
        public int QuestionId { get; set; }
        public int QuizId { get; set; }
    }
}