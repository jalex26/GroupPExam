using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using DAL_Project;
using System.Data;

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
            string ISDONE = dict["var5"];

           int quizStat= UpdateDBwithUserAnswer(USERID, XML, QUIZSTUDENTID, USERPOINTS, ISDONE);
            context.Response.ContentType = "application/json";
            //string[] resp = new string[2];
            //resp[0] = 
            switch(quizStat)
            {
                case 1:
                    context.Response.Write("{\"status\":\"ongoing\"}");
                    break;
                case 2:
                    context.Response.Write("{\"status\":\"finish\"}");
                    break;
                case 3:
                    context.Response.Write("{\"status\":\"closed\"}");
                    break;
                default:
                    context.Response.Write("{\"status\":\"err here\"}");
                    break;

            }
            

            //return "success";
            //i may also include the remaining time here at response.
        }

        private int UpdateDBwithUserAnswer(string userid, string xml, string qzSTDid, string points, string isdone)
        {
            int status = -1; //1-still online, 2=Quiz is done, 3=quiz is close
            if (userid != "undefined")
            {
                myDal.ClearParams();
                myDal.AddParam("@Userid", userid);
                myDal.AddParam("@XMLStudentResponse", xml);
                myDal.AddParam("@QuizStudentid", qzSTDid);
                myDal.AddParam("@Points", points);
                if (isdone != "false")
                    myDal.AddParam("@isDone","true");
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spUpdateQuizStudent");
                switch (ds.Tables[0].Rows[0]["status"].ToString())
                {
                    case "success":
                        status = 1;
                        break;
                    case "QuizFinished":
                        status = 2;
                        break;
                    case "QuizClose":
                        status = 3;
                        break;
                    default:
                        status = -1;
                        break;

                }
            }
            return status;
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