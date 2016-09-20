

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.UnknownFormatConversionException;

public class encodeApiKey {
    public static void main(String args[]) {
        try {
            String key = args[0];
            byte[] keyBytes = key.getBytes("UTF-8");
            String encodedKey = Base64.getEncoder().encodeToString(keyBytes);
            System.out.println(encodedKey);
        } catch (UnsupportedEncodingException e) {
            System.out.println(e);
        }
    }
}
