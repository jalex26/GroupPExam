using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DAL_Project;

namespace GroupProject
{
    public partial class Quizes : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(1);
            if (!IsPostBack)
            {
                LoadUserQuiz();
            }
        }
        private void StartExam()
        {
            myDal.ClearParams();

        }
        private void LoadUserQuiz()
        {
            if (HttpContext.Current.Session["Userid"].ToString() != null)
            {
                myDal.ClearParams();
                myDal.AddParam("@UserId", HttpContext.Current.Session["Userid"].ToString());
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spGetQuizStudentByStudent");
                if (ds.Tables.Count != 0 && ds.Tables[0].Rows[0][0].ToString() != "Empty")
                {
                    dlPendingQuiz.DataSource = ds.Tables[0];
                    dlPendingQuiz.DataBind();
                }
            }
        }

        protected void dlPendingQuiz_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Start")
            {//user select Start Quiz
                Security mySecurity = new Security(1);
                string QuizStudentid = e.CommandArgument.ToString();
                myDal.ClearParams();
                myDal.AddParam("@UserId", HttpContext.Current.Session["Userid"].ToString());
                HttpContext.Current.Session["QuizStudentId"] = QuizStudentid;
                myDal.AddParam("@QuizStudentId", QuizStudentid);
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spStartQuizStudent");

                if (ds.Tables[0].Rows.Count != 0)
                {
                    if (HttpContext.Current.Session["Quiz"] == null)
                    {
                        string userID = HttpContext.Current.Session["Userid"].ToString();
                        //string[] session = new string[] { HttpUtility.UrlEncode(ds.Tables[0].Rows[0]["XMLStudentResponse"].ToString()), userID };

                        HttpContext.Current.Session["Quiz"] = HttpUtility.UrlEncode(ds.Tables[0].Rows[0]["XMLStudentResponse"].ToString());
                    }
                    

                    //HttpCookie myCookie1 = new HttpCookie("userQuiz");
                    ////it is required to encode the XML document when store/retrieve to Cookies
                    //myCookie1.Values.Add("XML", HttpUtility.UrlEncode(ds.Tables[0].Rows[0]["XMLStudentResponse"].ToString()));
                    //myCookie1.Expires = DateTime.Now.AddDays(1);
                    //if (HttpContext.Current.Request.Cookies["userQuiz"] == null || HttpContext.Current.Request.Cookies["userQuiz"]["UID"].ToString() != HttpContext.Current.Session["Userid"].ToString())
                    //{// cookie does not exists yet.
                    //    HttpContext.Current.Response.Cookies.Add(myCookie1);
                    //}
                    Response.Redirect("QuizPage.aspx");
                }

            }
        }
    }
}