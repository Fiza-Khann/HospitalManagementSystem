using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HMS_Task1
{
    public class Patient
    {
        public string SerialNo { get; set; }
        public string Reg { get; set; }
        public string Num { get; set; }
        public DateTime AdmDate { get; set; }
        public string AdmTime { get; set; }
        public string Bmj { get; set; }
        public string Title { get; set; }
        public string PatientName { get; set; }
        public string Room { get; set; }
        public string ConsultantName { get; set; }
        public string Relation { get; set; }
        public string RelationName { get; set; }
        public string Emergency { get; set; }
        public string Mobile { get; set; }
        public string OtherContact { get; set; }
        public string Email { get; set; }
        public string ReferenceName { get; set; }
        public string AdmittedFor { get; set; }
        public string AdmissionRemarks { get; set; }
        public string AdmissionLoginId { get; set; }
        public bool Discharged { get; set; }
        public DateTime? DischargeDate { get; set; }
        public string DischargeTime { get; set; }
        public string DischargeRemarks { get; set; }
        public string City { get; set; }
        public string AreaName { get; set; }
        public string Gender { get; set; }
        public string AgeNum { get; set; }
        public string AgeValue { get; set; }
        public string Typee { get; set; }
        public string Address { get; set; }
    }

}