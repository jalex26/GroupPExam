using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DAL_Project;

namespace GroupProject
{
    public class PageTest
    {
        private int currentPage;
        private int pageSize;
        private int rowCount;
        DAL myDal = new DAL(Globals.conn);


        public PageTest()
        {
            LoadPageSize();
            if (HttpContext.Current.Session["currentPage"] == null)
            {
                LoadPageSize();
                currentPage = 1;
                //get the number of rows
                DAL myDal = new DAL(Globals.conn);
                DataSet ds = new DataSet();
                ds = myDal.ExecuteProcedure("spGetCountAlbums");
                rowCount = Convert.ToInt32(ds.Tables[0].Rows[0]["Count"].ToString());
                Save();
            }
            else
            {
                Load();
            }

        }
        public void Load()
        {
            currentPage = (int)HttpContext.Current.Session["currentPage"];
            pageSize = (int)HttpContext.Current.Session["PageSize"];
            rowCount = (int)HttpContext.Current.Session["rowCount"];
            LoadPageSize();

        }
        public void Save()
        {
            HttpContext.Current.Session["currentPage"] = currentPage;
            HttpContext.Current.Session["PageSize"] = pageSize;
            HttpContext.Current.Session["rowCount"] = rowCount;
            SavePageSize();
        }

        private void SavePageSize()
        {
            //write to cookie
            HttpCookie myCookie = new HttpCookie("PageSize");
            myCookie.Value = pageSize.ToString();
            myCookie.Expires = DateTime.Now.AddDays(30);
            HttpContext.Current.Response.Cookies.Add(myCookie);


        }

        private void LoadPageSize()
        {
            // get the cookie or create one
            HttpCookie myCookie = HttpContext.Current.Request.Cookies["PageSize"];
            if (myCookie == null)
            {
                pageSize = 5;
            }
            else
            {
                pageSize = Convert.ToInt32(myCookie.Value);
            }


        }

        public void Previous()
        {
            currentPage--;
            if (currentPage < 1)
            {
                currentPage = 1;
            }
            Save();
        }
        public void Next()
        {
            currentPage++;
            int Remainder = rowCount % pageSize;
            int NumberOfPages;

            NumberOfPages = rowCount / pageSize;
            if (Remainder != 0)
            {
                NumberOfPages++;
            }

            //stops from going past last page
            if (currentPage > NumberOfPages)
            {
                currentPage--;
            }
            Save();
        }

        public string GetPAgeSize()
        {
            return pageSize.ToString();
        }
        public void SetPageSize(int NewPageSize)
        {
            pageSize = NewPageSize;
            SavePageSize();
        }

        public DataSet getPage()
        {
            int rowStart;
            int rowEnd;
            //calculate start and end
            rowStart = ((currentPage - 1) * pageSize) + 1;
            rowEnd = (rowStart + pageSize) - 1;

            myDal.ClearParams();
            myDal.AddParam("@rowStart", rowStart.ToString());
            myDal.AddParam("@rowEnd", rowEnd.ToString());
            return myDal.ExecuteProcedure("spPageAlbum");
        }
    }
    
}