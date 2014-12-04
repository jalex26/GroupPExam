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

                loadNewClasses();
                loadCourse();
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
            myDal.AddParam("@Classid", ddlClassname.SelectedValue);
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
            pnlManageUsers.Visible = true;
            pnlManageClass.Visible = false;
            pnlManageCourse.Visible = false;
        }
        protected void lbCourse_Click(object sender, EventArgs e)
        {
            loadNewCourse();
            pnlManageCourse.Visible = true;
            pnlManageUsers.Visible = false;
            pnlCourse.Visible = false;
        }
        private void loadNewCourse()
        {

            DataSet ds = new DataSet();
            myDal.ClearParams();
            //myDal.AddParam("@Classname", ddlCourseList.SelectedValue);
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetCourse");

            ddlCourses.DataSource = ds;
            ddlCourses.DataTextField = "Coursename";
            ddlCourses.DataValueField = "Courseid";
            ddlCourses.DataBind();

            ddlCourseforClass.DataSource = ds;
            ddlCourseforClass.DataTextField = "Coursename";
            ddlCourseforClass.DataValueField = "Courseid";
            ddlCourseforClass.DataBind();
        }

        protected void btnSaveCourse_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                myDal.ClearParams();
                myDal.AddParam("@Coursename", txtNewCourse.Text);
                myDal.ExecuteProcedure("SD18EXAM_spInsertCourse");
                loadNewCourse();
                txtNewCourse.Text = "";
            }

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
            myDal.AddParam("@Courseid", ddlCourseforClass.SelectedValue.ToString());
            myDal.AddParam("@Classname", txtNewClass.Text);
            myDal.ExecuteProcedure("SD18EXAM_spInsertClass");
            loadSelectClass();
            txtNewClass.Text = "";
        }

        protected void btnCreateCourse_Click(object sender, EventArgs e)
        {
            pnlNewCourse.Visible = true;
            pnlCourse.Visible = false;
            //btnCreateCourse.Visible = false;
            //btnEditDelete.Visible = false;
        }
        protected void btnedit_Click(object sender, EventArgs e)
        {
            pnlCourse.Visible = true;
            pnlNewCourse.Visible = false;
            UpdateCourse(Convert.ToInt16(ddlCourses.SelectedValue.ToString()));
        }
        protected void lbStudentLogHistory_Click(object sender, EventArgs e)
        {
            pnlManageClass.Visible = false;
            pnlManageCourse.Visible = false;
            pnlManageUsers.Visible = false;
            pnlCourse.Visible = false;
        }
        protected void lbClass_Click(object sender, EventArgs e)
        {
            pnlManageClass.Visible = true;
            pnlManageCourse.Visible = false;
            pnlManageUsers.Visible = false;
            pnlCourse.Visible = false;

        }
        private void UpdateCourse(int Courseid)
        {
            myDal.ClearParams();
            myDal.AddParam("Courseid", Courseid);
            DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spGetCourse");
            txtCourse.Text = ds.Tables[0].Rows[0]["Coursename"].ToString();
        }

        protected void btnUpdateCourse_Click(object sender, EventArgs e)
        {

        }

        protected void btnCourseUpdate_Click(object sender, EventArgs e)
        {//course name update
             string confirmValue = Request.Form["confirm_value"];
             if (confirmValue == "Yes")
             {
                 myDal.ClearParams();
                 myDal.AddParam("@Courseid", ddlCourses.SelectedValue.ToString());
                 myDal.AddParam("@NewCoursename", txtCourse.Text);
                DataSet ds = myDal.ExecuteProcedure("SD18EXAM_spUpdateCourse");
                if (ds.Tables[0].Rows[0]["status"].ToString() == "Success")
                    Response.Write("<SCRIPT>alert('Course successfully Updated!.')</SCRIPT>");
                else
                    Response.Write("<SCRIPT>alert('Update Failed.')</SCRIPT>");
                 loadNewCourse();

                 pnlCourse.Visible = false; 
             }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                myDal.ClearParams();
                myDal.AddParam("@Courseid", ddlCourses.SelectedValue.ToString());
                myDal.ExecuteProcedure("SD18EXAM_spDeleteCourse");
                loadNewCourse();
                Response.Write("<SCRIPT>alert('Course successfully deleted!.')</SCRIPT>");
            }
        }

        protected void btnCancelUpdate_Click(object sender, EventArgs e)
        {
            pnlCourse.Visible = false;
            txtCourse.Text = "";
        }

        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlCourse.Visible = false;
        }


    }
}