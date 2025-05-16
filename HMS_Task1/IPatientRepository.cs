using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMS_Task1
{
    public interface IPatientRepository
    {
        Patient GetPatientBySerialNo(string serialNo);
        void AddPatient(Patient patient);
        void UpdatePatient(Patient patient);
        bool PatientExists(string serialNo);
        bool LoginIdExists(string loginId);
        string GenerateUniqueSerialNo();
        string GenerateUniqueRegID();
        List<string> GetCities();
        List<string> GetRooms();
        List<KeyValuePair<string, string>> GetConsultants();
        List<string> GetAreas();
        List<string> GetReferenceNames();
    }
}
