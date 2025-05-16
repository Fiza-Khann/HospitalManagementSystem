using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMS_Task1
{
    interface IDischargeRepository
    {
        Discharge GetDischargeBySerialNo(string serialNo);

        // Add a new discharge record
        void AddDischarge(Discharge discharge);

        // Update existing discharge record
        void UpdateDischarge(Discharge discharge);

        // Check if a discharge record exists for a given patient
        bool PatientExists(string serialNo);

        // Retrieve patient by registration number and number
        Patient GetPatientByRegNum(string reg, string num);
    }
}
