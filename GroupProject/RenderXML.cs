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

        public void XMLContent (string QuizVersionId)
        {
            XmlNamespaceManager ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            myDal.ClearParams();
            myDal.AddParam("@versionid", QuizVersionId);
            DataSet ds = new DataSet();
            ds = myDal.ExecuteProcedure("spGetQuizAndInfo");

        }
    }
}