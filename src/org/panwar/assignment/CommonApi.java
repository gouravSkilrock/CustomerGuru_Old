package org.panwar.assignment;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class CommonApi {

	public JsonObject findingLocation(String locationName){


		String urlString = "http://samples.openweathermap.org/data/2.5/find?q="+locationName+"&units=metric&appid=b1b15e88fa797225412429c1c50c122a1";
		StringBuilder reqJson = null;
		HttpURLConnection connection=null;
		BufferedReader in = null;
		JsonObject o =null;
		try {
			URL url = new URL(urlString);
			 connection = (HttpURLConnection) url
					.openConnection();
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("userName",
					"E49B4EF3-1511-4B8B-86D2-CE78DA0F74D6");
			connection.setRequestProperty("password", "p@55w0rd");
			/*
			 * connection.setRequestProperty( "Cookie","JSESSIONID=" +
			 * "12ECA807E0C31320DE59FD6E355369A");
			 */
			OutputStreamWriter out = new OutputStreamWriter(
					connection.getOutputStream());

			Gson gson = new Gson();
			out.close();

			int responseCode = connection.getResponseCode();
			reqJson = new StringBuilder("");
			if (responseCode == 200) {
				in = new BufferedReader(new InputStreamReader(
						connection.getInputStream()));
				String responseString;
				while ((responseString = in.readLine()) != null) {
					reqJson.append(responseString);
				}

			} else {
				in = new BufferedReader(new InputStreamReader(
						connection.getErrorStream()));
				String responseString;
				while ((responseString = in.readLine()) != null) {
					reqJson.append(responseString);
				}
				System.out.println(reqJson);
				return null;
			}
			// Gson gson = new Gson();

			JsonParser parser = new JsonParser();
			o = (JsonObject) parser.parse(reqJson.toString());
			if(!(o.get("errorMessage") == null)){
				
			}
			// obj = gson.fromJson(decodedString, ServiceResponse.class);
			//System.out.println(obj);

			in.close();
		} catch (MalformedURLException e) {
			// TODO: handle exception
		} catch (ProtocolException e) {
			// TODO: handle exception
		} catch (IOException e) {
			e.printStackTrace();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
			if(in != null){
				in.close();
			}
			if(connection != null){
				connection.disconnect();
			}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	
		return o;
	}
}
