package ch7;

import java.io.IOException;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.Elements;

public class WikiNodeExample {
	
	public static void main(String[] args) throws IOException {
		String url = "https://en.wikipedia.org/wiki/Java_(programming_language)";
		
		// download and parse the document
		Connection conn = Jsoup.connect(url);
		Document doc = conn.get();
		
		// select the content text and pull out the paragraphs.
		Element content = doc.getElementById("mw-content-text");
				
		// TODO: avoid selecting paragraphs from sidebars and boxouts
		Elements paras = content.select("p");
		Element firstPara = paras.get(1);
		
		// 上記のコードは,URLで設定されたタグの内容を持ってくる基礎的なステップです。
		
		recursiveDFS(firstPara);
		System.out.println();

		iterativeDFS(firstPara);
		System.out.println();

		Iterable<Node> iter = new WikiNodeIterable(firstPara);
		for (Node node: iter) {
			if (node instanceof TextNode) {
//				System.out.print(node);
				String str = ((TextNode) node).text();
				System.out.print(((TextNode) node).text());
			}
		}
	}

	private static void iterativeDFS(Node root) {
		Deque<Node> stack = new ArrayDeque<Node>();
		stack.push(root);

		// if the stack is empty, we're done
		while (!stack.isEmpty()) {

			// otherwise pop the next Node off the stack
			Node node = stack.pop();
			if (node instanceof TextNode) {
				System.out.print(node);
			}

			// push the children onto the stack in reverse order
			List<Node> nodes = new ArrayList<Node>(node.childNodes());
			Collections.reverse(nodes);
			
			for (Node child: nodes) {
				stack.push(child);
			}
		}
	}

	private static void recursiveDFS(Node node) {
		if (node instanceof TextNode) {
			System.out.print(node);
		}
		for (Node child: node.childNodes()) {
			recursiveDFS(child);
		}
	}
}