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
                var select = [answer, ChoicePosition]
                answers[question] = select

            });
            $('#tempXML').change(function () {// fire the ajax here! to save
                alert("valueCHanged");
            })

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
                        var result = sum_values()
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
                    RecreateXML(questionId, position)
                    //var MyData ='{"QuestionID": "'+questionId.replace('Question','')+', "position"}'
                }
                return the_sum
            }
            function RecreateXML(QuestionID, UserAnswerPosition) {
                // var xmlFile = '<%=HttpContext.Current.Session["Quiz"]%>';
                var xmlFile;
                if (document.getElementById("tempXML").value != "") {
                    xmlFile = document.getElementById("tempXML").value;
                }
                else {
                    xmlFile = '<%=HttpContext.Current.Session["Quiz"]%>';
                }
                // var QuestionElement = $($.parseXML(xmlFile)).find("Question[ID=QuestionID]");
                XMLDoc = $.parseXML(xmlFile)
                $xmlFile = $(XMLDoc)
                $Question = $xmlFile.find("Question[ID='" + QuestionID + "']");
                $Option = $xmlFile.find("Question[ID='" + QuestionID + "']").find("Options");
                $Option = $Question.find("Options");
                //the UserAnswerPosition starts from 1 but the find xml content starts with 0; therefore we need to less the position by one
                fixPosition = UserAnswerPosition - 1
                //$OptionSelected now holds the Answer of the user. the TEXT answer
                $OptionSelected = $Option.find("Option:eq('" + fixPosition + "')").text();
                //Append the OptionSelected to USERANSWER element
                $Question.attr('done', 'true'); //mark the question done!
                $($.parseXML('<UserAnswer>' + $OptionSelected + '</UserAnswer>')).find("UserAnswer").appendTo($Question);
                x = XMLDoc.getElementsByTagName("Question");

                //x.appendChild($Question);
                //$(Question).appendTo($(XMLDoc));

                //var newElement = XMLDoc.createElement("UserAnswer")
                //x = XMLDoc.getElementsByTagName("Question");
                //x.appendChild(newElement);
                //$(XMLDoc).children(0).append($('<UserAnswer>' + $OptionSelected + '</UserAnswer>'))
                //$("'<UserAnswer>'" + $OptionSelected + "'</UserAnswer>'").appendTo(Question);
                //$('body').append(xmlFile);
                var XMLString;
                //IE
                if (window.ActiveXObject) {
                    XMLString = XMLDoc;
                }
                    // code for Mozilla, Firefox, Opera, etc.
                else {
                    XMLString = (new XMLSerializer()).serializeToString(XMLDoc);
                }

                alert(XMLString);
                var UserID = '<%=HttpContext.Current.Session["Userid"]%>';
                setSession(XMLString, UserID)

            }
            function setSession(XMLString, UserID) {
                //$("input:hidden[id$=tempXML]").val(XMLString)
                //                               .trigger('change');
                //var var1 = '{"var1": "' + XMLString + '"}'
                XMLDoc = $.parseXML(XMLString)
                var var2 = JSON.stringify(xmlToJson(XMLDoc));
                var var1 = '{"var1": "' + escape(XMLString) + '"}';
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    data: var1,
                    url: "QuizPage.aspx/SaveValueInSession",
                    dataType: "json",
                    success: function (data) {
                        alert(data.d);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        debugger;
                    }
                })
            }

            function xmlToJson(xml) {
                var obj = {};
                if (xml.nodeType == 1) {
                    if (xml.attributes.length > 0) {
                        obj["@attributes"] = {};
                        for (var j = 0; j < xml.attributes.length; j++) {
                            var attribute = xml.attributes.item(j);
                            obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
                        }
                    }
                } else if (xml.nodeType == 3) {
                    obj = xml.nodeValue;
                }
                if (xml.hasChildNodes()) {
                    for (var i = 0; i < xml.childNodes.length; i++) {
                        var item = xml.childNodes.item(i);
                        var nodeName = item.nodeName;
                        if (typeof (obj[nodeName]) == "undefined") {
                            obj[nodeName] = xmlToJson(item);
                        } else {
                            if (typeof (obj[nodeName].push) == "undefined") {
                                var old = obj[nodeName];
                                obj[nodeName] = [];
                                obj[nodeName].push(old);
                            }
                            obj[nodeName].push(xmlToJson(item));
                        }
                    }
                }
                return obj;
            }
        })
        //$.ajax({
        //    type: "POST",
        //    contentType: "application/json",
        //    data: "{var1:'" + XMLString + "', var2:'"+UserID+"'}",
        //    url: "QuizHandler.ashx",
        //    dataType: "json",
        //    success: function (data) {
        //        alert(data.d);
        //    },
        //    error: function (XMLHttpRequest, textStatus, errorThrown) {
        //        debugger;
        //    }
        //})
    </script>

    <div>
        <asp:Xml ID="XMLquiz" runat="server"></asp:Xml>
        <input type="button" id="back" name="back" value="BACK" />
        <input type="button" id="next" name="next" value="NEXT" />
        <input type="hidden" name="tempXML" id="tempXML" />
        <%--use the hiddenfield to SET the SESSION since it cannot set by SERVER using JAVASCRIPT. but i can retrieve it from USER BROWSER. --%>
    </div>
</asp:Content>
