using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;
using System.Data;
using DAL_Project;
using System.IO;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;



namespace GroupProject
{
    public partial class Reports : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        LoadBoxes LB = new LoadBoxes();
        protected XmlNamespaceManager ns;
        protected XmlDocument XmlDoc = new XmlDocument();


        protected void Page_Load(object sender, EventArgs e)
        {
            //Security mySecurity = new Security(2);

            // makes login panel on masterpage invisible
            Panel myPanel = (Panel)Master.FindControl("pnlLogin");
            myPanel.Visible = false;

            if (!IsPostBack)
            {
                loadCourse();
            }
        }

        private void loadCourse()
        {
            DataSet ds = LB.LoadCourse();
            ddlCourse.DataTextField = "Coursename";
            ddlCourse.DataValueField = "Courseid";
            ddlCourse.DataSource = ds;
            ddlCourse.DataBind();
            ddlCourse.Items.Insert(0, new ListItem("-Select Course-", String.Empty));
            ddlCourse.SelectedIndex = 0;
        }


        private void loadReports()
        {
            int SelectedReport = ddlReports.SelectedIndex;

            switch (SelectedReport)
            {
                case 0:

                    // Loads 'Issued Quizes' Report
                    DataSet ds = new DataSet();
                    myDal.ClearParams();
                    ds = myDal.ExecuteProcedure("spGetIssuedQuizes");

                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        gvIssuedQuizes.DataSource = ds.Tables[0];
                        gvIssuedQuizes.DataBind();
                        gvIssuedQuizes.Visible = true;

                    }
                    else
                    {
                        lblMessage.Text = "No Issued Data to Display!";
                        gvIssuedQuizes.Visible = false;
                    }

                    break;

                case 1:
                    // Loads 'Offline Quizes' Report
                    lblMessage.Text = "";
                    DataSet ds2 = new DataSet();
                    myDal.ClearParams();
                    myDal.AddParam("@QuizStatus", 0);
                    ds2 = myDal.ExecuteProcedure("spGetQuizesByStatus");

                    if (ds2.Tables[0].Rows.Count != 0)
                    {
                        gvIssuedQuizes.DataSource = ds2.Tables[0];
                        gvIssuedQuizes.DataBind();
                        gvIssuedQuizes.Visible = true;
                    }
                    else
                    {
                        lblMessage.Text = "No Offline Quizes to Display!";
                        gvIssuedQuizes.Visible = false;
                    }

                    break;

                case 2:
                    // Loads 'Online Quizes' Report    
                    lblMessage.Text = "";
                    myDal.ClearParams();
                    myDal.AddParam("@QuizStatus", 1);
                    ds = myDal.ExecuteProcedure("spGetQuizesByStatus");

                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        gvIssuedQuizes.DataSource = ds.Tables[0];
                        gvIssuedQuizes.DataBind();
                        gvIssuedQuizes.Visible = true;
                    }
                    else
                    {
                        lblMessage.Text = "No Online Quizes to Display!";
                        gvIssuedQuizes.Visible = false;
                    }
                    break;

