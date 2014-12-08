using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;

namespace GroupProject
{
    public partial class MyAccount : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);

        protected void Page_Load(object sender, EventArgs e)
        {       
            Security mySecurity = new Security(1);

            LoadStudentInfo();

            if (mySecurity.GetSecurityLevel() != 1) 
            {
                pnlStudentQuizReport.Visible = false;
            }

            else
            {

                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/ReportForStudents.rdlc");
                ReportDataSource datasource = new ReportDataSource("DataSet1", StudentQuizReport());
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(datasource);
                            
            }
        }

        public void LoadStudentInfo()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Userid",HttpContext.Current.Session["Userid"].ToString());
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetStudentInfo");
            lblUserid.Text = ds.Tables[0].Rows[0]["Userid"].ToString();
            Image1.ImageUrl = ds.Tables[0].Rows[0]["UserPicture"].ToString();
            lblFirstname.Text = ds.Tables[0].Rows[0]["Firstname"].ToString();
            lblLastname.Text = ds.Tables[0].Rows[0]["Lastname"].ToString();
            lblClassid.Text = ds.Tables[0].Rows[0]["Classid"].ToString();
            lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
        }

        public DataTable StudentQuizReport()
        {
            int USERID;

            if (HttpContext.Current.Session["Userid"] != null)
            {
                int.TryParse(HttpContext.Current.Session["Userid"].ToString(), out USERID);
              
                myDal.ClearParams();
                myDal.AddParam("@Userid", USERID);
                // myDal.ExecuteProcedure("SD18EXAM_spGetStudentResponseDetails");               
            }

            return myDal.ExecuteProcedure("SD18EXAM_spGetStudentResponseDetails").Tables[0];

        }

       
    }
}