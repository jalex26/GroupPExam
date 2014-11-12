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
                DataSet ds = myDal.ExecuteProcedure("spGetQuizStudentByStudent");
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
                Security mySecurity = new Security();
                string QuizStudentid = e.CommandArgument.ToString();
                myDal.ClearParams();
                myDal.AddParam("@UserId", HttpContext.Current.Session["Userid"].ToString());
                HttpContext.Current.Session["QuizStudentId"] = QuizStudentid;
                myDal.AddParam("@QuizStudentId", QuizStudentid);
                DataSet ds = myDal.ExecuteProcedure("spStartQuizStudent");
                if (ds.Tables[0].Rows.Count != 0)
                {
                    HttpContext.Current.Session["Quiz"] = ds.Tables[0].Rows[0]["XMLStudentResponse"].ToString();
                    Response.Redirect("QuizPage.aspx");
                }

                //im working at here now!!!!!!!!!! displaying the exam
                //Response.Redirect("ItemPage.aspx?UPC=" + UPC);
            }
        }







    }
}