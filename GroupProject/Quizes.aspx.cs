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
                loadViewResult();
                loadPendingQuizes();
            }
        }

        private void loadViewResult()
        {
            Security mySecurity = new Security();
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("Userid", HttpContext.Current.Session["Userid"].ToString());
            ds = myDal.ExecuteProcedure("spViewQuizResults");

            gvViewResults.DataSource = ds;
            gvViewResults.DataBind();

        }
        private void loadPendingQuizes()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("Userid", HttpContext.Current.Session["Userid"].ToString());
            ds = myDal.ExecuteProcedure("spViewPendingQuiz2");

            gvPendingQuiz.DataSource = ds;
            gvPendingQuiz.DataBind();
        }

        protected void btnViewQuizResult_Click(object sender, EventArgs e)
        {
            gvViewResults.Visible = true;
            gvPendingQuiz.Visible = false;

        }

        protected void btnPendingQuiz_Click(object sender, EventArgs e)
        {
            gvPendingQuiz.Visible = true;
            gvViewResults.Visible = false;
        }
    }
}