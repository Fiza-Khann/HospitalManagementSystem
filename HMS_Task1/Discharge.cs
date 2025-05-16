using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HMS_Task1
{
    public class Discharge
    {
        public string SerialNo { get; set; }
        public string DStatus { get; set; }
        public DateTime DDate { get; set; }
        public string DTime { get; set; }
        public Patient Patient { get; set; }
    }

}