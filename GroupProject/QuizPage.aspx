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
                answers[question] = answer
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
                alert("here");
                var the_sum = 0;
                for (questions in answers) {
                    the_sum = the_sum + parseInt(answers[questions])
                }
                return the_sum
            }
        })
    </script>

    <div>
        <asp:Xml ID="XMLquiz" runat="server"></asp:Xml>
        <input type="button" id="back" name="back" value="BACK" />
        <input type="button" id="next" name="next" value="NEXT"  />
        
    </div>
</asp:Content>
