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

        protected void btnLoadQuiz_Click(object sender, EventArgs e)
        {
            
        }
        private void StartExam()
        {
            myDal.ClearParams();

        }
        private void LoadUserQuiz()
        {
            if (HttpContext.Current.Session["Userid"].ToString() != null)
            myDal.ClearParams();
            myDal.AddParam("@UserId", HttpContext.Current.Session["Userid"].ToString());
            DataSet ds = myDal.ExecuteProcedure("spGetQuizStudentByStudent");
            if(ds.Tables.Count != 0)
            {
                dlPendingQuiz.DataSource = ds.Tables[0];
                dlPendingQuiz.DataBind();
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
                myDal.AddParam("@QuizStudentId", QuizStudentid);
                DataSet ds = myDal.ExecuteProcedure("spStartQuizStudent");


                //Response.Redirect("ItemPage.aspx?UPC=" + UPC);
            }
        }


        
       

       
        
    }
}