<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="QuizPage.aspx.cs" Inherits="GroupProject.QuizPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="js/jquery-2.1.1.js"></script>
    <link href="styles/GroupPExam.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            answers = new Object();
            $('.option').change(function () {
                var answer = ($(this).attr('value'))
                if (answer == undefined)
                {
                    answer = ($(this).find("Option:selected").attr('value'))
                }
                var question = ($(this).attr('name'))
                var ChoicePosition = ($(this).attr('id'))
                if (ChoicePosition == undefined)
                {
                    ChoicePosition = ($(this).find("Option:selected").attr('id'))
                }
                // answers[question] = answer
                var select = [answer, ChoicePosition]
                answers[question] = select

            });
            var item1 = document.getElementById('Question');
            var currentQuestion = GetUserLastPage();        // user currently at. default = 0
            var currentPage = document.getElementById("PageNumber").innerHTML;
            currentPage = currentQuestion + 1;
            var totalQuestions = $('.Question').size();
            var result;
            var UserID;
            var NewXMLwithAnswers;
            $questions = $('.Question');
            $questions.hide();
            $($questions.get(currentQuestion)).fadeIn();     // show the current page

            function GetUserLastPage() {
                var xmlFile = getXML();
                XMLDoc = $.parseXML(xmlFile)
                $xmlFile = $(XMLDoc)
                $UserLastPage = $xmlFile.find("UserCurrentPage");
                if ($UserLastPage.length > 0) {//element exists
                    currentQuestion = $UserLastPage.text();
                    return currentQuestion
                }
                else {
                    return 0 //default = 0
                }
            }
            //GetUserLastPage()

            $('#next').click(function () {
                $($questions.get(currentQuestion)).fadeOut(function () {
                    currentQuestion = Number(currentQuestion) + 1;
                    result = sum_values()
                    if (currentQuestion == totalQuestions) {
                        
                        //do stuff with the result
                        SendToServerAndStatus();
                        alert(result);
                    }
                    else if(currentQuestion %3 == 0)
                    {
                        SendToServerAndStatus();// send to web server every 3 questions to reduce server load
                        $($questions.get(currentQuestion)).fadeIn();
                    }
                    else {
                        $($questions.get(currentQuestion)).fadeIn();
                    }
                });
            });
            $('#back').click(function () {
                $($questions.get(currentQuestion)).fadeOut(function () {
                    currentQuestion = Number(currentQuestion) - 1;
                    if (currentQuestion == totalQuestions) {
                        result = sum_values()
                        //do stuff with the result
                        //alert(result);
                    } else {
                        $($questions.get(currentQuestion)).fadeIn();
                    }
                });
            });
            function sum_values() {
                var the_sum = 0;
                for (questions in answers) {
                    the_sum = the_sum + parseInt(answers[questions][0])
                    var position = answers[questions][1]
                    var questionId = questions
                    questionId = questionId.replace('Question', '')
                    NewXMLwithAnswers = RecreateXML(questionId, position)
                    //var MyData ='{"QuestionID": "'+questionId.replace('Question','')+', "position"}'
                }
                if (NewXMLwithAnswers != null) {
                    UserID = '<%=HttpContext.Current.Session["Userid"]%>';
                    setSession(NewXMLwithAnswers)
                }
                return the_sum
            }

            function getXML() {
                var xmlFile;
                if (document.getElementById("tempXML").value != "") {
                    xmlFile = document.getElementById("tempXML").value;
                }
                else {
                    <%-- xmlFile = '<%=HttpContext.Current.Session["Quiz"]%>';--%>
                    xmlFile = '<%= HttpUtility.UrlDecode(HttpContext.Current.Session["Quiz"].ToString())%>';
                    <%--xmlFile = '<%= HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies["userQuiz"]["XML"].ToString())%>'--%>
                }
                return xmlFile;
            }
            function RecreateXML(QuestionID, UserAnswerPosition) {
                <%-- var xmlFile = '<%=HttpContext.Current.Session["Quiz"]%>';--%>
                var xmlFile = getXML();
                // var QuestionElement = $($.parseXML(xmlFile)).find("Question[ID=QuestionID]");
                XMLDoc = $.parseXML(xmlFile)
                $xmlFile = $(XMLDoc)

                //get user last known page
                $xmlDetails = $xmlFile.find("Details");
                $UserLastPage = $xmlFile.find("UserCurrentPage");
                if ($UserLastPage.length > 0) {//element exists
                    $xmlDetails.find('UserCurrentPage').each(function () {
                        $(this).text(currentQuestion);
                    })
                }
                else {//element do not exists yet on xml
                    $($.parseXML('<UserCurrentPage>' + currentQuestion + '</UserCurrentPage>')).find("UserCurrentPage").appendTo($xmlDetails);
                }

                $Question = $xmlFile.find("Question[ID='" + QuestionID + "']");
                //the UserAnswerPosition starts from 1 but the find xml content starts with 0; therefore we need to less the position by one
                fixPosition = UserAnswerPosition - 1 //for multiple choice only/ else set to NaN

                //test for TRUEFALSE
                if ($Question.parents("TrueFalse").length != 0) {
                    $OptionSelected = UserAnswerPosition
                }
                if ($Question.parents("MultipleChoice").length != 0)
                {
                    $Option = $xmlFile.find("Question[ID='" + QuestionID + "']").find("Options");
                    $Option = $Question.find("Options");
                    //$OptionSelected now holds the Answer of the user. the TEXT answer
                    $OptionSelected = $Option.find("Option:eq('" + fixPosition + "')").text();
                }
                if ($Question.parents("FillBlanks").length != 0) {
                    $Option = $xmlFile.find("Question[ID='" + QuestionID + "']").find("Options");
                    $Option = $Question.find("Options");
                    //$OptionSelected now holds the Answer of the user. the TEXT answer
                    $OptionSelected = $Option.find("Option:eq('" + fixPosition + "')").text();
                }
                
                //Append the OptionSelected to USERANSWER element
                if ($Question.attr('done') == undefined) {
                    $Question.attr('done', 'true'); //mark the question done!
                    $($.parseXML('<UserAnswer>' + $OptionSelected + '</UserAnswer>')).find("UserAnswer").appendTo($Question);

                }
                else {
                    $Question.attr('done', 'true'); //mark the question done!
                    //$($.parseXML('<UserAnswer>' + $OptionSelected + '</UserAnswer>')).replaceAll("UserAnswer").appendTo($Question);
                    $Question.find('UserAnswer').each(function () {
                        $(this).text($OptionSelected);
                    })
                    //$($.parseXML('<UserAnswer>' + $OptionSelected + '</UserAnswer>')).text("UserAnswer").appendTo($Question);
                }

                var XMLString;
                //IE
                if (window.ActiveXObject) {
                    XMLString = XMLDoc;
                }
                    // code for Mozilla, Firefox, Opera, etc.
                else {
                    XMLString = (new XMLSerializer()).serializeToString(XMLDoc);
                }
                document.getElementById("tempXML").value = XMLString
                return XMLString;

            }
            function setSession(XMLString) {
                //$("input:hidden[id$=tempXML]").val(XMLString)
                //                               .trigger('change');
                //var var1 = '{"var1": "' + XMLString + '"}'
                var var1 = '{"var1": "' + escape(XMLString) + '"}';
                var QuizStudentId = '<%=HttpContext.Current.Session["QuizStudentId"]%>';
                //var SendToServer = '{"var1": "' + escape(XMLString) + '", "var2": "' + UserID + '", "var3": "' + QuizStudentId + '", "var4": "' + result + '"}'
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    data: var1,
                    url: "QuizPage.aspx/SaveValueInSession",
                    dataType: "json",
                    success: function (data) {
                        //alert(data.d);
                        //SendToServerAndStatus(SendToServer);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        debugger;
                    }
                })
            }
            function SendToServerAndStatus() {
                var QuizStudentId = '<%=HttpContext.Current.Session["QuizStudentId"]%>';
                var SendToServer = '{"var1": "' + escape(NewXMLwithAnswers) + '", "var2": "' + UserID + '", "var3": "' + QuizStudentId + '", "var4": "' + result + '"}'
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    data: SendToServer,
                    url: "QuizHandler.ashx",
                    dataType: "json",
                    success: function (data, status) {
                        //alert(data.d);
                        console.log(data);
                        //alert(JSON.stringify(data));
                        alert(data.status)// getting the data.d values
                    },
                    error: function (error) {
                        alert("Error: " + error.status + "/ " +
                          error.statusText);
                        debugger;
                    }
                })
            }

        })

    </script>

    <div>
        <asp:Xml ID="XMLquiz" runat="server"></asp:Xml>
        <input type="button" id="back" name="back" value="BACK" />
        <input type="button" id="next" name="next" value="NEXT" />
        <input type="hidden" name="tempXML" id="tempXML" />
       
        <%--use the hiddenfield to SET the SESSION since it cannot set by SERVER using JAVASCRIPT. but i can retrieve it from USER BROWSER. --%>
    </div>
</asp:Content>
