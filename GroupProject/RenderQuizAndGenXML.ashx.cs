using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    /// <summary>
    /// Summary description for RenderQuizAndGenXML
    /// </summary>
    public class RenderQuizAndGenXML : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
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