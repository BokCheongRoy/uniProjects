using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace AssignmentWAD.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        string str = null;
        SqlCommand com;
        byte up;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            try
            {
                Guid userId = (Guid)Membership.GetUser(ChangePassword1.UserName).ProviderUserKey;

                if (userId != Guid.Empty)
                {

                    str = "SELECT UserId, Password FROM aspnet_Membership WHERE UserId = @UserId";
                    com = new SqlCommand(str, conn);
                    com.Parameters.AddWithValue("@UserId", userId);

                    SqlDataReader reader = com.ExecuteReader();
                    if (reader.Read())
                    {
                        //check current password
                        if (ChangePassword1.CurrentPassword == reader["Password"].ToString())
                        {
                            up = 1;
                        }
                      

                    }
                    else
                    {
                        ChangePassword1.ChangePasswordFailureText = "User not found in the database";
                    }

                    reader.Close();
                    conn.Close();
                    if (up == 1)
                    {
                        conn.Open();
                        str = "UPDATE aspnet_Membership SET Password = @Password WHERE UserId = @UserId";
                        com = new SqlCommand(str, conn);
                        com.Parameters.AddWithValue("@Password", ChangePassword1.NewPassword.ToString());
                        com.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());

                        com.ExecuteNonQuery();
                        conn.Close();
                        ChangePassword1.ChangePasswordFailureText = "Password changed successfully";
                    }
                    else
                    {
                        ChangePassword1.ChangePasswordFailureText = "Please enter correct current password";

                    }

                }
                else
                {
                    ChangePassword1.ChangePasswordFailureText = "User not authenticated. Please log in.";

                }

            }

            catch (Exception ex)
            {
                {
                    ChangePassword1.ChangePasswordFailureText = "An error occurred: " + ex.Message;
                }
            }
        }
    }
}

