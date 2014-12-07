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
        public List<ObjectParentQuiz> ListQuestions = new List<ObjectParentQuiz>();
        public List<ObjectMultiple> ListMult = new List<ObjectMultiple>();
        public List<ObjectTrueFalse> ListTrueFalse = new List<ObjectTrueFalse>();
        public
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
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetQuizAndInfo");
            return ds;
        }

        // this dataset gets Student repsonse xml from database
        public DataSet XMLContent2(string QuizStudentid)
        {
            XmlNamespaceManager ns = new XmlNamespaceManager(XmlDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            myDal.ClearParams();
            myDal.AddParam("@QuizStudentid", QuizStudentid);
            DataSet ds = new DataSet();
            ds = myDal.ExecuteProcedure("SD18EXAM_spGetStudentResponseDetails");
            return ds;
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
                ds = myDal.ExecuteProcedure("SD18EXAM_spGetQuizAndInfo");
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
                    ProcessXML(XmlDoc);

                    //ListMult.Shuffle(); //fisher-yates Shuffle method
                }
            }
            if (Student.Value != null)
            {// generate new xml file

                ListQuestions.Shuffle();
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
                //Add XML NODE one by ONE
                //Multiple Choices
                foreach (ObjectMultiple mult in ListQuestions.OfType<ObjectMultiple>())
                {
                    XmlNode Multi = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:MultipleChoice", ns);

                    XmlElement Question = XmlNewDoc.CreateElement("Question", xmlNS);
                    Multi.AppendChild(Question);

                    XmlAttribute QuestionID = XmlNewDoc.CreateAttribute("ID");
                    QuestionID.Value = mult._QuestionId.ToString();
                    Question.Attributes.Append(QuestionID);

                    XmlNode Questio = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns);

                    XmlElement Questi = XmlNewDoc.CreateElement("Questi", xmlNS);
                    Questi.InnerText = mult._Question;
                    Questio.AppendChild(Questi);

                    XmlElement Options = XmlNewDoc.CreateElement("Options", xmlNS);
                    Questio.AppendChild(Options);

                    XmlElement Option1 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option2 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option3 = XmlNewDoc.CreateElement("Option", xmlNS);
                    XmlElement Option4 = XmlNewDoc.CreateElement("Option", xmlNS);
                    Option1.InnerText = mult._Option1;
                    Options.AppendChild(Option1);
                    Option2.InnerText = mult._Option2;
                    Options.AppendChild(Option2);
                    Option3.InnerText = mult._Option3;
                    Options.AppendChild(Option3);
                    Option4.InnerText = mult._Option4;
                    Options.AppendChild(Option4);
                    XmlAttribute Correct = XmlNewDoc.CreateAttribute("Correct");
                    Correct.Value = "yes";
                    if (mult._Correct == mult._Option1)
                        Option1.Attributes.Append(Correct);
                    else if (mult._Correct == mult._Option2)
                        Option2.Attributes.Append(Correct);
                    else if (mult._Correct == mult._Option3)
                        Option3.Attributes.Append(Correct);
                    else
                        Option4.Attributes.Append(Correct);
                    Question.AppendChild(Questi);
                    Question.AppendChild(Options);
                }
                foreach (ObjectTrueFalse TrueFalse in ListQuestions.OfType<ObjectTrueFalse>())
                {
                    XmlNode TF = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:TrueFalse", ns);

                    XmlElement Question = XmlNewDoc.CreateElement("Question", xmlNS);
                    TF.AppendChild(Question);

                    XmlAttribute QuestionID = XmlNewDoc.CreateAttribute("ID");
                    QuestionID.Value = TrueFalse._QuestionId.ToString();
                    Question.Attributes.Append(QuestionID);

                    XmlNode Questio = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question", ns);

                    XmlElement Questi = XmlNewDoc.CreateElement("Questi", xmlNS);
                    Questi.InnerText = TrueFalse._Question;
                    Questio.AppendChild(Questi);

                    XmlElement Answer = XmlNewDoc.CreateElement("Answer", xmlNS);
                    Answer.InnerText = TrueFalse._Answer;
                    Questio.AppendChild(Answer);

                    Question.AppendChild(Questi);
                    Question.AppendChild(Answer);
                }

                foreach (ObjectFillin FillBlank in ListQuestions.OfType<ObjectFillin>())
                {
                    XmlNode Fill = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:FillBlanks", ns);

                    XmlElement Question = XmlNewDoc.CreateElement("Question", xmlNS);
                    Fill.AppendChild(Question);

                    XmlAttribute QuestionID = XmlNewDoc.CreateAttribute("ID");
                    QuestionID.Value = FillBlank._QuestionId.ToString();
                    Question.Attributes.Append(QuestionID);

                    XmlNode Questio = XmlNewDoc.SelectSingleNode("/ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question", ns);

                    XmlElement Questi = XmlNewDoc.CreateElement("Questi", xmlNS);
                    Questi.InnerText = FillBlank._Question;
                    Questio.AppendChild(Questi);

                    XmlElement Options = XmlNewDoc.CreateElement("Options", xmlNS);
                    Questio.AppendChild(Options);


                    for (int i = 0; i < FillBlank._Option.Count; i++)
                    {
                        XmlElement Option = XmlNewDoc.CreateElement("Option", xmlNS);
                        Option.InnerText = FillBlank._Option[i];
                        Options.AppendChild(Option);
                        for (int x = 0; x < FillBlank._Correct.Count; x++)
                        {
                            if (FillBlank._Correct[x].Contains(FillBlank._Option[i].ToString()))
                            {
                                XmlAttribute Correct = XmlNewDoc.CreateAttribute("Correct");
                                Correct.Value = "yes";
                                Option.Attributes.Append(Correct);
                            }
                        }

                    }
                    Question.AppendChild(Questi);
                    Question.AppendChild(Options);
                }

                //save the newly generatedXML
                myDal.ClearParams();
                myDal.AddParam("@IssuedQuizId", IssueNewQuidId);
                myDal.AddParam("@UserId", Student.Value);
                myDal.AddParam("@XMLStudentResponse", XmlNewDoc.OuterXml);
                DataSet dsResultIssueQuiz = myDal.ExecuteProcedure("SD18EXAM_spIssueNewQuizStudent");

            }

        }

        private void ProcessXML(XmlDocument XmlNewDoc)
        {
            XmlNamespaceManager ns = new XmlNamespaceManager(XmlNewDoc.NameTable);
            ns.AddNamespace("ns", "urn:Question-Schema");
            XmlNodeList GetQuestionMulti = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns);
            XmlNodeList GetQuestionTrueFalse = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question", ns);
            XmlNodeList GetQuestionFillBlanks = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question", ns);

            // LoadXML(); // nothing here yet.
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
                option.Shuffle();
                //ListMult.Add(new ObjectMultiple(QuestionId, Question, option[0], option[1], option[2], option[3], Correct.ToString()));
                try
                {
                    ListQuestions.Add(new ObjectMultiple(QuestionId, Question, option[0], option[1], option[2], option[3], Correct.ToString()));
                }
                catch (Exception e)
                {
                   
                    throw;
                }
                
                //foreach()
            }

            //TRUE OR FALSE
            foreach (XmlNode xn in GetQuestionTrueFalse)
            {
                int QuestionId = Convert.ToInt16(xn.Attributes["ID"].Value);
                string Question = xn["Questi"].InnerText;
                string Answer = xn["Answer"].InnerText;
                XmlNodeList xno = xn.ChildNodes;
                ListQuestions.Add(new ObjectTrueFalse(QuestionId, Question, Answer));
            }


            foreach (XmlNode xn in GetQuestionFillBlanks)
            {//top level multiple
                int QuestionId = Convert.ToInt16(xn.Attributes["ID"].Value);
                string Question = xn["Questi"].InnerText;
                XmlNodeList xno = xn.ChildNodes;

                XmlNodeList GetQuestionInfo = XmlDoc.SelectNodes("/ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question/ns:Options", ns);
                List<string> options = new List<string>();
                List<string> correct = new List<string>();
                foreach (XmlNode xn2 in xn["Options"])
                {
                    options.Add(xn2.InnerText);
                    XmlNode node = xn2.Attributes["Correct"];
                    if (node != null)
                    {
                        correct.Add(xn2.InnerText);
                    }
                }
                ListQuestions.Add(new ObjectFillin(QuestionId, Question, correct, options));
                //foreach()
            }

            ListQuestions.Shuffle();
        }


    }
}