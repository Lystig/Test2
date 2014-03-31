using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Schema;
using System.Xml;
using System.IO;
using System.Reflection;
using System.Collections;
using System.Globalization;
using System.Resources;
namespace UBLValidator
{
    public class Validator
    {
        private XmlSchemaSet schemaSet = new XmlSchemaSet();
        private bool isValidXml = true;
        public Validator() 
        {
            ResourceSet resourceSet = Resources.UBLXsds.ResourceManager.GetResourceSet(CultureInfo.CurrentUICulture, true, true);
            foreach (DictionaryEntry entry in resourceSet)
            {
                AddXsd(entry.Key.ToString(), entry.Value.ToString());
            }
            schemaSet.Compile();
            if (schemaSet.IsCompiled)
            {
                isValidXml = true;
            }
        }
        public string ValidationError { get; set; }

        public bool ValidXmlDoc(XmlDocument xml)
        {
            try
            {
                xml.Schemas.Add(schemaSet);
                xml.Validate(ValidationCallBack);
            }
            catch { isValidXml = false; }
            return isValidXml;
        }
         
        private void ValidationCallBack(object sender, ValidationEventArgs args)
        {
            // The xml does not match the schema.
            isValidXml = false;
            this.ValidationError = args.Message;
        }
        private void AddXsd(string XsdNS, string XsdString) 
        {
            System.Text.ASCIIEncoding encoding = new System.Text.ASCIIEncoding();
            Byte[] bytes = encoding.GetBytes(XsdString);
            MemoryStream ms = new MemoryStream(bytes);
            XmlReader reader = XmlReader.Create(ms);
            schemaSet.Add(null, reader);
        }

    }
}
