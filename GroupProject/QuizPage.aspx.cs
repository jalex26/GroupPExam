﻿using System;
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
                string userID = HttpContext.Current.Session["Userid"].ToString();
                //HttpCookie myCookie = new HttpCookie("userQuiz");
                //myCookie.Values.Add("XML", HttpUtility.UrlEncode(decodeXMLFromStringify));
                //myCookie.Values.Add("UID", userID);
                //myCookie.Expires = DateTime.Now.AddDays(1);
                //HttpContext.Current.Response.Cookies.Add(myCookie);
                //string[] session = new string[] { HttpUtility.UrlEncode(decodeXMLFromStringify), userID };
                HttpContext.Current.Session["Quiz"] = HttpUtility.UrlEncode(decodeXMLFromStringify);

            }
            return "success";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadXML();
                pnlQuizResult.Style.Add(HtmlTextWriterStyle.Display, "none");   //hide the result panel
                pnlQuizItem.Style.Add(HtmlTextWriterStyle.Display, "block");
            }
        }
        private void loadXML()
        {
            //Load XML 
           // if (HttpContext.Current.Request.Cookies["userQuiz"] != null)
            if (HttpContext.Current.Session["Quiz"] != null)
            {
                //XMLquiz.DocumentContent = HttpContext.Current.Session["Quiz"].ToString();
                string session = HttpContext.Current.Session["Quiz"].ToString();
                //string Cookie = HttpContext.Current.Request.Cookies["userQuiz"]["XML"].ToString();
                XMLquiz.DocumentContent = HttpUtility.UrlDecode(session);
            }
            else
            {//nothing to load here
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

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {

            }
        }

    }
}