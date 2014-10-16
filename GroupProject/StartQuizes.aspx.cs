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
    public partial class StartQuizes : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(Request.QueryString["Quizid"]!=null)
                {
                    loadSelectedQuiz(Request.QueryString["Quizid"].ToString());
                }
            }
        }
        public void loadSelectedQuiz(string Quizid)
        {
            myDal.ClearParams();
            myDal.AddParam("@Quizid", Quizid);

            DataSet ds = myDal.ExecuteProcedure("spLoadQuiz3");

            dlSelectedQuiz.DataSource = ds;
            dlSelectedQuiz.DataBind();

            
        }

       
    }
}