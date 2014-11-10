<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testxsl.aspx.cs" Inherits="GroupProject.testxsl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Xml ID="Xml1" runat="server"></asp:Xml>
            <input type="button" name="next" value="NEXT" onclick="sum_values()" />
            
        </div>
    </form>
</body>
</html>
