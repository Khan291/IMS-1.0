using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace IMSBLL.DAL
{
  public class Validationss
    {
        public bool mobilevations(string value)
        {
            Regex regex = new Regex(@"^[0-9]+$");
            if (value.Length > 10 || value.Length < 10 || !regex.IsMatch(value) || value == "" || String.IsNullOrWhiteSpace(value))
            {
                return false;
            }
            return true;
        }
        public bool emialvalidation(string value)
        {
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(value);
            if (!match.Success || value=="" || String.IsNullOrWhiteSpace(value))
            {
                return false;
            }
            return true;
        }
        public bool emtystringvalidtion(string[] ar)
        {
            for (int i = 0; i < ar.Length; i++)
            {
                if (ar[i] == "")
                {
                    return false;
                }
            }
            return true;
        }
    }
}
