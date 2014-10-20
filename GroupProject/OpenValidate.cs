﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Xml;
using System.Xml.Schema;
using System.IO;

namespace GroupProject
{
    public class OpenValidate
    {
        public bool failed = false;
        public string status = null;

        private void ValidationCallBack(object sender, ValidationEventArgs args)
        {
            if (args.Severity == XmlSeverityType.Warning)
                status += "\nWarning: Matching schema not found.  No validation occurred." + args.Message;
            else
                status = "\tValidation error: " + args.Message;
            failed = true;
        }
        public void ValidateXml(string xmlFilename, string schemaFilename)
        {
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.ValidationType |= ValidationType.Schema;
            settings.ValidationFlags |= XmlSchemaValidationFlags.ProcessInlineSchema;
            settings.ValidationFlags |= XmlSchemaValidationFlags.ProcessSchemaLocation;
            settings.ValidationFlags |= XmlSchemaValidationFlags.ReportValidationWarnings;
            settings.ValidationEventHandler += new ValidationEventHandler(ValidationCallBack);
            //XmlSchemaSet schemas = new XmlSchemaSet();
            //settings.Schemas = schemas;
            settings.Schemas.Add("urn:Question-Schema", schemaFilename);

            XmlReader validator = XmlReader.Create(xmlFilename, settings);
            while (validator.Read()) 
            { };
        }
    }
}