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
    public partial class Admin : System.Web.UI.Page
    {
        DAL myDal = new DAL("Data Source=localhost;Initial Catalog=Exam;Integrated Security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(2);
            if(!IsPostBack)
            {
                LoadUsers();
            }
        }
        private void LoadUsers()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            GVUsers.DataSource = myDal.ExecuteProcedure("spGetStudents");
            GVUsers.DataBind();
        }
    }
}