using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL_Project;
using System.Data;


namespace GroupProject
{
    public class LoadBoxes
    {
        DAL myDal = new DAL(Globals.conn);

        public DataSet LoadCourse()
        {
            myDal.ClearParams();
            DataSet ds = myDal.ExecuteProcedure("spLoadCourse");
            return ds;
        }

        public DataSet LoadClasses(string CourseId)
        {
            myDal.ClearParams();
            myDal.AddParam("@CourseId", CourseId);
            DataSet ds = myDal.ExecuteProcedure("spLoadClass");
            return ds;
        }

        public DataSet LoadQuizes(string CourseId)
        {
            myDal.ClearParams();
            myDal.AddParam("@CourseId", CourseId);
            DataSet ds = myDal.ExecuteProcedure("spLoadQuizes");
            return ds;
        }
        public DataSet LoadQuizVersions(string QuizId)
        {
            myDal.ClearParams();
            myDal.AddParam("@QuizId", QuizId);
            DataSet ds = myDal.ExecuteProcedure("spLoadVersion");
            return ds;
        }

        public DataSet LoadStudents(string ClassId)
        {
            DataSet ds = new DataSet();
            myDal.ClearParams();
            myDal.AddParam("@Classid", ClassId);
            ds = myDal.ExecuteProcedure("spGetStudents");
            return ds;
            
        }
    }
}