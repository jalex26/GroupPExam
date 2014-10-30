using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using DAL_Project;
using System.Data;

namespace GroupProject
{
    public class RenderXML
    {
        XmlDocument XmlDoc = new XmlDocument();
        DAL myDal = new DAL(Globals.conn);
        private ObjectMultiple myOM = new ObjectMultiple();
        public List<ObjectMultiple> ListMult;
        public RenderXML()
        {
            LoadXML();
        }

        private void LoadXML()
        {
            if (HttpContext.Current.Session["TransformQuiz"] != null)
            {//load object
                myOM = (ObjectMultiple)HttpContext.Current.Session["TransformQuiz"];
            }
        }

        public DataSet XMLContent(string QuizVersionId)
        {
            XmlNamespaceManager ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            myDal.ClearParams();
            myDal.AddParam("@versionid", QuizVersionId);
            DataSet ds = new DataSet();
            ds = myDal.ExecuteProcedure("spGetQuizAndInfo");
            return ds;

            //XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());
            //XmlNodeList nodes = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions", ns);
            //foreach (XmlNode xn in nodes)
            //{

            //}
        }

        public void GetNRandomizeXMLContent(string QuizVersionId)
        {
            XmlNamespaceManager ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            myDal.ClearParams();
            myDal.AddParam("@versionid", QuizVersionId);
            DataSet ds = new DataSet();
            ds = myDal.ExecuteProcedure("spGetQuizAndInfo");
            XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());
            XmlNodeList GetQuestionMulti = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns);

            LoadXML();
            foreach(XmlNode xn in GetQuestionMulti)
            {//top level multiple
                string QuestionId = xn.Attributes["ID"].Value;
                XmlNodeList GetQuestionInfo = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/", ns);
                //foreach()

            }

            //ListMult.Add(new ObjectMultiple())
        }
    }
}