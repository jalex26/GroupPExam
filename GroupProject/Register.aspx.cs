using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Data;
using System.Net.Mail;

namespace GroupProject
{
    public partial class Register : System.Web.UI.Page
    {

        DAL myDal = new DAL(Globals.conn);

        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(0);      // no login required to access page

            // makes login panel on masterpage invisible
            Panel myPanel = (Panel)Master.FindControl("pnlLogin");
            myPanel.Visible = false;

            // abandons session and re-directs the user to Home.aspx if a logged in user tries to access page
            if (mySecurity.GetSecurityLevel() != 0)
            {
                HttpContext.Current.Session.Abandon();

                HttpContext.Current.Response.Redirect("Home.aspx");
            }

            if (!IsPostBack)
            {
                LoadRegisterPanel();
            }

        }

        private void LoadRegisterPanel()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
        }

        private void NewUserRegistration()
        {
            if (rfvFirstName.IsValid && rfvLastName.IsValid &&
                rfvEmail.IsValid && rfvPassword.IsValid)
            {
                myDal.ClearParams();
                myDal.AddParam("@Firstname", txtFirstName.Text);
                myDal.AddParam("@Lastname", txtLastName.Text);
                myDal.AddParam("@Email", txtEmail.Text);
                myDal.AddParam("@Password", txtPassword.Text);
                DataSet ds= myDal.ExecuteProcedure("SD18EXAM_spInsertUser");

                if(ds.Tables.Count !=0)
                {
                    lblRegisterMessage.Text = "Congratulations! You have successfully registered to the Robertson Exam site. Please check your email for registration confirmation or proceed to homepage to access your account by logging in.";
                }

                

                sendNewUserConfirmation();
            }
        }

        //sends a confirmation email to user after new insert
        private void sendNewUserConfirmation()
        {
            string fullEmail = txtEmail.Text + "@robertsoncollege.net";   
            MailMessage message = new MailMessage();
            message.From = new MailAddress("nupur.singh@robertsoncollege.net");
            message.To.Add(new MailAddress(fullEmail));
            message.Subject = "New User Confirmation!";
            message.Body = "Dear" + " " + txtFirstName.Text + "," + "\r\n\r\n This is an auto generated confirmation email.\r\n\r\n You have successfully registered to the Robertson College's Exam site.\r\n\r\n Please login to the site to access your account. \r\n\r\n Thank You!\r\n Robertson College\r\n RobertsonCollege.com\r\n +1 888-892-5262";
            SmtpClient client = new SmtpClient();
            client.Host = "smtp.gmail.com";
            client.Port = 587;
            client.EnableSsl = true;
            client.Credentials = new System.Net.NetworkCredential
            ("nupur.singh@robertsoncollege.net", "sherlockian123");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Send(message);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            NewUserRegistration();
        }
    }
}