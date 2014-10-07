﻿using System;
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
                pnlLogin.Visible = true;
            }
            else
            {
                lblUserName.Visible = false;
                lblPassword.Visible = false;
                txtUserName.Visible = false;
                txtPassword.Visible = false;
                btnLogin.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Security mySecurity = new Security(txtUserName.Text, txtPassword.Text);
            CheckSecurity();
        }
    }
}