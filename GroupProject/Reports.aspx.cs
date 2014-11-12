using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;

namespace GroupProject
{
    public partial class Reports : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);


        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(2);
        }
    }
}