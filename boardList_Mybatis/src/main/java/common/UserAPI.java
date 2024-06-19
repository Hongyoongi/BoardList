package common;

public class UserAPI{
	 public static void mLine(char ch, int num){
		for(int i = 1; i <= num; i++){
			System.out.print(ch);
		}
		System.out.println();
	 }

public static String mLineReturn(char ch, int num){
	char line= ch;
	String result = "";

	for(int i=0; i < num; i++){
		result += line;
		}
	return result;
	}
}
