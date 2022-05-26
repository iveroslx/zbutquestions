<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuestionDesign.aspx.cs" Inherits="QuestionDesign" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="site.css" rel="stylesheet" />
    <title>Question Administration</title>
</head>
<body>
    <form id="form1" runat="server">
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="dsQuestionsNew" KeyFieldName="Id" EnableTheming="True" Theme="Office365" Width="100%">
                <SettingsPager PageSize="50" visible="False">
                </SettingsPager>
                <SettingsEditing Mode="Batch" NewItemRowPosition="Bottom">
                </SettingsEditing>
                <Settings ShowFilterRow="True" />

<SettingsPopup>
<FilterControl AutoUpdatePosition="False"></FilterControl>
</SettingsPopup>
                <Columns>
                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="70px">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="1" Visible="False">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="QNo" VisibleIndex="2" Width="70px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Question" VisibleIndex="3"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="IsSection" VisibleIndex="4" Width="70px"></dx:GridViewDataCheckColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="dsQuestionsNew" runat="server" ConnectionString="<%$ ConnectionStrings:zbutConnectionStringOG %>" DeleteCommand="DELETE FROM [dQuestions] WHERE [Id] = @Id" InsertCommand="INSERT INTO [dQuestions] ([QNo], [Question], [IsSection]) VALUES (@QNo, @Question, @IsSection)" SelectCommand="SELECT * FROM [dQuestions] ORDER BY [QNo]" UpdateCommand="UPDATE [dQuestions] SET [QNo] = @QNo, [Question] = @Question, [IsSection] = @IsSection WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="QNo" Type="Double" />
                    <asp:Parameter Name="Question" Type="String" />
                    <asp:Parameter Name="IsSection" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="QNo" Type="Double" />
                    <asp:Parameter Name="Question" Type="String" />
                    <asp:Parameter Name="IsSection" Type="Boolean" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
