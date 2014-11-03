using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using DAL_Project;
using System.Data;
using System.Web.UI.WebControls;

namespace GroupProject
{
    public class RenderXML
    {
        XmlDocument XmlDoc = new XmlDocument();
        DAL myDal = new DAL(Globals.conn);
        //private ObjectMultiple myOM = new ObjectMultiple();
        public List<ObjectMultiple> ListMult = new List<ObjectMultiple>();
        const string xmlNS = "urn:Question-Schema";
        XmlNode QuestionsNode;
        public RenderXML()
        {
            LoadXML();
        }

        private void LoadXML()
        {
            //if (HttpContext.Current.Session["TransformQuiz"] != null)
            //{//load object
            //    myOM = (ObjectMultiple)HttpContext.Current.Session["TransformQuiz"];

            //}
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

        public void GetNRandomizeXMLContent(string QuizVersionId, ListItem Student, string IssueNewQuidId)
        {
            //DECLARATIONS
            int QuizId = -1; //null
            string QuizTitle = null;
            string QuizSubject = null;
            string QuizCourse = null;
            int QuizTime = -1;
            string QuizDifficulty = null;

            if (XmlDoc.ChildNodes.Count == 0)// empty xmldoc
            {// populate XmlDoc the first time it runs.
                XmlNamespaceManager ns = new XmlNamespaceManager(XmlDoc.NameTable);
                ns.AddNamespace("ns", "urn:Question-Schema");
                myDal.ClearParams();
                myDal.AddParam("@versionid", QuizVersionId);
                DataSet ds = new DataSet();
                ds = myDal.ExecuteProcedure("spGetQuizAndInfo");
                if (ds.Tables[0].Rows.Count != 0)
                {
                    XmlDoc.LoadXml(ds.Tables[0].Rows[0]["XmlFile"].ToString());
                    //Get Quiz Details
                    QuizId = Convert.ToInt32(ds.Tables[0].Rows[0]["XMLQuizID"].ToString());
                    XmlNodeList nodes = XmlDoc.SelectNodes("/ns:Quiz/ns:Details", ns);
                    foreach (XmlNode xn in nodes)
                    {
                        QuizTitle = xn["Title"].InnerText;
                        QuizSubject = xn["Subject"].InnerText;
                        QuizTime = Convert.ToInt16(xn["Time"].InnerText);
                        QuizDifficulty = xn["Difficulty"].InnerText;
                        QuizCourse = xn["Course"].InnerText;
                    }
                    XmlNodeList GetQuestionMulti = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns);

                    LoadXML(); // nothing here yet.
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
            if (Student.Value != null)
            {// generate new xml file

                ListMult.Shuffle();
                XmlDocument XmlNewDoc = new XmlDocument();
                XmlNamespaceManager ns = new XmlNamespaceManager(XmlNewDoc.NameTable);
                ns.AddNamespace("ns", "urn:Question-Schema");
                XmlElement rootNode = XmlNewDoc.CreateElement("Quiz", xmlNS);
                rootNode.SetAttribute("QuizId", QuizId.ToString());
                rootNode.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
                XmlNewDoc.AppendChild(rootNode);
                rootNode = XmlNewDoc.DocumentElement;

                XmlNode detailsNode = XmlNewDoc.CreateElement("Details", xmlNS);
                rootNode.AppendChild(detailsNode);

                XmlElement Title = XmlNewDoc.CreateElement("Title", xmlNS);
                detailsNode.AppendChild(Title);

                XmlElement Subject = XmlNewDoc.CreateElement("Subject", xmlNS);
                detailsNode.AppendChild(Subject);

                XmlElement Category = XmlNewDoc.CreateElement("Course", xmlNS);
                detailsNode.AppendChild(Category);

                XmlElement Time = XmlNewDoc.CreateElement("Time", xmlNS);
                detailsNode.AppendChild(Time);

                XmlElement Difficulty = XmlNewDoc.CreateElement("Difficulty", xmlNS);
                detailsNode.AppendChild(Difficulty);

                Title.InnerText = QuizTitle;
                Subject.InnerText = QuizSubject;
                Category.InnerText = QuizCourse;
                Time.InnerText = QuizTime.ToString();
                Difficulty.InnerText = QuizDifficulty;
                QuestionsNode = XmlNewDoc.CreateElement("Questions", xmlNS);
                rootNode.AppendChild(QuestionsNode);

                XmlElement MultipleChoiceNode = XmlNewDoc.CreateElement("MultipleChoice", xmlNS);
                QuestionsNode.AppendChild(MultipleChoiceNode);

                XmlElement FillBlanksNode = XmlNewDoc.CreateElement("FillBlanks", xmlNS);
                QuestionsNode.AppendChild(FillBlanksNode);

                XmlElement TrueFalseNode = XmlNewDoc.CreateElement("TrueFalse", xmlNS);
                QuestionsNode.AppendChild(TrueFalseNode);

                XmlElement longAnswer = XmlNewDoc.CreateElement("longAnswer", xmlNS);
                QuestionsNode.AppendChild(longAnswer);
                //Add XML NODE one by ONE
                //Multiple Choices
                foreach (ObjectMultiple mult in ListMult)
                {
                    XmlNode Multi = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:MultipleChoice", ns);

                    XmlElement Question = XmlNewDoc.CreateElement("Question", xmlNS);
                    Multi.AppendChild(Question);

                    XmlAttribute QuestionID = XmlNewDoc.CreateAttribute("ID");
                    QuestionID.Value = mult.QuestionId.ToString();
                    Question.Attributes.Append(QuestionID);

                    XmlNode Questio = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns);

                    XmlElement Questi = XmlNewDoc.CreateElement("Questi", xmlNS);
                    Questi.InnerText = mult.Question;
                    Questio.AppendChild(Questi);

                    XmlElement Options = XmlNewDoc.CreateElement("Options", xmlNS);
                    Questio.AppendChild(Options);

                    XmlElement Option1 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option2 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option3 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option4 = XmlNewDoc.CreateElement("Option", xmlNS);
                    Option1.InnerText = mult.Option1;
                    Options.AppendChild(Option1);
                    Option2.InnerText = mult.Option2;
                    Options.AppendChild(Option2);
                    Option3.InnerText = mult.Option3;
                    Options.AppendChild(Option3);
                    Option4.InnerText = mult.Option4;
                    Options.AppendChild(Option4);
                    XmlAttribute Correct = XmlNewDoc.CreateAttribute("Correct");
                    Correct.Value = "yes";
                    if (mult.Correct == mult.Option1)
                        Option1.Attributes.Append(Correct);
                    else if (mult.Correct == mult.Option2)
                        Option2.Attributes.Append(Correct);
                    else if (mult.Correct == mult.Option3)
                        Option3.Attributes.Append(Correct);
                    else
                        Option4.Attributes.Append(Correct);
                    Question.AppendChild(Questi);
                    Question.AppendChild(Options);
                }

                //save the newly generatedXML
                myDal.ClearParams();
                myDal.AddParam("@IssuedQuizId", IssueNewQuidId);
                myDal.AddParam("@UserId", Student.Value);
                myDal.AddParam("@XMLStudentResponse", XmlNewDoc.OuterXml);
                DataSet dsResultIssueQuiz = myDal.ExecuteProcedure("spIssueNewQuizStudent");

            }

        }


    }
}