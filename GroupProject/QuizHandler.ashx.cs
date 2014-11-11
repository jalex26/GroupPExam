using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    /// <summary>
    /// Summary description for QuizHandler
    /// </summary>
    public class QuizHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var JsonObject = context.Request.Form[0];

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}