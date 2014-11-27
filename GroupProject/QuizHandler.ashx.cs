using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using DAL_Project;

namespace GroupProject
{
    /// <summary>
    /// Summary description for QuizHandler
    /// </summary>
    public class QuizHandler : IHttpHandler
    {
        DAL myDal = new DAL(Globals.conn);
        public void ProcessRequest(HttpContext context)
        {
            //var JsonObject = context.Request.Form[0];
            var jsonSerializer = new JavaScriptSerializer();
            var jsonString = String.Empty;

            context.Request.InputStream.Position = 0;
            using (var inputStream = new StreamReader(context.Request.InputStream))
            {
                jsonString = inputStream.ReadToEnd();
            }
            var dict = jsonSerializer.Deserialize<Dictionary<string, string>>(jsonString);
            string XML = HttpUtility.UrlDecode(dict["var1"]);
            string USERID = dict["var2"];
            string QUIZSTUDENTID = dict["var3"];
            string USERPOINTS = dict["var4"];

            UpdateDBwithUserAnswer(USERID, XML, QUIZSTUDENTID, USERPOINTS);
            context.Response.ContentType = "application/json";
            context.Response.Write("{\"status\":\"success\"}");

            //return "success";
            //i may also include the remaining time here at response.
        }

        private void UpdateDBwithUserAnswer(string userid, string xml, string qzSTDid, string points)
        {
            myDal.ClearParams();
            myDal.AddParam("@Userid", userid);
            myDal.AddParam("@XMLStudentResponse", xml);
            myDal.AddParam("@QuizStudentid",qzSTDid);
            myDal.AddParam("@Points", points);
            myDal.ExecuteProcedure("SD18EXAM_spUpdateQuizStudent");
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