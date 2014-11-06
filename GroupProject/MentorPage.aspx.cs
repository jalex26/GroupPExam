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
    public partial class MentorPage : System.Web.UI.Page
    {
        DAL myDal = new DAL(Globals.conn);
        LoadBoxes LB = new LoadBoxes();
        protected XmlNamespaceManager ns;
        protected XmlDocument XmlDoc = new XmlDocument();

        protected void Page_Load(object sender, EventArgs e)
        {
          
            Security mySecurity = new Security(2);

            if (!IsPostBack)
            {
                loadCourse();
                loadQuiz();
                ViewQuiz();
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

        public void loadQuiz()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Courseid", ddlCourse.SelectedValue.ToString());
            ds = myDal.ExecuteProcedure("spLoadQuizes");

            ddlSelectQuiz.DataTextField = "Title";
            ddlSelectQuiz.DataValueField = "XMLQuizID";
            ddlSelectQuiz.DataSource = ds;
            ddlSelectQuiz.DataBind();
            ddlSelectQuiz.Items.Insert(0, new ListItem("-Select Quiz-", String.Empty));
            ddlSelectQuiz.SelectedIndex = 0;

        }
        public void loadStudents()
        {
            DataSet ds = LB.LoadStudents(ddlClass.SelectedValue.ToString());
            cblStudents.DataTextField = "Studentname";
            cblStudents.DataValueField = "Userid";
            cblStudents.DataSource = ds;
            cblStudents.DataBind();

        }

        public void ViewQuiz()
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            ds = myDal.ExecuteProcedure("spViewQuiz");
            gvViewQuiz.DataSource = ds;
            gvViewQuiz.DataBind();
        }

        protected void btnIssueQuiz_Click(object sender, EventArgs e)
        {

            pnlIssueQuiz.Visible = true;
            pnlUploadQuiz.Visible = false;
            gvViewQuiz.Visible = false;
            pnlStartQuiz.Visible = false;
        }

        protected void btnUploadQuiz_Click(object sender, EventArgs e)
        {
            //Response.Redirect("MentorPage.aspx");
            pnlUploadQuiz.Visible = true;
            pnlIssueQuiz.Visible = false;
            gvViewQuiz.Visible = false;
            pnlStartQuiz.Visible = false;
        }

        protected void btnViewQuiz_Click(object sender, EventArgs e)
        {
            gvViewQuiz.Visible = true;
            pnlIssueQuiz.Visible = false;
            pnlUploadQuiz.Visible = false;
            pnlStartQuiz.Visible = false;
        }

        // method to remove all namespaces from xml document
        private void RemoveNamespaceAttributes(XmlNode node)
        {

            if (node.Attributes != null)
            {
                for (int i = node.Attributes.Count - 1; i >= 0; i--)
                {
                    if (node.Attributes[i].Name.Contains(':') || node.Attributes[i].Name == "xmlns")
                        node.Attributes.Remove(node.Attributes[i]);
                }
            }

            foreach (XmlNode n in node.ChildNodes)
            {
                RemoveNamespaceAttributes(n);
            }
        }


        // this button validates xml file and then saves it in a temporary folder 'tempXML'
        protected void btnUploadFile_Click(object sender, EventArgs e)
        {
            XmlDocument fullXml;

            string fileName = Path.GetFileName(fuploadQuiz.PostedFile.FileName);

            string serverPath = Server.MapPath(".") + "\\tempXML\\";
            string strUploadPath = System.IO.Path.GetFileName(fuploadQuiz.PostedFile.FileName.ToString());
            fuploadQuiz.PostedFile.SaveAs(serverPath + strUploadPath);
            string fullFilePath;
            fullFilePath = serverPath + fuploadQuiz.FileName.ToString();

            // saving xml file content in a string to pass it to stored proc later
            string xml = File.ReadAllText(fullFilePath);

            // validating xml file here before inserting into database
            string xsd = Server.MapPath(".") + "\\" + "validator.xsd";
            OpenValidate OV = new OpenValidate();
            OV.ValidateXml(fullFilePath, xsd);
            if (OV.failed)
            {
                Response.Write("<script>alert('The selected file is not in correct format. Please check before trying again!');</script>");
            }

            // after validation removing al namespaces from xml file before inserting in database
            fullXml = new XmlDocument();
            fullXml.LoadXml(xml);
            RemoveNamespaceAttributes(fullXml.DocumentElement);

            // saving xml data in database if file is in correct format
            XmlTextReader xmlreader = new XmlTextReader(serverPath + fileName);
            DataSet ds = new DataSet();
            ds.ReadXml(xmlreader);
            xmlreader.Close();
            if (ds.Tables.Count != 0)
            {
                try
                {
                    myDal.ClearParams();
                    myDal.AddParam("@xml", xml);
                    myDal.ExecuteProcedure("spInsertXMLContent");
                }
                catch (Exception)
                {
                    System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('Error uploading the file or Unkown extension')</SCRIPT>");
                }
                

            }
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            cblStudents.Items.Clear();
            DataSet ds = LB.LoadClasses(ddlCourse.SelectedValue.ToString());
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "Classid";
            ddlClass.DataSource = ds;
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("-Select Class-", String.Empty));
            ddlClass.SelectedIndex = 0;

            DataSet ds1 = LB.LoadQuizes(ddlCourse.SelectedValue.ToString());
            ddlSelectQuiz.DataTextField = "Title";
            ddlSelectQuiz.DataValueField = "XMLQuizID";
            ddlSelectQuiz.DataSource = ds1;
            ddlSelectQuiz.DataBind();
            ddlSelectQuiz.Items.Insert(0, new ListItem("-Select Quiz-", String.Empty));
            ddlSelectQuiz.SelectedIndex = 0;
            lblQuizDuration.Text = "Select quiz first";
        }

        protected void ddlSelectQuiz_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblQuizDuration.Text = "Select quiz first";
            DataSet ds = LB.LoadQuizVersions(ddlSelectQuiz.SelectedValue.ToString());
            ddlVersion.DataTextField = "Version";
            ddlVersion.DataValueField = "Versionid";
            ddlVersion.DataSource = ds;
            ddlVersion.DataBind();
            ddlVersion.Items.Insert(0, new ListItem("-Select Quiz-", String.Empty));
            ddlVersion.SelectedIndex = 0;
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadStudents();
            //ScriptManager.RegisterStartupScript(this, GetType(), "CheckAll", "CheckAll('btnUploadFile');", true);
            foreach (ListItem item in cblStudents.Items)
            {//default: all Students are selected
                item.Selected = true;
            }
        }

        protected void ddlVersion_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            ds = LB.LoadQuizInfo(ddlVersion.SelectedValue.ToString());
            lblQuizDuration.Text = ds.Tables[0].Rows[0]["Time"].ToString() + " minutes";
        }

        private void ViewQuizPopUp()
        {
            RenderXML RX = new RenderXML();

            DataSet ds = RX.XMLContent(ddlVersion.SelectedValue.ToString());
            XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());

            ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            string xpath = "/ns:Quiz";
            XmlNodeList QuizNode = XmlDoc.SelectNodes(xpath, ns);
            //string x= XmlDoc.InnerXml;
            //DataSet ds1 = new DataSet();
            //ds1.ReadXml(new StringReader(x));
            // string serverPath = Server.MapPath(".") + "\\XSLT_Files\\";

            //  XmlDataSource xmlDS = new XmlDataSource();
            //  xmlDS.Data = XmlDoc.OuterXml;
            //xmlDS.TransformFile = serverPath + "QuestionX.xslt";
            // xmlDS.XPath = "Quiz";

            DLExamDemo.DataSource = QuizNode;
            DLExamDemo.DataBind();
            MPE1.Show();

        }

        // this is Quiz Preview on Issue Quiz button
        protected void btnViewDemoQuiz_Click(object sender, EventArgs e)
        {
            ViewQuizPopUp();
        }

        protected void btnPopUpClose_Click(object sender, EventArgs e)
        {
            MPE1.Hide();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            myDal.ClearParams();
            myDal.AddParam("@Versionid", ddlVersion.SelectedValue.ToString());
            myDal.AddParam("@ClassId", ddlClass.SelectedValue.ToString());
            myDal.AddParam("@Mentorid", HttpContext.Current.Session["Userid"].ToString());
            DataSet dsGetNewIssueQuizId = myDal.ExecuteProcedure("spIssueNewQuiz");
            string NewId = null;

            if (dsGetNewIssueQuizId.Tables[0].Columns["IssuedQuizId"] != null)
                NewId = dsGetNewIssueQuizId.Tables[0].Rows[0]["IssuedQuizId"].ToString();

            if (NewId != null)
            {
                foreach (ListItem Student in cblStudents.Items)
                {//default: all Students are selected
                    if (Student.Selected == true)
                    {
                        RenderXML RX = new RenderXML();
                        RX.GetNRandomizeXMLContent(ddlVersion.SelectedValue.ToString(), Student, NewId);
                        //RenderXML RX = new RenderXML();
                        //RX.GetNRandomizeXMLContent(ddlVersion.SelectedValue.ToString());
                    }
                }
            }
        }

        // this is quiz preview on View Quiz button
        protected void lbViewQuiz_Click(object sender, EventArgs e)
        {
            LinkButton linkUpdate = sender as LinkButton;
            GridViewRow grid = (GridViewRow)linkUpdate.NamingContainer;
            string tempID = gvViewQuiz.DataKeys[grid.RowIndex].Value.ToString();
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

        protected void btnStartQuiz_Click(object sender, EventArgs e)
        {
            pnlIssueQuiz.Visible = false;
            pnlUploadQuiz.Visible = false;
            gvViewQuiz.Visible = false;

            myDal.ClearParams();
            myDal.AddParam("@Userid",HttpContext.Current.Session["Userid"].ToString());
            DataSet ds = myDal.ExecuteProcedure("spGetIssuedQuizByMentor");
            if(ds.Tables[0].Rows.Count != 0)
            {
                pnlStartQuiz.Visible = true;
                gvQuizes.DataSource = ds.Tables[0];
                gvQuizes.DataBind();
            }
            
        }

        protected void gvQuizes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Action")
            {
                int IssuedQuizId = -1;
                gvQuizes.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
                IssuedQuizId = Convert.ToInt32(gvQuizes.SelectedDataKey.Values[0].ToString());
                PopUpQuizAction(IssuedQuizId);
            }
        }
        private void PopUpQuizAction(int IssuedQuizId)
        {
            if (IssuedQuizId != -1)
                {
                    myDal.ClearParams();
                    myDal.AddParam("@IssuedQuizId", IssuedQuizId.ToString());
                    DataSet ds = myDal.ExecuteProcedure("getIssuedQuizDetails");
                    if(ds.Tables[0].Rows.Count != 0)
                    {
                        lblIssuedQuizId.Text = ds.Tables[0].Rows[0]["IssuedQuizId"].ToString();
                        lblTitle.Text = ds.Tables[0].Rows[0]["Title"].ToString();
                        lblTime.Text = ds.Tables[0].Rows[0]["Time"].ToString();
                        lblClass.Text = ds.Tables[0].Rows[0]["Classname"].ToString();
                        lblStatus.Text = ds.Tables[0].Rows[0]["StatusName"].ToString();
                        
                        MPEQuizAction.Show();
                    }
                }
        }

        protected void btnCreateQuiz_Click(object sender, EventArgs e)
        {
            pnlStartQuiz.Visible = false;
        }

        protected void btnClosePopUp_Click(object sender, EventArgs e)
        {
            MPEQuizAction.Hide();
        }

        protected void btnStart_Click(object sender, EventArgs e)
        {
            //MPEQuizAction.Show();
            myDal.ClearParams();
            myDal.AddParam("@IssuedQuizId", lblIssuedQuizId.Text);
            DataSet ds = myDal.ExecuteProcedure("spStartQuiz");
            PopUpQuizAction(Convert.ToInt32(lblIssuedQuizId.Text));

        }

    }
}