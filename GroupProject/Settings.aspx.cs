using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Data;

namespace GroupProject
{
    public partial class Settings : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        DAL mydal = new DAL("Data Source=localhost;Initial Catalog=Exam;Integrated Security=SSPI");
        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(1);
            if (!IsPostBack)
            {
                loadSettings();
            }

        }
        private void loadSettings()
        {
            Security mySecurity = new Security();
            DataSet ds = new DataSet();
            mydal.ClearParams();
            mydal.AddParam("@SecurityLevel", "1");

            gvSettings.DataSource = mydal.ExecuteProcedure("spGetStudents");
            gvSettings.DataBind();

        }

        protected void gvSettings_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            //using Griedview row command
            pn1Upd.Visible = true;
        }
        private void loadUpdSettings(string Userid)
        {
            if (Userid != null)
            {

                mydal.ClearParams();
                mydal.AddParam("@Userid", Userid);
                mydal.AddParam("@SecurityLevel","1");
                DataSet ds = new DataSet();
                ds = mydal.ExecuteProcedure("spGetStudents");

                txtUserid.Text = ds.Tables[0].Rows[0]["Userid"].ToString();
                txtFirstname.Text = ds.Tables[0].Rows[0]["Firstname"].ToString();
                txtLastname.Text = ds.Tables[0].Rows[0]["Lastname"].ToString();
                txtUsername.Text = ds.Tables[0].Rows[0]["Username"].ToString();
                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
                txtClassname.Text = ds.Tables[0].Rows[0]["Classid"].ToString();
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }
      } 
    }