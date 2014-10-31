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
        public List<ObjectMultiple> ListMult = new List<ObjectMultiple>();
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
            foreach (XmlNode xn in GetQuestionMulti)
            {//top level multiple
                int QuestionId = Convert.ToInt16(xn.Attributes["ID"].Value);
                string Question = xn["Questi"].InnerText;
                XmlNodeList xno = xn.ChildNodes;

                XmlNodeList GetQuestionInfo = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/ns:Options", ns);
                string[] option = new string[4];
                string Correct = null;
                int x = 0;
                foreach (XmlNode xn2 in xn["Options"])
                {
                    option[x] = xn2.InnerText;
                    XmlNode node = xn2.Attributes["Correct"];
                    if (node != null)
                        Correct = xn2.InnerText;
                    x++;
                }
                ListMult.Add(new ObjectMultiple(QuestionId, Question, option[0], option[1], option[2], option[3], Correct.ToString()));
                
                //foreach()
            }
            ListMult.Shuffle(); //fisher-yates Shuffle method
            //int questionid = ListMult[1].QuestionId;
            //string question = ListMult[1].Question;
            //string option1 = ListMult[1].Option1;
            //string option2 = ListMult[1].Option2;
            //string option3 = ListMult[1].Option3;
            //string option4 = ListMult[1].Option4;
            //string correct = ListMult[1].Correct;
        }

        
    }
}