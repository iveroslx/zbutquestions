<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Questions.aspx.cs" Inherits="Questions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="site.css" rel="stylesheet" />
    <title>Questionnaire</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxPanel ID="ASPxPanel1" runat="server" Width="100%" CssClass="AnswerPanel" EncodeHtml="false">
                <Paddings PaddingTop="10px" />
                <PanelCollection>
                    <dx:PanelContent>
                        <dx:ASPxLabel Font-Size="Medium" runat="server" Text="Въпросник за ЗБУТ."></dx:ASPxLabel>
                        <br />
                        <br />
                        <dx:ASPxLabel runat="server" Text="Моля попълнете въпросника, като отговаряте с да или не. Може да добавите допълнителни бележки към въпроса."></dx:ASPxLabel>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxPanel>
            <div id="thankyou" class="AnswerPanel" style="display:none;">
                <br />
                <br />
                Благодаря ви. Върпосникът е изпратен за оценяване.
            </div>
            <div class="AnswerPanel" id="qHead">
               <dx:ASPxGridView ID="grid" runat="server" AutoGenerateColumns="False" KeyFieldName="Id" EnableTheming="True" OnHtmlRowCreated="ASPxGridView1_HtmlRowCreated" Theme="Moderno" ClientInstanceName="qGrid" OnCommandButtonInitialize="grid_CommandButtonInitialize" OnAfterPerformCallback="grid_AfterPerformCallback" OnRowUpdating="grid_RowUpdating">
				<Columns>
					<dx:GridViewDataTextColumn FieldName="Id" Visible="False" VisibleIndex="0">
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataTextColumn FieldName="QuestionId" ReadOnly="True" VisibleIndex="1" MinWidth="50" Width="50px" Visible="False">
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataTextColumn FieldName="Question" VisibleIndex="2" MinWidth="300" ReadOnly="True" Width="300px">
						<EditFormSettings Visible="False" />
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataCheckColumn FieldName="IsSection" Visible="False" VisibleIndex="3">
					</dx:GridViewDataCheckColumn>
					<dx:GridViewDataTextColumn FieldName="Details" VisibleIndex="6" MinWidth="300" Width="300px">
						<PropertiesTextEdit Width="300px" NullDisplayText="(enter details here)" ConvertEmptyStringToNull="True">
						</PropertiesTextEdit>
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataTextColumn FieldName="SectionId" GroupIndex="0" SortIndex="0" SortOrder="Ascending" Visible="False" VisibleIndex="7">
						<GroupRowTemplate>
							<asp:Label ID="Label1" runat="server" Text='<%# Eval("SectionName") %>'></asp:Label>
						</GroupRowTemplate>
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataTextColumn FieldName="SectionName" Visible="False" VisibleIndex="8">
					</dx:GridViewDataTextColumn>
					<dx:GridViewDataComboBoxColumn FieldName="Answer" MinWidth="70" VisibleIndex="5" Width="70px">
						<PropertiesComboBox EnableFocusedStyle="False" ValueType="System.Boolean" ShowImageInEditBox="True">
							<Items>
								<dx:ListEditItem Text="Не" Value="False" />
								<dx:ListEditItem Text="Да" Value="True" />
							</Items>
						</PropertiesComboBox>
					</dx:GridViewDataComboBoxColumn>
				</Columns>
				<SettingsBehavior AutoExpandAllGroups="True" />
				<SettingsPager PageSize="200" Visible="False">
				</SettingsPager>
				<SettingsEditing Mode="Batch">
				</SettingsEditing>
				<Settings GroupFormat="" UseFixedTableLayout="True" />
				<SettingsDataSecurity AllowDelete="False" AllowInsert="False" />
				<Styles>
					<Header CssClass="AnswerSheet">
					</Header>
					<GroupRow BackColor="#CCCCCC" Font-Bold="True" ForeColor="Black">
					</GroupRow>
				</Styles>
			</dx:ASPxGridView>


            </div>
        </div>

		<div class="AnswerPanel" id="qLower">
			<div style="float:right;">
			<dx:ASPxButton ID="btnSubmit" runat="server" Text="Submit" AutoPostBack="False">
				<ClientSideEvents Click="function(s, e) {
					qGrid.UpdateEdit();
					var elem = document.getElementById('qHead');
					elem.style.display = 'none';
					var elemA = document.getElementById('qLower');
					elemA.style.display = 'none';
					var elemB = document.getElementById('thankyou');
					elemB.style.display = 'block';
				}" />
				</dx:ASPxButton>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>

    </form>
</body>
</html>
