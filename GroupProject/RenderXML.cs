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
            XmlNodeList nodes = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions", ns);
        }
    }
}