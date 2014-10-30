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
    public partial class ManageProfiles : System.Web.UI.Page
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
            //mydal.AddParam("@SecurityLevel", HttpContext.Current.Session["SecurityLevel"].ToString());

            gvSettings.DataSource = mydal.ExecuteProcedure("spGetStudents");
            gvSettings.DataBind();

        }

        protected void gvSettings_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            //using Griedview row command
            pn1Upd.Visible = true;
            gvSettings.SelectedIndex = Convert.ToInt32(e.CommandArgument);

            if(e.CommandName.ToString()=="Upd")
            {
                string Userid = gvSettings.SelectedDataKey.Value.ToString();
                loadUpdatePanel(Userid);
            }
        }
        private void loadUpdatePanel(string Userid)
        {
            if (Userid != null)
            {
                     
                //loading update panel with alues from selected row in grid to make changes

                txtUserid.Text = gvSettings.SelectedDataKey.Value.ToString();
                txtFirstname.Text = gvSettings.Rows[gvSettings.SelectedIndex].Cells[2].Text;
                txtLastname.Text = gvSettings.Rows[gvSettings.SelectedIndex].Cells[3].Text;
                txtEmail.Text = gvSettings.Rows[gvSettings.SelectedIndex].Cells[4].Text;
                txtPassword.Text = gvSettings.Rows[gvSettings.SelectedIndex].Cells[5].Text;              
                txtClassname.Text = gvSettings.Rows[gvSettings.SelectedIndex].Cells[6].Text;            
               
            }

        }
        private void saveCustomers(string Userid)
        {
                mydal.ClearParams();
                mydal.AddParam("@Userid", Userid);
                mydal.AddParam("@SecurityLevel", "1");
                DataSet ds = new DataSet();
                ds = mydal.ExecuteProcedure("spGetStudent3");
                //mydal.AddParam("@id", id);
                mydal.AddParam("@Userid", txtUserid.Text);
                txtFirstname.Text = ds.Tables[0].Rows[0]["Firstname"].ToString();
                txtLastname.Text = ds.Tables[0].Rows[0]["Lastname"].ToString();               
                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
                txtClassname.Text = ds.Tables[0].Rows[0]["Classname"].ToString();
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            saveCustomers(txtUserid.Text);
            pn1Upd.Visible = false;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pn1Upd.Visible = false;
        }
      } 
    }