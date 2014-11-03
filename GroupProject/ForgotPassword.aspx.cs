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
    public partial class ForgotPassword : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel myPanel = (Panel)Master.FindControl("pnlLogin");
            myPanel.Visible = false;
            if (!IsPostBack)
            {
                CheckForTokenQuery();
            }
        }
        private void CheckForTokenQuery()
        {
            string Token = Request.QueryString["NewLinkChangePass"];
            if (Token != null)
            {
                myDal.ClearParams();
                myDal.AddParam("@Token", Token);
                DataSet ds = myDal.ExecuteProcedure("spCheckToken");
                if (ds.Tables[0].Rows[0]["exist"].ToString() == "true")
                {
                    ChangePass.Visible = true;
                    RetrievePass.Visible = false;
                }
                else
                {
                    InvalidToken.Visible = true;
                    RetrievePass.Visible = false;
                }
            }
        }

        protected void btnRecoverPassword_Click(object sender, EventArgs e)
        {
            this.Page.Validate("Email");
            if (this.Page.IsValid)
            {
                myDal.ClearParams();
                myDal.AddParam("@EmailAddress", txtEmail.Text);
                DataSet ds = myDal.ExecuteProcedure("spForgotPassword");
                if (ds.Tables[0].Rows[0]["message"].ToString() != "EmailInvalid")
                {
                    CheckMail.Visible = true;
                    //email snippet
                    string NewLinkChangePass;
                    NewLinkChangePass = ds.Tables[0].Rows[0]["Token"].ToString();
                    MailMessage message = new MailMessage();
                    message.From = new MailAddress("adrian.carter@robertsoncollege.net");
                    message.To.Add(new MailAddress(txtEmail.Text));
                    message.Subject = "retrieve account";
                    message.Body = "Change password link: http://localhost:49966/ForgotPassword.aspx?NewLinkChangePass=" + NewLinkChangePass;
                    SmtpClient client = new SmtpClient();
                    client.Host = "smtp.gmail.com";
                    client.Port = 587;
                    client.EnableSsl = true;
                    client.Credentials = new System.Net.NetworkCredential("adrian.carter@robertsoncollege.net", "Catage032908");
                    client.DeliveryMethod = SmtpDeliveryMethod.Network;
                    client.Send(message);
                }
                else
                {//invalid Email
                    CheckMailInvalid.Visible = false;
                }
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            string Token = Request.QueryString["NewLinkChangePass"];
            this.Page.Validate("Pass");
            if (this.Page.IsValid)
            {
                myDal.ClearParams();
                myDal.AddParam("@Token", Token);
                myDal.AddParam("@NewPass", txtPass.Text);
                DataSet ds = myDal.ExecuteProcedure("spChangePassword");
                if (ds.Tables[0].Rows[0]["message"].ToString() != "invalid token")
                {
                    ChangeSuccess.Visible = true;
                    RetrievePass.Visible = false;
                }
                else
                {
                    ChangeFailed.Visible = true;
                    RetrievePass.Visible = false;
                }
            }
        }
    }
}