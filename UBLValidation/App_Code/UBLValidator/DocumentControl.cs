using System.Xml.XPath;
using System.IO;
using System.Xml;
using System;
using System.Xml.Xsl;
using System.Diagnostics;
namespace UBLValidator
{
    public class DocumentControl
    {
        public enum DocumentType
        {
            OIOXMLInvoice,
            OIOXMLCreditNote,
            UBL2Invoice,
            UBL2CreditNote,
            UBL2ApplicationResponse,
            UBL2Order,
            UBL2Reminder,
            UBL2UtilityStatement,
            Other
        }

        private Validator _schemaValidator = new Validator();

        private static DocumentType GetDocumentType(ref byte[] data)
        {
            XPathDocument xpathDoc = new XPathDocument(new MemoryStream(data));
            XPathNavigator nav = xpathDoc.CreateNavigator();
            nav.MoveToFollowing(XPathNodeType.Element);
            string ns = nav.NamespaceURI;
            switch (ns)
            {
                /*OIOXML_Invoice*/
                case "http://rep.oio.dk/ubl/xml/schemas/0p71/pie/":
                    return DocumentType.OIOXMLInvoice;
                /*OIOXML_CreditNote*/
                case "http://rep.oio.dk/ubl/xml/schemas/0p71/pcm/":
                    return DocumentType.OIOXMLCreditNote;
                /*UBL2_Invoice*/
                case "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2":
                    return DocumentType.UBL2Invoice;
                /*UBL2_CreditNote*/
                case "urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2":
                    return DocumentType.UBL2CreditNote;
                /*UBL2_ApplicationResponse*/
                case "urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2":
                    return DocumentType.UBL2ApplicationResponse;
                /*UBL2_Order*/
                case "urn:oasis:names:specification:ubl:schema:xsd:Order-2":
                    return DocumentType.UBL2Order;
                /*UBL2_Reminder*/
                case "urn:oasis:names:specification:ubl:schema:xsd:Reminder-2":
                    return DocumentType.UBL2Reminder;
                /*UBL2_UtilityStatement*/
                case "urn:oioubl:names:specification:oioubl:schema:xsd:UtilityStatement-2":
                    return DocumentType.UBL2UtilityStatement;
                /*Unknown*/
                default:
                    return DocumentType.Other;
            }
        }

        public bool IsDocumentValid(ref byte[] data, out string error)
        {
            try
            {
                string schematron = "";
                error = "";
                XmlDocument xmlDocument = new XmlDocument();
                xmlDocument.Load(new MemoryStream(data));
                XmlSchematronValidator schematronValidator = new XmlSchematronValidator();
                switch (GetDocumentType(ref data))
                {
                    case DocumentType.UBL2Invoice:
                        schematron = Resources.UBLXsl.OIOUBL_Invoice_Schematron;
                        break;
                    case DocumentType.UBL2CreditNote:
                        schematron = Resources.UBLXsl.OIOUBL_CreditNote_Schematron;
                        break;
                    case DocumentType.UBL2ApplicationResponse:
                        schematron = Resources.UBLXsl.OIOUBL_ApplicationResponse_Schematron;
                        break;
                    case DocumentType.UBL2Order:
                        schematron = Resources.UBLXsl.OIOUBL_Order_Schematron;
                        break;
                    case DocumentType.UBL2Reminder:
                        schematron = Resources.UBLXsl.OIOUBL_Reminder_Schematron;
                        break;
                    case DocumentType.UBL2UtilityStatement:
                        schematron = Resources.UBLXsl.OIOUBL_UtilityStatement_Schematron;
                        break;
                    default:
                        return true;
                }
                /*Schema validation*/
                bool schemaResult = false;
                schemaResult = _schemaValidator.ValidXmlDoc(xmlDocument);
                error = _schemaValidator.ValidationError;

                bool schematronResult = false;
                if (schemaResult)
                {
                    XslCompiledTransform xslt = new XslCompiledTransform();
                    System.Text.UnicodeEncoding encoding = new System.Text.UnicodeEncoding();
                    Byte[] bytes = encoding.GetBytes(schematron);
                    MemoryStream ms = new MemoryStream(bytes);
                    XmlReader reader = XmlReader.Create(ms);
                    xslt.Load(reader); 
                    schematronResult = schematronValidator.ValidXmlDocument(xmlDocument, xslt);
                    error = schematronValidator.ValidationError;
                }
                return schemaResult && schematronResult;
            }
            catch (Exception e) { error = e.Message.ToString(); return false; }
        }
     }
}
