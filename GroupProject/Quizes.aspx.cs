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
                lblMessage.Text = "";

                myDal.ClearParams();
                myDal.AddParam("@UserId", HttpContext.Current.Session["Userid"].ToString());
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spGetQuizStudentByStudent");
                if (ds.Tables.Count != 0 && ds.Tables[0].Rows[0][0].ToString() != "Empty")
                {
                    dlPendingQuiz.DataSource = ds.Tables[0];
                    dlPendingQuiz.DataBind();
                }

                else
                {
                    lblMessage.Text = "You currently do not have any assigned quizes!";
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
                    
                    Response.Redirect("QuizPage.aspx");
                }

            }
        }
    }
}