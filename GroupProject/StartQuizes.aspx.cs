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
                if (Request.QueryString["xmlQuizid"] != null || Request.QueryString["Version"] != null)
                {
                    loadSelectedQuiz(Request.QueryString["xmlQuizid"].ToString(), Request.QueryString["Version"]);
                }
            }
        }
        public void loadSelectedQuiz(string xmlQuizid, string Version)
        {
            myDal.ClearParams();
            myDal.AddParam("@xmlQuizid", xmlQuizid);
            myDal.AddParam("@Version", Version);

            DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spLoadQuiz3");

            dlSelectedQuiz.DataSource = ds;
            dlSelectedQuiz.DataBind();

            
        }

        protected void dlSelectedQuiz_ItemCommand1(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "StartQuiz")
            {


                myDal.ClearParams();
                myDal.AddParam("xmlQuizid", Request.QueryString["xmlQuizid"].ToString());
                myDal.AddParam("Version", Request.QueryString["Version"].ToString());
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spLoadQuiz3");

                string xmlQuizid = ds.Tables[0].Rows[0]["xmlQuizid"].ToString();
                string Version = ds.Tables[0].Rows[0]["Version"].ToString();


                Response.Redirect("QuizForm.aspx?xmlQuizid=" + xmlQuizid + "&Version=" + Version);

            }
        }

       
    }
}