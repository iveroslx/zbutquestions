using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Questions : System.Web.UI.Page
{
	enum fields
	{
		Id,
		QNo,
		Question,
		IsSection
	}
	protected DataTable GetQuestions()
	{
		DataTable questions = new DataTable();
		questions.Columns.Add("Id", typeof(int));
		questions.Columns.Add("QuestionId", typeof(double));
		questions.Columns.Add("Question", typeof(string));
		questions.Columns.Add("IsSection", typeof(bool));
		questions.Columns.Add("Answer", typeof(bool));
		questions.Columns.Add("Details", typeof(string));
		questions.Columns.Add("SectionId", typeof(int));
		questions.Columns.Add("SectionName", typeof(string));
		DataColumn[] keys = new DataColumn[1];
		keys[0] = questions.Columns[0];
		questions.PrimaryKey = keys;

		using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["zbutConnectionStringOG"].ConnectionString))
		{
			con.Open();
			SqlCommand cmd = new SqlCommand("SELECT Id, QNo, Question, IsSection FROM dQuestions WITH (NOLOCK) ORDER BY QNo;", con);
			SqlDataReader rs = cmd.ExecuteReader();
			bool IsSection = false;
			string sectionName = string.Empty;
			while (rs.Read())
			{
				IsSection = false;
				sectionName = string.Empty;
				if (!DBNull.Value.Equals(rs[3]))
				{
					IsSection = true;
					sectionName = (string)rs[2];
				}
				questions.Rows.Add(rs[(int)fields.Id], rs[(int)fields.QNo], rs[(int)fields.Question], IsSection, false, "", rs[(int)fields.QNo], sectionName);
			}
			rs.Close();
			con.Close();
		}
		return questions;
	}

	protected void Page_Load(object sender, EventArgs e)
	{
		if (Session["Q"] == null)
		{
			Session["Q"] = GetQuestions();
		}

		grid.DataSource = Session["Q"];
		if (!IsPostBack && !IsCallback)
		{
			grid.DataBind();
		}
	}

	protected void ASPxGridView1_HtmlRowCreated(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
	{
		if (e.RowType == DevExpress.Web.GridViewRowType.Data)
		{
			if (e.KeyValue != null && (bool)e.GetValue("IsSection"))
			{
				//if ((bool)e.GetValue("IsSection"))
				//{
				e.Row.Visible = false;
				//					}
			}
		}

	}

	protected void grid_CommandButtonInitialize(object sender, ASPxGridViewCommandButtonEventArgs e)
	{
		e.Visible = false;
	}

	private void SendQuestionsAsEmail()
	{
		System.Text.StringBuilder text = new System.Text.StringBuilder();
		foreach (DataRow row in ((DataTable)Session["Q"]).Rows)
		{
			if ((bool)row["IsSection"])
			{
				text.AppendLine(string.Format("<b>{0}</b><br/>", row["SectionName"]));
			}
			else
			{
				text.AppendLine(string.Format("<li>{0} : <b>{1} - {2}</b></li><br/>", row["Question"], row["Answer"].ToString().Replace("True", "Yes").Replace("False", "No"), row["Details"]));
			}
		}

		string body = string.Format("Здравейте,<br/>Попълнен е въпросник за ЗБУТ<br/><br/>{0}<br/>", text.ToString());
		string cc = string.Empty;
		Mailer.SendMail(true, "върпосник", body);
	}

	protected void grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
	{
		DataRow row = ((DataTable)Session["Q"]).Rows.Find(e.Keys["Id"]);
		row["Answer"] = e.NewValues["Answer"];
		row["Details"] = e.NewValues["Details"];
		e.Cancel = true;
		grid.CancelEdit();
		grid.DataBind();
	}

	protected void grid_AfterPerformCallback(object sender, ASPxGridViewAfterPerformCallbackEventArgs e)
	{
		SendQuestionsAsEmail();
	}


}