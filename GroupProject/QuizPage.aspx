<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="QuizPage.aspx.cs" Inherits="GroupProject.QuizPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="js/jquery-2.1.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            answers = new Object();
            $('.option').change(function () {
                var answer = ($(this).attr('value'))
                var question = ($(this).attr('name'))
                var ChoicePosition = ($(this).attr('id'))
                // answers[question] = answer
                var select = [answer,ChoicePosition]
                answers[question] = select

            });
            var item1 = document.getElementById('Question');

            var totalQuestions = $('.Question').size();
            var currentQuestion = 0;
            $questions = $('.Question');
            $questions.hide();
            $($questions.get(currentQuestion)).fadeIn();
            $('#next').click(function () {
                $($questions.get(currentQuestion)).fadeOut(function () {
                    currentQuestion = currentQuestion + 1;
                    if (currentQuestion == totalQuestions) {
                        var result = sum_values()
                        //do stuff with the result
                        alert(result);
                    } else {
                        $($questions.get(currentQuestion)).fadeIn();
                    }
                });
            });
            $('#back').click(function () {
                $($questions.get(currentQuestion)).fadeOut(function () {
                    currentQuestion = currentQuestion - 1;
                    if (currentQuestion == totalQuestions) {
                        var result = sum_values()
                        //do stuff with the result
                        alert(result);
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
                    RecreateXML(questionId,position)
                    //var MyData ='{"QuestionID": "'+questionId.replace('Question','')+', "position"}'
                }
                return the_sum
            }
            function RecreateXML(QuestionID,UserAnswerPosition)
            {
                var xmlFile = '<%=HttpContext.Current.Session["Quiz"]%>';
               // var QuestionElement = $($.parseXML(xmlFile)).find("Question[ID=QuestionID]");
                XMLDoc = $.parseXML(xmlFile)
                $xmlFile = $(XMLDoc)
                var Question = $xmlFile.find("Question[ID='" + QuestionID + "']");
                $Option = $xmlFile.find("Question[ID='" + QuestionID + "']").find("Options");
                $Option = $(Question).find("Options");
                //the UserAnswerPosition starts from 1 but the find xml content starts with 0; therefore we need to less the position by one
                fixPosition = UserAnswerPosition - 1
                //$OptionSelected now holds the Answer of the user. the TEXT answer
                $OptionSelected = $Option.find("Option:eq('" + fixPosition + "')").text();
                //Append the OptionSelected to USERANSWER element
                $(Question).attr('type', 'vip');
                //var newElement = XMLDoc.createElement("UserAnswer")
                //x = XMLDoc.getElementsByTagName("Question");
                //x.appendChild(newElement);
                $(XMLDoc).children(0).append($('<UserAnswer>' + $OptionSelected + '</UserAnswer>'))
                //$('<UserAnswer>' + $OptionSelected + '</UserAnswer>').appendTo(xmlFile);
                //$('body').append(xmlFile);
                alert(xmlFile);
            }
        })
    </script>

    <div>
        <asp:Xml ID="XMLquiz" runat="server"></asp:Xml>
        <input type="button" id="back" name="back" value="BACK" />
        <input type="button" id="next" name="next" value="NEXT"  />
        
    </div>
</asp:Content>
