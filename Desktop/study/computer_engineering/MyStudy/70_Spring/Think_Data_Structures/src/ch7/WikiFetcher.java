package ch7;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class WikiFetcher {
	private long lastRequestTime = -1;
	private long minInterval = 1000;
	public int flag;

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	/**
	 * Fetches and parses a URL string, returning a list of paragraph elements.
	 *
	 * @param url
	 * @return
	 * @throws IOException
	 */
	public Elements fetchWikipedia(String url, int num) throws IOException {
		sleepIfNeeded();

		// download and parse the document
		Connection conn = Jsoup.connect(url);
		Document doc = conn.get();

		// select the content text and pull out the paragraphs.
		Element content = doc.getElementById("mw-content-text");

		// TODO: avoid selecting paragraphs from sidebars and boxouts
//		Elements paras = content.select("p");
		Elements paras = null;
		if (num == 1) {
			System.out.println("num : " + 1);
			paras = content.select("ul li a");
//			paras = content1.select("a");
			System.out.println(paras.text());
			System.out.println("");
			System.out.println("");
			
		} else if (num == 0) {
			System.out.println("num : " + 0);
			paras = content.select("p");
			System.out.println(paras.text());
		}
		
		return paras;
	}

	/**
	 * Reads the contents of a Wikipedia page from src/resources.
	 *
	 * @param url
	 * @return
	 * @throws IOException
	 */
	public Elements readWikipedia(String url) throws IOException {
		URL realURL = new URL(url);
		System.out.println("realURL : " + realURL);

		// assemble the file name
		String slash = File.separator;
		System.out.println("slash : " + slash);
		String filename = "resources" + slash + realURL.getHost() + realURL.getPath();
		System.out.println("filename : " + filename);

		// read the file
		InputStream stream = WikiFetcher.class.getClassLoader().getResourceAsStream(filename);
		System.out.println("stream : " + stream);
		Document doc = Jsoup.parse(stream, "UTF-8", filename);
		System.out.println("doc : " + doc);

		// parse the contents of the file
		Element content = doc.getElementById("mw-content-text");
		System.out.println("content : " + content);
		Elements paras = content.select("p");
		Elements paras1 = content.select("ul");
		Element paragraph = paras.get(1);
		return paras;
	}
	
	
	/**
	 * Rate limits by waiting at least the minimum interval between requests.
	 */
	private void sleepIfNeeded() {
		if (lastRequestTime != -1) {
			long currentTime = System.currentTimeMillis();
			long nextRequestTime = lastRequestTime + minInterval;
			if (currentTime < nextRequestTime) {
				try {
					//System.out.println("Sleeping until " + nextRequestTime);
					Thread.sleep(nextRequestTime - currentTime);
				} catch (InterruptedException e) {
					System.err.println("Warning: sleep interrupted in fetchWikipedia.");
				}
			}
		}
		lastRequestTime = System.currentTimeMillis();
	}
	

	/**
	 * @param args
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		WikiFetcher wf = new WikiFetcher();
		String url = "https://en.wikipedia.org/wiki/Java_(programming_language)";
		Elements paragraphs = wf.readWikipedia(url);

		for (Element paragraph: paragraphs) {
			System.out.println(paragraph);
		}
	}
}