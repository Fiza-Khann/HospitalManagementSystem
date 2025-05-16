using System;
using System.Data.SqlClient;
using System.Configuration;

namespace HMS_Task1
{
    public class DischargeRepository : IDischargeRepository
    {
        private readonly string _connectionString;

        public DischargeRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public Discharge GetDischargeBySerialNo(string serialNo)
        {
            Discharge discharge = null;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                SELECT d.SerialNo, d.Dstatus, d.Ddate, d.Dtime, 
                       p.Reg, p.Num, p.PatientName
                FROM Discharge d
                INNER JOIN patient p ON d.SerialNo = p.serialno
                WHERE d.SerialNo = @SerialNo";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SerialNo", serialNo);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    discharge = new Discharge
                    {
                        SerialNo = reader["SerialNo"].ToString(),
                        DStatus = reader["Dstatus"].ToString(),
                        DDate = Convert.ToDateTime(reader["Ddate"]),
                        DTime = reader["Dtime"].ToString(),
                        Patient = new Patient
                        {
                            Reg = reader["Reg"].ToString(),
                            Num = reader["Num"].ToString(),
                            PatientName = reader["PatientName"].ToString()
                        }
                    };
                }
            }
            return discharge;
        }

        public void AddDischarge(Discharge discharge)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                INSERT INTO Discharge (SerialNo, Dstatus, Ddate, Dtime) 
                VALUES (@SerialNo, @Dstatus, @Ddate, @Dtime)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SerialNo", discharge.SerialNo);
                cmd.Parameters.AddWithValue("@Dstatus", discharge.DStatus);
                cmd.Parameters.AddWithValue("@Ddate", discharge.DDate);
                cmd.Parameters.AddWithValue("@Dtime", discharge.DTime);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void UpdateDischarge(Discharge discharge)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                UPDATE Discharge 
                SET Dstatus = @Dstatus, Ddate = @Ddate, Dtime = @Dtime 
                WHERE SerialNo = @SerialNo";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SerialNo", discharge.SerialNo);
                cmd.Parameters.AddWithValue("@Dstatus", discharge.DStatus);
                cmd.Parameters.AddWithValue("@Ddate", discharge.DDate);
                cmd.Parameters.AddWithValue("@Dtime", discharge.DTime);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public bool PatientExists(string serialNo)
        {
            bool exists = false;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                SELECT COUNT(1) 
                FROM Discharge 
                WHERE SerialNo = @SerialNo";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SerialNo", serialNo);

                conn.Open();
                exists = Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
            return exists;
        }

        public Patient GetPatientByRegNum(string reg, string num)
        {
            Patient patient = null;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                SELECT p.PatientName, p.SerialNo
                FROM Patient p
                WHERE p.Reg = @Reg AND p.Num = @Num";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Reg", reg);
                cmd.Parameters.AddWithValue("@Num", num);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    patient = new Patient
                    {
                        SerialNo = reader["SerialNo"].ToString(),
                        PatientName = reader["PatientName"].ToString()
                    };
                }
            }
            return patient;
        }
    }
}
