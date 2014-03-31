using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using System.IO;

namespace UBLValidator
{
    public class XmlSchematronValidator
    {
        public bool ValidXmlDocument(XmlDocument document, XslCompiledTransform xslt)
        {
            bool isValid = false;
            XPathDocument xpath = new XPathDocument(new XmlNodeReader(document));
            MemoryStream stream = new MemoryStream();
            xslt.Transform(xpath, null, stream);
            stream.Position = 0;
            isValid = TransformationValid(new XPathDocument(stream));
            stream.Dispose();
            return isValid;
        }

        public string ValidationError { get; set; }

        private bool TransformationValid(XPathDocument validationResult)
        {
            var resNav = validationResult.CreateNavigator();
            var list = new List<ErrorClass>();
            string description = "", pattern = "";

            foreach (XPathNavigator pathNav in resNav.Select("//Error"))
            {
                foreach (XPathNavigator child in pathNav.SelectChildren(XPathNodeType.All))
                {
                    if (child.Name == "Description")
                        description = child.Value;
                    if (child.Name == "Pattern")
                        pattern = child.Value;
                }
                list.Add(new ErrorClass
                {
                    Context = pathNav.HasAttributes ? pathNav.GetAttribute("context", "") : "",
                    Pattern = pattern,
                    Description = description
                });
                ValidationError += description + "; ";
            }
            return list.Count == 0;
        }
        private class ErrorClass
        {
            public string Context { get; set; }
            public string Pattern { get; set; }
            public string Description { get; set; }
        }
    }
}
