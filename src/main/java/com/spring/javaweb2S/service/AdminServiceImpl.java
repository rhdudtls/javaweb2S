package com.spring.javaweb2S.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.AdminDAO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<MemberVO> getMemberList() {
		return adminDAO.getMemberList();
	}
	
	@Override
	public ArrayList<MemberVO> getMemberList(String searchType, String searchString) {
		return adminDAO.getMemberList(searchType, searchString);
	}

	@Override
	public int setMemberDel(int idx) {
		return adminDAO.setMemberDel(idx);
	}

	@Override
	public int setMemberDel() {
		return adminDAO.setMemberDel();
	}

	@Override
	public int setLevelUpdate(int idx, int level) {
		return adminDAO.setLevelUpdate(idx, level);
	}

	@Override
	public int setPointUpdate(int idx, int point) {
		return adminDAO.setPointUpdate(idx, point);
	}

	@Override
	public MemberVO getMemberInfo(int idx) {
		return adminDAO.getMemberInfo(idx);
	}

	@Override
	public ArrayList<CategoryMainVO> getCategoryMainList() {
		return adminDAO.getCategoryMainList();
	}

	@Override
	public int setCategoryMainUpdate(String code, String name) {
		return adminDAO.setCategoryMainUpdate(code, name);
	}

	@Override
	public CategoryMainVO getCategoryMainInfo(String name) {
		return adminDAO.getCategoryMainInfo(name);
	}

	@Override
	public int getCategoryDupli(String db, String flag, String[] arr) {
		return adminDAO.getCategoryDupli(db, flag, arr);
	}

	@Override
	public int setCategoryMainInput(String[] codeArr, String[] nameArr) {
		
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for(int i = 0; i < codeArr.length; i++) {
			HashMap<String, String> map= new HashMap<>();

			map.put("code", codeArr[i]);
			map.put("name", nameArr[i]);
			
			list.add(map);
		}
		
		return adminDAO.setCategoryMainInput(list);
	}

	@Override
	public ArrayList<CategorySubVO> getCategorySubList() {
		return adminDAO.getCategorySubList();
	}

	@Override
	public int setCategoryDelete(String flag, String code) {
		return adminDAO.setCategoryDelete(flag, code);
	}

	@Override
	public int getCategorySubDupli(String flag, String sub) {
		return adminDAO.getCategorySubDupli(flag, sub);
	}

	@Override
	public int setCategorySubUpdate(String mName, String sCode, String sName, String originSCode) {
		return adminDAO.setCategorySubUpdate(mName, sCode, sName, originSCode);
	}

	@Override
	public int setCategorySubInput(String[] sCodeArr, String[] sNameArr, String[] mCodeArr) {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for(int i = 0; i < sCodeArr.length; i++) {
			HashMap<String, String> map= new HashMap<>();

			map.put("sCode", sCodeArr[i]);
			map.put("sName", sNameArr[i]);
			map.put("mCode", mCodeArr[i]);
			
			list.add(map);
		}
		
		return adminDAO.setCategorySubInput(list);
	}

	@Override
	public ArrayList<CategorySubVO> getCategorySubName(String mainCode) {
		return adminDAO.getCategorySubName(mainCode);
	}


}