                case 3:
                    // Loads 'Completed Quizes' Report        
                    lblMessage.Text = "";
                    myDal.ClearParams();
                    myDal.AddParam("@QuizStatus", 2);
                    ds = myDal.ExecuteProcedure("spGetQuizesByStatus");

                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        gvIssuedQuizes.DataSource = ds.Tables[0];
                        gvIssuedQuizes.DataBind();
                        gvIssuedQuizes.Visible = true;
                    }
                    else
                    {
                        lblMessage.Text = "No Completed Quizes to Display!";
                        gvIssuedQuizes.Visible = false;
                    }
                    break;

                case 4:
                    // Loads 'Student Response Report' Report
                   
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report1.rdlc");
                    ReportDataSource datasource = new ReportDataSource("dsStudentResponse", GetStudentResponseData());
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(datasource);

                    break;

                case 5:
                    // Loads 'Quiz Analysis'
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report2.rdlc");
                    ReportDataSource datasource2 = new ReportDataSource("dsQuizDetails", GetQuizDetailsData());
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(datasource2);
                    break;

                case 6:
                    // Graphical Analysis of Quiz Questions/ Test Data


                    break;

                default:
                    break;
            }
        }

        public DataTable GetStudentResponseData()
        {
            myDal.ClearParams();
            myDal.AddParam("@CourseID", ddlCourse.SelectedValue.ToString());
            myDal.AddParam("@XMLQuizID", ddlQuiz.SelectedValue.ToString());
            return myDal.ExecuteProcedure("spGetStudentResponseReport").Tables[0];
        }

        public DataTable GetQuizDetailsData()
        {
            myDal.ClearParams();        
            myDal.AddParam("@Versionid", ddlVersion.SelectedValue.ToString());
            return myDal.ExecuteProcedure("spGetQuizDetails").Tables[0];
        }

        protected void btnViewReport_Click(object sender, EventArgs e)
        {
            loadReports();
        }

        protected void repIssuedQuizes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if ((e.CommandName.ToString()) == "View")
            {
                int VersionID = Convert.ToInt32(e.CommandArgument.ToString());

                RenderXML RX = new RenderXML();

                DataSet ds = RX.XMLContent(VersionID.ToString());
                XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());

                ns = new XmlNamespaceManager(XmlDoc.NameTable);
                ns.AddNamespace("ns", "urn:Question-Schema");
                string xpath = "/ns:Quiz";
                XmlNodeList QuizNode = XmlDoc.SelectNodes(xpath, ns);

                DLExamDemo.DataSource = QuizNode;
                DLExamDemo.DataBind();

            }
        }


        protected void btnPopUpClose_Click(object sender, EventArgs e)
        {
            MPE1.Hide();
        }

        protected void lbViewQuiz_Click(object sender, EventArgs e)
        {
            LinkButton linkUpdate = sender as LinkButton;
            GridViewRow grid = (GridViewRow)linkUpdate.NamingContainer;
            string tempID = gvIssuedQuizes.DataKeys[grid.RowIndex].Value.ToString();
            ViewState["tempId"] = tempID;
           
            RenderXML RX = new RenderXML();

            DataSet ds = RX.XMLContent(tempID);
            XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());

            ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            string xpath = "/ns:Quiz";
            XmlNodeList QuizNode = XmlDoc.SelectNodes(xpath, ns);
            DLExamDemo.DataSource = QuizNode;
            DLExamDemo.DataBind();
            MPE1.Show();

        }

        //private void LoadQuizPieChart()
        //{
        //    pieChartQuizDetails.Visible = true;
        //    DataSet ds = new DataSet();
        //    myDal.ClearParams();
        //    myDal.AddParam("@Versionid", HttpContext.Current.Session["Versionid"].ToString());
        //    ds = myDal.ExecuteProcedure("spGetQuizDetails");
        //    GridView1.DataSource = ds;
        //    GridView1.DataBind();

        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        pieChartQuizDetails.PieChartValues.Add(new AjaxControlToolkit.PieChartValue
        //            {
        //                Category = "Multiple Choice",
        //                Data = Convert.ToInt32(ds.Tables[0].Rows[0]["MultipleChoiceCount"]),
        //                PieChartValueColor = "#6C1E83",
        //                PieChartValueStrokeColor = "#000"
        //            });

        //        pieChartQuizDetails.PieChartValues.Add(new AjaxControlToolkit.PieChartValue
        //        {
        //            Category = "Fill in the Blanks",
        //            Data = Convert.ToInt32(ds.Tables[0].Rows[0]["FillBlanksCount"]),
        //            PieChartValueColor = "#D08AD9",
        //            PieChartValueStrokeColor = "#000"
        //        });

        //        pieChartQuizDetails.PieChartValues.Add(new AjaxControlToolkit.PieChartValue
        //        {
        //            Category = "True or False",
        //            Data = Convert.ToInt32(ds.Tables[0].Rows[0]["TrueFalseCount"]),
        //            PieChartValueColor = "#09C",
        //            PieChartValueStrokeColor = "#000"
        //        });
        //    }
        //}

        protected void ddlReports_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddlReports.SelectedIndex)
            {
                case 0:
                    pnlAdditionalDetails.Visible = false;
                    break;
                case 1:
                    pnlAdditionalDetails.Visible = false;
                    break;
                case 2:
                    pnlAdditionalDetails.Visible = false;
                    break;
                case 3:
                    pnlAdditionalDetails.Visible = false;
                    break;
                case 4:
                    pnlAdditionalDetails.Visible = true;
                    break;
                case 5:
                    pnlAdditionalDetails.Visible = true;
                    pnlClass.Visible = false;

                    break;
                case 6:
                    pnlAdditionalDetails.Visible = false;
                    break;
                default:
                    break;
            }

         
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = LB.LoadClasses(ddlCourse.SelectedValue.ToString());
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "Classid";
            ddlClass.DataSource = ds;
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("-Select Class-", String.Empty));
            ddlClass.SelectedIndex = 0;

            // loads available quizes based on Course ID
            DataSet ds1 = LB.LoadQuizes(ddlCourse.SelectedValue.ToString());
            ddlQuiz.DataTextField = "Title";
            ddlQuiz.DataValueField = "XMLQuizID";
            ddlQuiz.DataSource = ds1;
            ddlQuiz.DataBind();
            ddlQuiz.Items.Insert(0, new ListItem("-Select Quiz-", String.Empty));
            ddlQuiz.SelectedIndex = 0;
           
        }

        protected void ddlQuiz_SelectedIndexChanged(object sender, EventArgs e)
        {            
            DataSet ds = LB.LoadQuizVersions(ddlQuiz.SelectedValue.ToString());
            ddlVersion.DataTextField = "Version";
            ddlVersion.DataValueField = "Versionid";
            ddlVersion.DataSource = ds;
            ddlVersion.DataBind();
            ddlVersion.Items.Insert(0, new ListItem("-Select Quiz-", String.Empty));
            ddlVersion.SelectedIndex = 0;
        }


    }

}
