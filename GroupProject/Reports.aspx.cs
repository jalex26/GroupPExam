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

namespace GroupProject
{
    public partial class Reports : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        protected XmlNamespaceManager ns;
        protected XmlDocument XmlDoc = new XmlDocument();


        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security(2);

            if (!IsPostBack)
            {

            }
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
                    }
                    elese
                    {
                        lblMessage.Text = "No Issued Data to Display!";
                    }
                    break;

                case 1:
                    // Loads 'Offline Quizes' Report
                    lblMessage.Text = "";
                    DataSet ds = new DataSet();
                    myDal.ClearParams();
                    myDal.AddParam("@QuizStatus", 0);
                    ds = myDal.ExecuteProcedure("spGetQuizesByStatus");

                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        gvIssuedQuizes.DataSource = ds.Tables[0];
                        gvIssuedQuizes.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "No Offline Quizes to Display!";
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
                    }
                    else
                    {
                        lblMessage.Text = "No Online Quizes to Display!";
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
                    }
                    else
                    {
                        lblMessage.Text = "No Completed Quizes to Display!";
                    }
                    break;

                case 4:
                    // Loads 'Student Response Report' Report
                    break;

                case 5:
                    // Loads 'Graphical Interpretation of Student Response Report'
                    break;

                case 6:
                    // Graphical Analysis of Quiz Questions/ Test Data
                    break;

                default:
                    break;
            }
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

                //MPE1.Show();
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



    }
}