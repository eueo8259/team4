package kcg.system.t4_customer_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;

@Service
public class T4customerMngSvc {

	@Autowired
	CmmnDao cmmnDao;

	public List<CmmnMap> getAllCustomers(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getAllCustomers", params);
//		System.out.println(dataList);
		return dataList;
	}

	public CmmnMap deleteCust(CmmnMap params) {
		String customer_id = params.getString("customer_id");
		params.put("customer_id", customer_id);
		cmmnDao.update("system.t4_customer_mng.deleteCust", params);
		return new CmmnMap().put("status", "OK");

	}

	public CmmnMap updateCust(CmmnMap params) {
		String customer_id = params.getString("customer_id");
		String customer_name = params.getString("customer_name");
		String customer_level = params.getString("customer_level");
		String customer_phone = params.getString("customer_phone");
		String customer_sub_tel = params.getString("customer_sub_tel");
		String customer_email = params.getString("customer_email");
		String customer_job = params.getString("customer_job");
		String customer_addr = params.getString("customer_addr");

		params.put("customer_id", customer_id);
		params.put("customer_name", customer_name);
		params.put("customer_level", customer_level);
		params.put("customer_phone", customer_phone);
		params.put("customer_sub_tel", customer_sub_tel);
		params.put("customer_email", customer_email);
		params.put("customer_job", customer_job);
		params.put("customer_addr", customer_addr);
	

	    // 전화번호 중복 체크
	    CmmnMap existingCustomerPhone = cmmnDao.selectOne("system.t4_customer_mng.getCustPhone", params);
	    if (existingCustomerPhone != null) {
	        return new CmmnMap().put("status", "ERROR").put("message", "해당 전화번호로 등록된 고객이 이미 존재합니다. 다시 수정해 주세요.");
	    }

		cmmnDao.update("system.t4_customer_mng.updateCust", params);
		return new CmmnMap().put("status", "OK");
	}
	
	
	//중복 환인용 주민번호 조회
	public List<CmmnMap> getCustIdNumber(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getCustIdNumber", params);
		return dataList;
	}
	
	//중복 환인용 탈퇴 회원 주민번호 조회
	public List<CmmnMap> getQuitCustIdNumber(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getQuitCustIdNumber", params);
		return dataList;
	}

	
	//중복 확인용 전화번호 조회
	public List<CmmnMap> getCustPhone(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getCustPhone", params);
		return dataList;
	}


	public CmmnMap addCust(CmmnMap params) {

		String customer_name = params.getString("customer_name");
		String customer_id_number = params.getString("customer_id_number");
		String customer_phone = params.getString("customer_phone");
		String customer_sub_tel = params.getString("customer_sub_tel");
		String customer_email = params.getString("customer_email");
		String customer_job = params.getString("customer_job");
		String customer_addr = params.getString("customer_addr");
		String user_id = params.getString("user_id");

		params.put("customer_name", customer_name);
		params.put("customer_id_number", customer_id_number);
		params.put("customer_phone", customer_phone);
		params.put("customer_sub_tel", customer_sub_tel);
		params.put("customer_email", customer_email);
		params.put("customer_job", customer_job);
		params.put("customer_addr", customer_addr);
		params.put("user_id", user_id);

		// 사용중인 고객 주민번호 중복 체크
		CmmnMap existingCustomer = cmmnDao.selectOne("system.t4_customer_mng.getCustIdNumber", params);
		if (existingCustomer != null) {
			// 이미 존재하는 경우 처리
			return new CmmnMap().put("status", "ERROR").put("message", "해당 주민번호로 등록된 고객이 이미 존재합니다");
		}
		
		
		// 탈퇴한 고객 주민번호 중복 체크
		CmmnMap existingQuitCustomer = cmmnDao.selectOne("system.t4_customer_mng.getQuitCustIdNumber", params);
		if (existingQuitCustomer != null) {
			// 이미 존재하는 경우 처리
			return new CmmnMap().put("status", "ERROR").put("message", "해당 주민번호로 등록된 고객은 휴면상태입니다.\n휴면 고객 처리는 관리자에게 문의하세요");
		}
		
	    // 전화번호 중복 체크
	    CmmnMap existingCustomerPhone = cmmnDao.selectOne("system.t4_customer_mng.getCustPhone", params);
	    if (existingCustomerPhone != null) {
	        return new CmmnMap().put("status", "ERROR").put("message", "해당 전화번호로 등록된 고객이 이미 존재합니다.");
	    }

	    // 중복이 없는 경우 고객 등록
	    cmmnDao.insert("system.t4_customer_mng.addCust", params);
	    return new CmmnMap().put("status", "OK");

	}

	public List<CmmnMap> getAllconsult(CmmnMap params) {
		List<CmmnMap> consultList = cmmnDao.selectList("getAllconsult", params);
		// System.out.println(consultList);
		String user_id = params.getString("user_id");
		params.put("user_id", user_id);
		return consultList;
	}

	public CmmnMap addConsult(CmmnMap params) {
		String user_id = params.getString("user_id");
		String consult_title = params.getString("consult_title");
		String consult_context = params.getString("consult_context");
		String con_id = params.getString("con_id");

		params.put("user_id", user_id);
		params.put("consult_title", consult_title);
		params.put("consult_context", consult_context);
		params.put("con_id", con_id);

		cmmnDao.insert("system.t4_customer_mng.addConsult", params);
		return new CmmnMap().put("status", "OK");
	}





}