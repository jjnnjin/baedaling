package com.bd.common;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bd.common.APISerializer;

@Controller("point.pointController")
@RequestMapping("/point/*")
public class PointController {
	@Autowired
	private APISerializer api;
	
	@RequestMapping(value="search", produces="appliction/json;charset=utf-8")
	@ResponseBody
	public String search(
				@RequestParam String point
			) throws Exception {
		String result="";
		String urlDef="http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll";
		String serviceKey="kWLd47TbqbElMzCTQ80Db%2F2HoTnbNrUSODvFSNjLHwohPXntLN58C4Lnn1CvffiSLZXqqoAK6CdWdy2BRfnfNg%3D%3D";

		int countPerPage=10;
		int currentPage=1;
		
		urlDef += "?serviceKey="+serviceKey;
		urlDef += "&countPerPage="+countPerPage;
		urlDef += "&currentPage="+currentPage;
		urlDef += "&srchwrd="+URLEncoder.encode(point,"utf-8");
		result = api.receiveToString(urlDef);
		return result;
	}
}
