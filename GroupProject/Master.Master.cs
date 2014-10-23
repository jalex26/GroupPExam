using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;

namespace GroupProject
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        DAL myDal = new DAL("Data Source=localhost;Initial Catalog=Exam;Integrated Security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckSecurity();
        }
        private void CheckSecurity()
        {
            Security mySecurity = new Security();
            lblFirstname.Text = mySecurity.Firstname;
            if(mySecurity.GetSecurityLevel() ==0)
            {
                //pnlLogin.Visible = true;
            }
            else
            {
                lblUserName.Visible = false;
                lblPassword.Visible = false;
                txtUserName.Visible = false;
                txtPassword.Visible = false;
                btnLogin.Visible = false;
            }

            //Adjust links visible according to Security Level(Admin or Regular)
            if (mySecurity.GetSecurityLevel() < 2 && mySecurity.GetSecurityLevel() != 0)
            {
                //lbTest.Visible = false;
                
                lbQuizes.Visible = true;
                lbSettings.Visible = false;
                
            }
            
            else if (mySecurity.GetSecurityLevel() == 0)
            {
                lbMentorPage.Visible = false;
                lbQuizes.Visible = false;
                lbSettings.Visible = false;
            }

            else
            {
              
                lbMentorPage.Visible = true;
                lbQuizes.Visible = false;
                lbSettings.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Security mySecurity = new Security(txtUserName.Text, txtPassword.Text);
            CheckSecurity();
            btnLogout.Visible = true;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
    }
}