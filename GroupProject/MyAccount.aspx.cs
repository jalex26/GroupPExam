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
    public partial class MyAccount : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadStudentInfo();
        }
        public void LoadStudentInfo()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Userid",HttpContext.Current.Session["Userid"].ToString());
            ds = myDal.ExecuteProcedure("spGetStudentInfo");
            lblUserid.Text = ds.Tables[0].Rows[0]["Userid"].ToString();
            Image1.ImageUrl = ds.Tables[0].Rows[0]["UserPicture"].ToString();
            lblFirstname.Text = ds.Tables[0].Rows[0]["Firstname"].ToString();
            lblLastname.Text = ds.Tables[0].Rows[0]["Lastname"].ToString();
            lblClassid.Text = ds.Tables[0].Rows[0]["Classid"].ToString();
            lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
        }

        //protected void btnChangePassword_Click(object sender, EventArgs e)
        //{
        //}
    }
}