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
        DAL myDal = new DAL(Globals.conn);

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckSecurity();

            if (!IsPostBack)
            {

                // loads site navigation xml files based on user level
                // if not logged in security level is 0 -- user_menu.xml
                // if logged in with security level 1 -- student_menu.xml
                // if logged in with security level 2 -- mentor_menu.xml
                // if logged in with security level 3 -- admin_menu.xml

                string appDataPath = HttpContext.Current.Server.MapPath("~/NavigationXmlFiles");
                this.XmlDataSource1.DataFile = appDataPath + "\\" + GetRole() + "_menu.xml";
                this.XmlDataSource1.XPath = @"/Items/Item";
            }

        }
        private void CheckSecurity()
        {
            Security mySecurity = new Security();
            lblFirstname.Text = mySecurity.Firstname;
            if(mySecurity.GetSecurityLevel() == 0)
            {
                //pnlLogin.Visible = true;//        
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
                               
            }
            
            else if (mySecurity.GetSecurityLevel() == 0)
            {                
                btnLogout.Visible = false;
            }
           
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Security mySecurity = new Security(txtUserName.Text, txtPassword.Text);
            CheckSecurity();
            Response.Redirect("Home.aspx");
            btnLogout.Visible = true;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }

        // method that gets user level based on login to adjust navigation
        protected string GetRole()
        {
            string role = string.Empty;

            Security mySecurity = new Security();
            if (mySecurity.GetSecurityLevel() == 3)
            {
                role = "admin";
            }

            else if (mySecurity.GetSecurityLevel() == 2)
            {
                role = "mentor";
            }

            else if (mySecurity.GetSecurityLevel() == 1)
            {
                role = "student";
            }

            else if (mySecurity.GetSecurityLevel() == 0)
            {
                role = "user";
            }
            return role;
        }
    }
}