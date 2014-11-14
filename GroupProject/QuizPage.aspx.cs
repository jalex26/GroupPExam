using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Data;
using System.Web.Services;

namespace GroupProject
{
    public partial class QuizPage : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);

        //[System.Web.Services.WebMethod]
        [WebMethod(EnableSession = true)]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object SaveValueInSession(string var1)
        {//save the generated xml with users answer
            if (var1 != null)
            {
                string decodeXMLFromStringify = HttpUtility.UrlDecode(var1);
                HttpCookie myCookie = new HttpCookie("userQuiz");
                myCookie.Values.Add("XML", decodeXMLFromStringify);
                myCookie.Expires = DateTime.Now.AddDays(1);
                HttpContext.Current.Response.Cookies.Add(myCookie);

                //HttpContext.Current.Session["Quiz"] = decodeXMLFromStringify;
            }
            return "success";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadXML();
            }
        }
        private void loadXML()
        {
            //HttpCookie myCookie = Request.Cookies["userXML"];
            //Load XML 
            //i can use session to retrieve xml file
            if (HttpContext.Current.Request.Cookies["userQuiz"] != null)
            //if (HttpContext.Current.Session["Quiz"] != null)
            {
                //XMLquiz.DocumentContent = HttpContext.Current.Session["Quiz"].ToString();
                string Cookie = HttpContext.Current.Request.Cookies["userQuiz"]["XML"].ToString();
                XMLquiz.DocumentContent = HttpUtility.UrlDecode(Cookie);

            }
            else
            {
                myDal.ClearParams();
                DataSet dataSet = new DataSet();
                dataSet = myDal.ExecuteProcedure("spGetTestSample");
                XMLquiz.DocumentContent = dataSet.Tables[0].Rows[0]["XMLQuiz"].ToString();
                HttpCookie myCookie1 = new HttpCookie("userXML");
                myCookie1.Values.Add("XML", dataSet.Tables[0].Rows[0]["XMLQuiz"].ToString());
                myCookie1.Expires = DateTime.Now.AddDays(1);
                HttpContext.Current.Response.Cookies.Add(myCookie1);
            }
            XMLquiz.TransformSource = "Quiz.xsl";

        }

    }
}