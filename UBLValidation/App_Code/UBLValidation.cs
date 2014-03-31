using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Reflection;
using UBLValidator;


// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
public class ValidationService : IUBLValidation
{
	public string GetData(int value)
	{
		return string.Format("You entered: {0}", value);
	}
    public string HelloWorld()
    {
        return "hello  world from UBL Validation Service";
    }

    public string Ping()
    {
        string AppName = string.Empty;
        System.Reflection.Assembly thisAssembly = this.GetType().Assembly;
        object[] attributes = thisAssembly.GetCustomAttributes(typeof(AssemblyTitleAttribute), false);
        if (attributes.Length == 1)
        {
            AppName = (((AssemblyTitleAttribute)attributes[0]).Title);
        }

        return String.Format("{0} ({1})", AppName, Assembly.GetExecutingAssembly().GetName().Version);
    }

    public bool ValidateUBL(string TestXML, out string error)
    {
        byte[] buffer = GetBytes(TestXML);
        DocumentControl DocControl = new DocumentControl();
        return DocControl.IsDocumentValid(ref buffer, out error);
    }

    static byte[] GetBytes(string str)
    {
        byte[] bytes = new byte[str.Length * sizeof(char)];
        System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
        return bytes;
    }

}
