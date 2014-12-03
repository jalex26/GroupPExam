using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;

namespace GroupProject
{
    public partial class ManageProfiles : System.Web.UI.Page
    {
        StateCookies myState = new StateCookies();
        DAL myDal = new DAL(Globals.conn);

        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(2);
            if (!IsPostBack)
            {

                loadUsers(myState);
                loadClass();
                loadSelect();
                loadSelectClass();
                loadNewCourse();
                loadNewClasses();
                loadCourse();
                pnlNewCourse.Visible = false;
            }
        }
        private void loadSelect()
        {
            myDal.ClearParams();
            myDal.AddParam("@SortColumn", myState.SortColumn + " " + myState.Direction);
            gvSettings.DataSource = myDal.ExecuteProcedure("SD18EXAM_spGetSortColumn");
            gvSettings.DataBind();
        }

        private void loadCourse()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetCourse");
            ddlCourse.DataTextField = "Coursename";
            ddlCourse.DataValueField = "Courseid";
            ddlCourse.DataSource = ds;
            ddlCourse.DataBind();
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadClass();
            mpeUpdate.Show();
        }
        private void loadClass()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("Courseid", ddlCourse.SelectedValue);
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetClass");
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "Classid";
            ddlClass.DataSource = ds;
            ddlClass.DataBind();
        }
        private void loadUsers(StateCookies myState)
        {
            //Security mySecurity = new Security();
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Classid",ddlClassname.SelectedValue);
            gvSettings.DataSource = myDal.ExecuteProcedure("SD18EXAM_spGetUsers");
            gvSettings.DataBind();

        }

        // loads selected user values in pop up update panel to make changes
        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            LinkButton linkUpdate = sender as LinkButton;
            GridViewRow grid = (GridViewRow)linkUpdate.NamingContainer;
            string tempID = gvSettings.DataKeys[grid.RowIndex].Value.ToString();
            ViewState["tempId"] = tempID;

            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Userid", tempID);
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetUsers");
            lblUserID.Text = tempID;
            txtFirstName.Text = ds.Tables[0].Rows[0]["Firstname"].ToString();
            txtLastName.Text = ds.Tables[0].Rows[0]["Lastname"].ToString();
            txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();

            ddlSecurity.SelectedIndex = ddlSecurity.Items.IndexOf(ddlSecurity.Items.FindByValue(ds.Tables[0].Rows[0]["SecurityLevel"].ToString()));

            ddlClass.SelectedIndex = ddlClass.Items.IndexOf(ddlClass.Items.FindByValue(ds.Tables[0].Rows[0]["Classid"].ToString()));

            mpeUpdate.Show();
        }

        // deletes selected user from database
        protected void lbDelete_Click(object sender, EventArgs e)
        {
            LinkButton linkUpdate = sender as LinkButton;
            GridViewRow grid = (GridViewRow)linkUpdate.NamingContainer;
            string tempID = gvSettings.DataKeys[grid.RowIndex].Value.ToString();
            ViewState["tempId"] = tempID;

            lblSelectedUserid.Text = tempID;

            mpeDelete.Show();

            lblDelete.Text = "Are you sure you want to delete selected user (User ID): " + tempID + "?";

        }

        // saves or updates changes in database
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {

                myDal.ClearParams();
                myDal.AddParam("@Userid", lblUserID.Text);
                myDal.AddParam("@Firstname", txtFirstName.Text);
                myDal.AddParam("@Lastname", txtLastName.Text);
                myDal.AddParam("@Email", txtEmail.Text);
                myDal.AddParam("@Password", txtPassword.Text);
                myDal.AddParam("@SecurityLevel", ddlSecurity.SelectedValue);
                myDal.AddParam("@Classid", ddlClass.SelectedValue);
                myDal.ExecuteProcedure("SD18EXAM_spUpdateUser");
                loadUsers(myState);
                mpeUpdate.Hide();
            }

            catch
            {
                lblStatus1.Text = "Record Not Updated. Please Try Again!";
                mpeUpdate.Show();
            }
        }

        protected void btnCancel_Click1(object sender, EventArgs e)
        {
            mpeUpdate.Hide();
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {

            myDal.ClearParams();
            myDal.AddParam("@Userid", lblSelectedUserid.Text);
            myDal.ExecuteProcedure("SD18EXAM_spDeleteStudent");
            loadUsers(myState);
            mpeUpdate.Hide();

        }

        protected void gvSettings_Sorting(object sender, GridViewSortEventArgs e)
        {
            StateCookies myState = new StateCookies();
            myState.ColumnChange(e.SortExpression.ToString());
            loadSelect();
        }

        protected void gvSettings_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            StateCookies myState = new StateCookies();
            gvSettings.PageIndex = e.NewPageIndex;

            loadUsers(myState);
        }

        private void loadSelectClass()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetClass");

            ddlClassname.DataSource = ds;
            ddlClassname.DataTextField = "Classname";
            ddlClassname.DataValueField = "Classid";
            ddlClassname.DataBind();
        }

        protected void ddlClassname_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadUsers(myState);
        }

        protected void lbUsers_Click(object sender, EventArgs e)
        {
            ddlClassname.Visible = true;
            gvSettings.Visible = true;
            lblSelectClass.Visible = true;
            lblNewCourse.Visible = false;
            ddlCourseList.Visible = false;
            txtNewCourse.Visible = false;
            btnSaveCourse.Visible = false;
            btnDeleteCourse.Visible = false;
            lblCourseSelection.Visible = false;
            lblClassSelection.Visible = false;
            lblNewClass.Visible = false;
            txtNewClass.Visible = false;
            ddlClassSelection.Visible = false;
            btnSaveClass.Visible = false;

        }
        protected void lbCourse_Click(object sender, EventArgs e)
        {
            ddlClassname.Visible = false;
            gvSettings.Visible = false;
            lblSelectClass.Visible = false;
            //Edited
            pnlNewCourse.Visible = false;
            pnlCourse.Visible = false;
            btnCreateCourse.Visible = true;
            btnEditDelete.Visible = true;
            //End
            lblClassSelection.Visible = false;
            lblNewClass.Visible = false;
            txtNewClass.Visible = false;
            ddlClassSelection.Visible = false;
            btnSaveClass.Visible = false;
        }
        private void loadNewCourse()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            //myDal.AddParam("@Classname", ddlCourseList.SelectedValue);
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetCourse");

            ddlCourseList.DataSource = ds;
            ddlCourseList.DataTextField = "Coursename";
            ddlCourseList.DataValueField = "Courseid";
            ddlCourseList.DataBind();
        }

        protected void btnSaveCourse_Click(object sender, EventArgs e)
        {
            myDal.ClearParams();
            myDal.AddParam("@Classname", txtNewCourse.Text);
            myDal.ExecuteProcedure("SD18EXAM_spInsertCourse");
            loadNewCourse();
            txtNewCourse.Text = "";
         
        }

        protected void btnDeleteCourse_Click(object sender, EventArgs e)
        {
            myDal.ClearParams();
            myDal.AddParam("@Courseid", ddlCourseList.SelectedValue);
            myDal.ExecuteProcedure("SD18EXAM_spDeleteCourse");
            loadNewCourse();
        }

        private void loadNewClasses()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("Courseid", ddlClassSelection.SelectedValue);
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetClass");

            ddlClassSelection.DataSource = ds;
            ddlClassSelection.DataTextField = "Classname";
            ddlClassSelection.DataValueField = "Courseid";
            ddlClassSelection.DataBind();
        }
        protected void btnSaveClass_Click(object sender, EventArgs e)
        {
            myDal.ClearParams();
            myDal.AddParam("@Courseid", ddlCourseList.SelectedValue);
            myDal.AddParam("@Classname", txtNewClass.Text);
            myDal.ExecuteProcedure("SD18EXAM_spInsertClass");
            loadSelectClass();
            txtNewClass.Text = "";
        }

        protected void btnCreateCourse_Click(object sender, EventArgs e)
        {
            pnlNewCourse.Visible = true;
            btnCreateCourse.Visible = false;
            btnEditDelete.Visible = false;
        }
        protected void btneditDelete_Click(object sender, EventArgs e)
        {
            pnlCourse.Visible = true;
            btnEditDelete.Visible = false;
            btnCreateCourse.Visible = false;
        }
        protected void lbStudentLogHistory_Click(object sender, EventArgs e)
        {

        }
        protected void lbClass_Click1(object sender, EventArgs e)
        {
            ddlClassname.Visible = false;
            gvSettings.Visible = false;
            lblSelectClass.Visible = false;
            pnlNewCourse.Visible = false;
            ddlCourseList.Visible = true;

            btnDeleteCourse.Visible = false;
            lblCourseSelection.Visible = true;
            lblClassSelection.Visible = false;
            lblNewClass.Visible = true;
            txtNewClass.Visible = true;
            ddlClassSelection.Visible = false;
            btnSaveClass.Visible = true;
            btnCreateCourse.Visible = false;
            btnEditDelete.Visible = false;
        }

    }
}