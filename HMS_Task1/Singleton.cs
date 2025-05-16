using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace HMS_Task1
{
    public sealed class Singleton
    {
        private static readonly Singleton _instance = new Singleton();
        private readonly string connectionString;

        // Private constructor prevents instantiation from outside
        private Singleton()
        {
            connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
        }

        // Public property to access the Singleton instance
        public static Singleton Instance
        {
            get { return _instance; }
        }

        // Method to get a new SQL connection
        public SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}