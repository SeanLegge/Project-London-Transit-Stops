using System;
using System.Xml.Xsl;
using System.IO;

namespace LTCStops
{
    //Created by: Sean Legge
    //Student Number: 0062897
    //Date: March 26th 2016
    //Create a c# console program that takes in user input and passes it into the xslt to be used to search the xml file.
    class Program
    {
        private const string XML_FILE = @"..\..\..\ltcstops.xml";
        private const string XSLT_FILE = @"..\..\..\LTC_Stop.xslt";
        private const string HTML_FILE = @"..\..\..\StreetStops.html";
        static void Main(string[] args)
        {
            // Display a title
            Console.WriteLine("Generate a list of London transit bus stops based the users input.");

            string streetName;
            

                // Get the name of a character from the user
                Console.Write("\nEnter the name of the street you wish to find the bus stops for: ");
                streetName = Console.ReadLine();

            try
            {
                // Create a new XslTransform object and load the style sheet
                XslCompiledTransform xslt = new XslCompiledTransform();
                xslt.Load(XSLT_FILE);

              
                XsltArgumentList xsltArgList = new XsltArgumentList();
                xsltArgList.AddParam("streetName", "", streetName);

                // Execute the transformation 
                FileStream outFile = File.Create(HTML_FILE);
                xslt.Transform(XML_FILE, xsltArgList, outFile);
                outFile.Close();

               
                System.Diagnostics.Process proc = new System.Diagnostics.Process();
                proc.StartInfo.FileName = "iexplore";
                proc.StartInfo.Arguments = Directory.GetCurrentDirectory().ToString() + "\\" + HTML_FILE;
                proc.Start();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
            }
        }
    }
}
