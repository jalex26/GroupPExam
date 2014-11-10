using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject
{
    public class StateCookies
    {
        public string SortColumn;
        public string Direction;

        public StateCookies()
        {
            if (HttpContext.Current.Request.Cookies["StateCookies"] != null)
            {
                SortColumn = HttpContext.Current.Request.Cookies["StateCookies"]["SortColumn"];
                Direction = HttpContext.Current.Request.Cookies["StateCookies"]["Direction"];
            }
            else
            {
                SortColumn = "Firstname";
                Direction = "desc";
                Save();
            }
        }
        public void Save()
        {
            HttpContext.Current.Response.Cookies["StateCookies"]["SortColumn"] = SortColumn;
            HttpContext.Current.Response.Cookies["StateCookies"]["Direction"] = Direction;
        }
        public void ColumnChange(string NewColumn)
        {
            if (SortColumn == NewColumn)
            {
                if (Direction == "desc")
                {
                    Direction = "asc";
                }
                else
                {
                    Direction = "desc";
                }
            }
            else
            {
                Direction = "asc";
            }
            SortColumn = NewColumn;
            Save();
        }
    }
}