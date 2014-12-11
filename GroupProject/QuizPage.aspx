<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="QuizPage.aspx.cs" Inherits="GroupProject.QuizPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">

        <asp:Panel ID="pnlQuiz" HorizontalAlign="Center" runat="server">

            <img src="Pictures/Quiz.jpg" style="width: 750px; height: 246px;" />
            <br />
            <h2>Welcome to the Online Test Page! </h2>

        </asp:Panel>

        <script src="js/jquery-2.1.1.js"></script>
        <link href="styles/GroupPExam.css" rel="stylesheet" />
        <script type="text/javascript">
            $(document).ready(function () {
                answers = new Object();
                $('.option').change(function () {
                    var answer = ($(this).attr('value'))
                    if (answer == undefined) {
                        answer = ($(this).find("Option:selected").attr('value'))
                    }
                    var question = ($(this).attr('name'))
                    var ChoicePosition = ($(this).attr('id'))
                    if (ChoicePosition == undefined) {
                        ChoicePosition = ($(this).find("Option:selected").attr('id'))
                    }
                    // answers[question] = answer
                    var select = [answer, ChoicePosition]
                    answers[question] = select

                });
                var item1 = document.getElementById('Question');
                var currentQuestion = GetUserLastPage();        // user currently at. default = 0
                var currentPage = currentQuestion + 1;
                $('[id="PageNumber"]').val(currentPage);
                //$('[id="PageNumber"]')
                var totalQuestions = $('.Question').size();
                var result;
                var isDone = false;
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
                    //prevent double clicks first!! set timeout
                    var $this = jQuery(this);
                    if ($this.data('activated')) return false;  // Pending, return

                    $this.data('activated', true);
                    setTimeout(function () {
                        $this.data('activated', false)
                    }, 1000); // Freeze for 1000ms

                    showNext();
                    //do_all_functions();
                    return false;
                });

                function ConfirmEndQuiz() {
                    if (confirm("End Quiz?")) {
                        EndNowQuiz();
                        $('input[id=Finish]').hide();
                    }
                }
                $('#Finish').click(function () {
                    //prevent double clicks first!! set timeout
                    var $this = jQuery(this);
                    if ($this.data('activated')) return false;  // Pending, return

                    $this.data('activated', true);
                    setTimeout(function () {
                        $this.data('activated', false)
                    }, 1000); // Freeze for 1000ms

                    ConfirmEndQuiz();
                    //do_all_functions();
                    return false;
                });

                function EndNowQuiz() {
                    isDone = true;
                    $('input[name=back]').hide();
                    $('input[name=next]').hide();
                    $('#<%= pnlQuizItem.ClientID %>').toggle()
                    $('#<%= pnlQuizResult.ClientID %>').toggle()
                    SendToServerAndStatus();
                }

                function showNext() {
                    $($questions.get(currentQuestion)).fadeOut(function () {
                        currentQuestion = Number(currentQuestion) + 1;
                        result = sum_values()
                        var currentPage = currentQuestion + 1; //gets the current showing page
                        $('[id="PageNumber"]').val(currentPage);
                        if (currentQuestion == totalQuestions - 1 || currentQuestion > totalQuestions) {

                            $('input[name=next]').hide();
                            //do stuff with the result
                            SendToServerAndStatus();
                            $($questions.get(currentQuestion)).fadeIn();
                            //alert('temporary Quiz Result: Congratulations. You Score ' + result + ' out of ' + totalQuestions);

                        }
                        else if (currentQuestion % 3 == 0) {
                            SendToServerAndStatus();// send to web server every 3 questions to reduce server load
                            $($questions.get(currentQuestion)).fadeIn();
                        }
                        else {
                            $($questions.get(currentQuestion)).fadeIn();
                        }
                    });
                }
                $('#back').click(function () {
                    $('input[name=next]').show();
                    var $this = jQuery(this);
                    if ($this.data('activated')) return false;  // Pending, return

                    $this.data('activated', true);
                    setTimeout(function () {
                        $this.data('activated', false)
                    }, 1000); // Freeze for 1000ms

                    showPrev();
                    // do_all_functions();
                    return false;
                });

                function showPrev() {
                    $($questions.get(currentQuestion)).fadeOut(function () {
                        currentQuestion = Number(currentQuestion) - 1;
                        var currentPage = currentQuestion + 1; //gets the current showing page
                        $('[id="PageNumber"]').val(currentPage);
                        if (currentQuestion == totalQuestions || currentQuestion < 0) {
                            result = sum_values();
                            currentQuestion = Number(currentQuestion) + 1;
                            $($questions.get(currentQuestion)).fadeIn();
                            //do stuff with the result
                            //alert(result);
                            
                        } else {
                            $($questions.get(currentQuestion)).fadeIn();
                        }
                    });
                }


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
                    if ($Question.parents("MultipleChoice").length != 0) {
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
                    var SendToServer = '{"var1": "' + escape(NewXMLwithAnswers) + '", "var2": "' + UserID + '", "var3": "' + QuizStudentId + '", "var4": "' + result + '", "var5": "' + isDone + '"}'
                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        data: SendToServer,
                        url: "QuizHandler.ashx",
                        dataType: "json",
                        success: function (data, status) {
                            //alert(data.d);
                            console.log(data);
                            //alert(data.status);
                            //QuizAction(data.status);      //still working on it!
                            //alert(data.status)// getting the data.d values
                        },
                        error: function (error) {
                            alert("Error: " + error.status + "/ " +
                              error.statusText);
                            debugger;
                        }
                    })
                }
                function QuizAction(stat) {
                    if (stat == "ongoing") {
                        var path = window.location.href + "?Result=1001";
                        window.location.href = path;
                    }
                }

            })

        </script>

        <div>
            <asp:Panel ID="pnlQuizItem" runat="server">
                <asp:Xml ID="XMLquiz" runat="server"></asp:Xml>
            </asp:Panel>
            <br />
            <br />
            <asp:Panel ID="pnlbuttons" HorizontalAlign="Center" runat="server">
                <input type="button" id="back" name="back" value="BACK" />
                <input type="button" id="next" name="next" value="NEXT" />
                <input type="button" id="Finish" name="Finish" value="END QUIZ" class="ButtonsOnMentorPage alignright" />
                <%--<asp:Button ID="btnFinish" runat="server" Text="End Quiz" CssClass="ButtonsOnMentorPage alignright" OnClick="btnFinish_Click" OnClientClick="ConfirmEndQuiz()" />--%>
                <input type="hidden" name="tempXML" id="tempXML" />
            </asp:Panel>
            <asp:Panel ID="pnlQuizResult" runat="server">
                <h3>Congratulations on finishing up the Quiz!</h3>
                <br />
            </asp:Panel>
        </div>


    </div>
</asp:Content>
