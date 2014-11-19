using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;

namespace GroupProject
{
    public static class Globals
    {
       // System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/MyWebSiteRoot");
        // System.Configuration.ConnectionStringSettings connString;
        public static string conn = ConString;

        public static string ConString
        {
            get
            {
                Configuration rootWebConfig = WebConfigurationManager.OpenWebConfiguration("/MyWebSiteRoot");
                conn = rootWebConfig.ConnectionStrings.ConnectionStrings["RobertsonQuizConn"].ToString();
                return conn;
            }
            set
            {
            }
        }
        //public Globals()
        //{

        //    if (rootWebConfig.ConnectionStrings.ConnectionStrings.Count > 0)
        //    {
        //        conn =
        //            rootWebConfig.ConnectionStrings.ConnectionStrings["RobertsonQuizConn"].ToString();
        //        if (conn != null)
        //            Console.WriteLine("Database connection string = \"{0}\"", conn.ConnectionString);
        //            Console.WriteLine("Database connection Success");
        //        else
        //            Console.WriteLine("Database connection Failed");
        //    }
        //}

        // public static string conn = "Data Source=localhost;Initial Catalog=Exam;Integrated Security=SSPI";
    }
}