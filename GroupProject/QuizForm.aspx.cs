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
    public partial class QuizForm : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["xmlQuizid"] != null || Request.QueryString["Version"] != null)
                {
                    loadQuestions(Request.QueryString["xmlQuizid"].ToString(), Request.QueryString["Version"].ToString());
                    
                }
            }
        }
        public void loadQuestions(string xmlQuizid, string Version)
        {
            myDal.ClearParams();
            myDal.AddParam("@xmlQuizid", xmlQuizid);
            myDal.AddParam("@Version", Version);

            DataSet ds = myDal.ExecuteProcedure("spQuizForm");

            dlMultipleChoice.DataSource = ds.Tables[0];
            dlMatching.DataSource = ds.Tables[1];
            dlMultipleChoice.DataBind();
            dlMatching.DataBind();
        }
        
    }
}