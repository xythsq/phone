using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WapCoovee
{
    public class Base : System.Web.UI.Page
    {

        public DateTime start_time = DateTime.Now;
        public DateTime start_timecb = DateTime.Now;
        public int time_solr = 0;
        public int time_sql = 0;
        public Base()
        { }

    }
}
