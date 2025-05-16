using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HMS_Task1
{
    public class PatientRepository : IPatientRepository
    {
        private readonly string _connectionString;

        public PatientRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public Patient GetPatientBySerialNo(string serialNo)
        {
            Patient patient = null;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT * FROM patient WHERE serialno = @serialno";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@serialno", serialNo);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    patient = new Patient
                    {
                        SerialNo = reader["serialno"].ToString(),
                        Reg = reader["Reg"].ToString(),
                        Num = reader["Num"].ToString(),
                        AdmDate = Convert.ToDateTime(reader["AdmDate"]),
                        AdmTime = reader["AdmTime"] is DBNull ? string.Empty : ((TimeSpan)reader["AdmTime"]).ToString(@"hh\:mm\:ss"),
                        Bmj = reader["Bmj#"].ToString(),
                        Title = reader["Title"].ToString(),
                        PatientName = reader["PatientName"].ToString(),
                        Room = reader["Room"].ToString(),
                        ConsultantName = reader["ConsultantName"].ToString(),
                        Relation = reader["Relation"].ToString(),
                        RelationName = reader["RelationName"].ToString(),
                        Emergency = reader["Emergency"].ToString(),
                        Mobile = reader["Mobile"].ToString(),
                        OtherContact = reader["OtherContact"].ToString(),
                        Email = reader["Email"].ToString(),
                        ReferenceName = reader["ReferenceName"].ToString(),
                        AdmittedFor = reader["AdmittedFor"].ToString(),
                        AdmissionRemarks = reader["AdmissionRemarks"].ToString(),
                        AdmissionLoginId = reader["AdmissionLoginId"].ToString(),
                        Discharged = reader["Discharged"] != DBNull.Value && reader["Discharged"].ToString() == "1",
                        DischargeDate = reader["DischargeDate"] is DBNull ? (DateTime?)null : Convert.ToDateTime(reader["DischargeDate"]),
                        DischargeTime = reader["DischargeTime"] is DBNull ? string.Empty : ((TimeSpan)reader["DischargeTime"]).ToString(@"hh\:mm\:ss"),
                        DischargeRemarks = reader["DischargeRemarks"].ToString(),
                        City = reader["City"].ToString(),
                        AreaName = reader["AreaName"].ToString(),
                        Gender = reader["Gender"].ToString(),
                        AgeNum = reader["AgeNum"].ToString(),
                        AgeValue = reader["AgeValue"].ToString(),
                        Typee = reader["Typee"].ToString(),
                        Address = reader["Address"].ToString()
                    };
                }
            }
            return patient;
        }

        public void AddPatient(Patient patient)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                INSERT INTO patient 
                (serialno, Reg, Num, AdmDate, AdmTime, Bmj#, Title, PatientName, Room, ConsultantName, Relation, 
                 RelationName, Emergency, Mobile, OtherContact, Email, ReferenceName, AdmittedFor, AdmissionRemarks, AdmissionLoginId, 
                 Discharged, DischargeDate, DischargeTime, DischargeRemarks, City, AreaName, Gender, AgeNum, AgeValue, Typee, Address) 
                VALUES 
                (@serialno, @Reg, @Num, @AdmDate, @AdmTime, @Bmj, @Title, @PatientName, @Room, @ConsultantName, @Relation, 
                 @RelationName, @Emergency, @Mobile, @OtherContact, @Email, @ReferenceName, @AdmittedFor, @AdmissionRemarks, @AdmissionLoginId, 
                 @Discharged, @DischargeDate, @DischargeTime, @DischargeRemarks, @City, @AreaName, @Gender, @AgeNum, @AgeValue, @Typee, @Address)";

                SqlCommand cmd = new SqlCommand(query, conn);
                AddPatientParameters(cmd, patient);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void UpdatePatient(Patient patient)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
                UPDATE patient
                SET 
                    Reg = @Reg, 
                    Num = @Num, 
                    AdmDate = @AdmDate, 
                    AdmTime = @AdmTime, 
                    Bmj# = @Bmj, 
                    Title = @Title, 
                    PatientName = @PatientName, 
                    Room = @Room, 
                    ConsultantName = @ConsultantName, 
                    Relation = @Relation, 
                    RelationName = @RelationName, 
                    Emergency = @Emergency, 
                    Mobile = @Mobile, 
                    OtherContact = @OtherContact, 
                    Email = @Email, 
                    ReferenceName = @ReferenceName, 
                    AdmittedFor = @AdmittedFor, 
                    AdmissionRemarks = @AdmissionRemarks, 
                    AdmissionLoginId = @AdmissionLoginId, 
                    Discharged = @Discharged, 
                    DischargeDate = @DischargeDate, 
                    DischargeTime = @DischargeTime, 
                    DischargeRemarks = @DischargeRemarks, 
                    City = @City, 
                    AreaName = @AreaName, 
                    Gender = @Gender, 
                    AgeNum = @AgeNum, 
                    AgeValue = @AgeValue, 
                    Typee = @Typee, 
                    Address = @Address
                WHERE serialno = @serialno";

                SqlCommand cmd = new SqlCommand(query, conn);
                AddPatientParameters(cmd, patient);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void AddPatientParameters(SqlCommand cmd, Patient patient)
        {
            cmd.Parameters.AddWithValue("@serialno", patient.SerialNo);
            cmd.Parameters.AddWithValue("@Reg", patient.Reg);
            cmd.Parameters.AddWithValue("@Num", patient.Num);
            cmd.Parameters.AddWithValue("@AdmDate", patient.AdmDate);
            cmd.Parameters.AddWithValue("@AdmTime", patient.AdmTime);
            cmd.Parameters.AddWithValue("@Bmj", patient.Bmj);
            cmd.Parameters.AddWithValue("@Title", patient.Title);
            cmd.Parameters.AddWithValue("@PatientName", patient.PatientName);
            cmd.Parameters.AddWithValue("@Room", patient.Room);
            cmd.Parameters.AddWithValue("@ConsultantName", patient.ConsultantName);
            cmd.Parameters.AddWithValue("@Relation", patient.Relation);
            cmd.Parameters.AddWithValue("@RelationName", patient.RelationName);
            cmd.Parameters.AddWithValue("@Emergency", patient.Emergency);
            cmd.Parameters.AddWithValue("@Mobile", patient.Mobile);
            cmd.Parameters.AddWithValue("@OtherContact", patient.OtherContact);
            cmd.Parameters.AddWithValue("@Email", patient.Email);
            cmd.Parameters.AddWithValue("@ReferenceName", patient.ReferenceName);
            cmd.Parameters.AddWithValue("@AdmittedFor", patient.AdmittedFor);
            cmd.Parameters.AddWithValue("@AdmissionRemarks", patient.AdmissionRemarks);
            cmd.Parameters.AddWithValue("@AdmissionLoginId", patient.AdmissionLoginId);
            cmd.Parameters.AddWithValue("@Discharged", patient.Discharged);
            cmd.Parameters.AddWithValue("@DischargeDate", patient.DischargeDate ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@DischargeTime", patient.DischargeTime);
            cmd.Parameters.AddWithValue("@DischargeRemarks", patient.DischargeRemarks);
            cmd.Parameters.AddWithValue("@City", patient.City);
            cmd.Parameters.AddWithValue("@AreaName", patient.AreaName);
            cmd.Parameters.AddWithValue("@Gender", patient.Gender);
            cmd.Parameters.AddWithValue("@AgeNum", patient.AgeNum);
            cmd.Parameters.AddWithValue("@AgeValue", patient.AgeValue);
            cmd.Parameters.AddWithValue("@Typee", patient.Typee);
            cmd.Parameters.AddWithValue("@Address", patient.Address);
        }

        public bool PatientExists(string serialNo)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT COUNT(1) FROM patient WHERE serialno = @serialno";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@serialno", serialNo);

                conn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        public bool LoginIdExists(string loginId)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT COUNT(1) FROM UserInformation WHERE LoginId = @LoginId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LoginId", loginId);

                conn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        public string GenerateUniqueSerialNo()
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT ISNULL(MAX(serialno), 0) + 1 FROM patient";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                return cmd.ExecuteScalar().ToString();
            }
        }

        public string GenerateUniqueRegID()
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT ISNULL(MAX(Reg), '') FROM patient";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                var maxReg = cmd.ExecuteScalar().ToString();

                if (string.IsNullOrEmpty(maxReg))
                    return "A";

                char lastRegChar = maxReg[0];
                char nextRegChar = (char)(lastRegChar + 1);
                return nextRegChar > 'Z' ? "A" : nextRegChar.ToString();
            }
        }

        public List<string> GetCities()
        {
            var cities = new List<string>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT CityName FROM City";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    cities.Add(reader["CityName"].ToString());
                }
            }
            return cities;
        }

        public List<string> GetRooms()
        {
            var rooms = new List<string>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT Room FROM Room";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    rooms.Add(reader["Room"].ToString());
                }
            }
            return rooms;
        }

        public List<KeyValuePair<string, string>> GetConsultants()
        {
            var consultants = new List<KeyValuePair<string, string>>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT ConsultantID, ConsultantName FROM Consultants";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    consultants.Add(new KeyValuePair<string, string>(
                        reader["ConsultantID"].ToString(),
                        reader["ConsultantName"].ToString()
                    ));
                }
            }
            return consultants;
        }

        public List<string> GetAreas()
        {
            var areas = new List<string>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT AreaName FROM Area";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    areas.Add(reader["AreaName"].ToString());
                }
            }
            return areas;
        }

        public List<string> GetReferenceNames()
        {
            var references = new List<string>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT ReferenceName FROM ReferenceInformation";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    references.Add(reader["ReferenceName"].ToString());
                }
            }
            return references;
        }
    }
}