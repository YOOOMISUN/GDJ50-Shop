package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Service.CustomerService;

@WebServlet("/IdCkController")
public class IdCkController extends HttpServlet{
	private CustomerService customerService;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// json 인코딩, contentType setter
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		// 메서드 실행 위한 객체 초기화
		this.customerService = new CustomerService();
		
		// 값 받아오기
		String ckId = request.getParameter("ckid");
		
		// 디버깅
		System.out.println("ckId : " + ckId);
		
		
		String id = this.customerService.getIdCheck(ckId);
		
		// json으로 변경
		Gson gson = new Gson();
		String jsonStr = "";
		
		// id가 null일 경우, null이 아닐경우 
		if(id == null) {
			jsonStr = gson.toJson("y");
		} else {
			jsonStr = gson.toJson("n");
		}
		
		// HttpServletResponse 안에 out이 있어서 out을 쓰려면 밑에 세개 사용하고 써야함
		PrintWriter out = response.getWriter();
		out.write(jsonStr);
		out.flush();
		
		out.close();
		
		}
}
