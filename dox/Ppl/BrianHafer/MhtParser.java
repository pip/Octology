import java.io.*;

public class MhtParser {

private static String startParse = "<DIV class=3Dtitle>";
private static String endParse = "dingbat.gif";

public static void main(String args[]) {

try {
  StringWriter strOut = new StringWriter();
  FileReader fileIn = new FileReader(new File(args[0]));
  FileWriter fileOut = new FileWriter(new File((args.length > 1) ? args[1] : args[0]));

  char[] cbuf = new char[64];
  int len;
  while ((len = fileIn.read(cbuf)) > 0) {
    strOut.write(cbuf, 0, len);
  }
  fileIn.close();
  String fileText = strOut.toString();
  fileText = fileText.substring(fileText.indexOf(startParse) + startParse.length()); 
  fileText = fileText.substring(0, fileText.indexOf(endParse));
  fileText = fileText.substring(0, fileText.lastIndexOf('<'));
  fileText = fileText.replaceAll("=[0-9A-F]{2}", "");
  fileText = fileText.replaceAll("=\r?\n", "\n");
  fileText = fileText.replaceAll("\r?\n", "\n");
  fileText = fileText.replaceAll("<[pP]>", "\n\n");
  fileText = fileText.replaceAll("<[^>]*>", " ");
  fileText = fileText.replaceAll("\n +", "\n");
  StringReader strIn = new StringReader(fileText);
  while ((len = strIn.read(cbuf)) > 0) {
    fileOut.write(cbuf, 0, len);
  }
  fileOut.flush();
  fileOut.close();
  System.out.println("Done: " + args[0] + " --> " + ((args.length > 1) ? args[1] : args[0]));
}
catch (Exception e) {
  e.printStackTrace();
  System.out.println("Usage: MhtParser input-file-name [output-file-name]");
}
}
}
