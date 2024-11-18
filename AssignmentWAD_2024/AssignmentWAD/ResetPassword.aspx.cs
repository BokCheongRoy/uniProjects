using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace AssignmentWAD
{
    public partial class ResetPassword : System.Web.UI.Page
    {

        MembershipUser u;

        public void Page_Load(object sender, EventArgs args)
        {

            if (!Membership.EnablePasswordReset)
            {
                FormsAuthentication.RedirectToLoginPage("~/Login.aspx");
            }

            Msg.Text = "";

            if (!IsPostBack)
            {
                Msg.Text = "Please give your username.";
            }
            else
            {
                VerifyUsername();
            }
        }


        public void VerifyUsername()
        {
            u = Membership.GetUser(UsernameTextBox.Text, false);

            if (u == null)
            {
                Msg.Text = "Username " + Server.HtmlEncode(UsernameTextBox.Text) + " not found. Please check the value and re-enter.";

                ResetPasswordButton.Enabled = false;
            }
            else
            {
                ResetPasswordButton.Enabled = true;
            }
        }

        public void ResetPassword_OnClick(object sender, EventArgs args)
        {
            string newPassword;

            u = Membership.GetUser(UsernameTextBox.Text, false);

            if (u == null)
            {
                Msg.Text = "Username " + Server.HtmlEncode(UsernameTextBox.Text) + " not found. Please check the value and re-enter.";
                return;
            }

            try
            {
                newPassword = u.ResetPassword();
            }
            catch (MembershipPasswordException e)
            {
                Msg.Text = "Invalid password answer. Please re-enter and try again.";
                Console.WriteLine("Error: " + e.Message);
                return;
            }
            catch (Exception e)
            {
                Msg.Text = e.Message;
                return;
            }
            if (newPassword != null)
            {
                StoreNewPasswordInDatabase(UsernameTextBox.Text, newPassword);

                Msg.Text = "Password reset. Your new password is: " + Server.HtmlEncode(newPassword);
            }
            else
            {
                Msg.Text = "Password reset failed. Please re-enter your values and try again.";
            }
        }
        protected void StoreNewPasswordInDatabase(string username, string newPassword)
        {
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                con.Open();

                SqlCommand cmd = new SqlCommand("UPDATE aspnet_Membership SET Password = @Password WHERE UserId = @Username", con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", newPassword);
                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error storing new password: " + ex.Message);
            }
        }

    }
}


