package com.spring.javaweb2S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb2S.dao.AdminDAO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.CouponVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

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
		for (int i = 0; i < codeArr.length; i++) {
			HashMap<String, String> map = new HashMap<>();

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
		for (int i = 0; i < sCodeArr.length; i++) {
			HashMap<String, String> map = new HashMap<>();

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

	@Override
	public void imgCheckProductInput(MultipartFile file, ProductVO vo) {
		// 먼저 기본(메인)그림파일은 'dbShop/product'폴더에 복사 시켜준다.
		try {
			String originalFilename = file.getOriginalFilename();
			if (originalFilename != null && originalFilename != "") {
				// 상품 메인사진을 업로드처리하기위해 중복파일명처리와 업로드처리
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
				String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName, "product"); // 메인 이미지를 서버에 업로드 시켜주는 메소드 호출
				vo.setFSName(saveFileName); // 서버에 저장된 파일명을 vo에 set시켜준다.
			} else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 0 1 2 3 4 5
		// 012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javaweb2S/data/shop/211229124318_4.jpg"
		// <img alt="" src="/javawewS/data/dbShop/product/211229124318_4.jpg"

		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 dbShop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if (content.indexOf("src=\"/") == -1)
			return; // content박스의 내용중 그림이 없으면 돌아간다.

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		// String uploadPath = request.getRealPath("/resources/data/dbShop/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");

		int position = 26;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;

		while (sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 '경로명+파일명'

			copyFilePath = uploadPath + "product/" + imgFile; // 복사가 될 '경로명+파일명'

			fileCopyCheck(oriFilePath, copyFilePath); // 원본그림이 복사될 위치로 복사작업처리하는 메소드

			if (nextImg.indexOf("src=\"/") == -1)
				sw = false;
			else
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// 이미지 복사작업이 종료되면 실제로 저장된 'dbShop/product'폴더명을 vo에 set시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/shop/", "/data/shop/product/"));

		// 파일 복사작업이 모두 끝나면 vo에 담긴내용을 상품의 내역을 DB에 저장한다.
		// 먼저 productCode를 만들어주기 위해 지금까지 작업된 dbProduct테이블의 idx필드중 최대값을 읽어온다. 없으면 0으로
		// 처리한다.
		int maxIdx = 1;
		ProductVO maxVo = adminDAO.getProductMaxIdx();
		if (maxVo != null) {
			maxIdx = maxVo.getIdx() + 1;
			vo.setIdx(maxIdx);
		}
		if (vo.getCategorySubCode() != null) {
			vo.setProductCode(vo.getCategoryMainCode() + vo.getCategorySubCode() + "-" + maxIdx);
		} else {
			vo.setProductCode(vo.getCategoryMainCode() + "-" + maxIdx);
		}
		// System.out.println("vo : " + vo);
		adminDAO.setProductInput(vo);
	}

	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);

		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);

			byte[] buffer = new byte[2048];
			int count = 0;
			while ((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName, String flag) throws IOException {
		byte[] data = fName.getBytes();

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		String readPath = "";
		if (flag.equals("product")) {
			readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/product/");
		} else if (flag.equals("mainImage")) {
			readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/mainImage/");
		}

		FileOutputStream fos = new FileOutputStream(readPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public ProductVO getProductInfo(String productName) {
		return adminDAO.getProductInfo(productName);
	}

	@Override
	public ArrayList<ProductVO> getMainName() {
		return adminDAO.getMainName();
	}

	@Override
	public ArrayList<ProductVO> getProductList(String part) {
		return adminDAO.getProductList(part);
	}

	@Override
	public List<ProductVO> getCategoryProductName(String categoryMainCode, String categorySubCode) {
		return adminDAO.getCategoryProductName(categoryMainCode, categorySubCode);
	}

	@Override
	public ProductVO getProductInfor(String productName) {
		return adminDAO.getProductInfor(productName);
	}

	@Override
	public List<OptionVO> getOptionList(int productIdx) {
		return adminDAO.getOptionList(productIdx);
	}

	@Override
	public void setOptionDelete(int idx) {
		adminDAO.setOptionDelete(idx);
	}

	@Override
	public int getOptionDupli(int productIdx, String[] optionName) {
		return adminDAO.getOptionDupli(productIdx, optionName);
	}

	@Override
	public void setOptionInput(OptionVO vo) {
		adminDAO.setOptionInput(vo);
	}

	@Override
	public ProductVO getProductInfoIdx(int idx) {
		return adminDAO.getProductInfoIdx(idx);
	}

	@Override
	public void imgCheckProductUpdate(MultipartFile file, ProductVO vo, ProductVO originVO) {
		// 먼저 기본(메인)그림파일은 'dbShop/product'폴더에 복사 시켜준다.
		try {
			String originalFilename = file.getOriginalFilename();
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/product/");
			if (originalFilename != null && originalFilename != "") {
				File originFile = new File(readPath + originVO.getFSName());
				if (originFile.exists()) {
					originFile.delete();
				}
				// 상품 메인사진을 업로드처리하기위해 중복파일명처리와 업로드처리
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
				String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName, "product"); // 메인 이미지를 서버에 업로드 시켜주는 메소드 호출
				vo.setFSName(saveFileName); // 서버에 저장된 파일명을 vo에 set시켜준다.
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 0 1 2 3 4 5
		// 012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javaweb2S/data/shop/211229124318_4.jpg"
		// <img alt="" src="/javawewS/data/dbShop/product/211229124318_4.jpg"

		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 dbShop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if (content.indexOf("src=\"/") != -1 && content != "") {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
					.getRequest();
			// String uploadPath = request.getRealPath("/resources/data/dbShop/");
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");

			int position = 26;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);
			boolean sw = true;

			while (sw) {
				String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
				String copyFilePath = "";
				String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 '경로명+파일명'

				copyFilePath = uploadPath + "product/" + imgFile; // 복사가 될 '경로명+파일명'

				fileCopyCheck(oriFilePath, copyFilePath); // 원본그림이 복사될 위치로 복사작업처리하는 메소드

				if (nextImg.indexOf("src=\"/") == -1)
					sw = false;
				else
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}

			boolean dSw = true;
			position += 8;
			String originContent = originVO.getContent();
			String originImg = originContent.substring(originContent.indexOf("src=\"/") + position);
			while(dSw) {
				String originImgFile = originImg.substring(0,originImg.indexOf("\""));
				File originFile = new File(uploadPath+originImgFile);
				if(originFile.exists()) originFile.delete();
				File originFileCopy = new File(uploadPath + "product/" + originImgFile);
				if(originFileCopy.exists()) originFileCopy.delete();
				
				if (originImg.indexOf("src=\"/") == -1)
					dSw = false;
				else
					originImg = originImg.substring(originImg.indexOf("src=\"/") + position);
			}
			
			// 이미지 복사작업이 종료되면 실제로 저장된 'dbShop/product'폴더명을 vo에 set시켜줘야 한다.
			vo.setContent(vo.getContent().replace("/data/shop/", "/data/shop/product/"));
		}
		String[] codeArray = originVO.getProductCode().split("-");

		int codeIdx = Integer.parseInt(codeArray[1]);

		if (vo.getCategorySubCode() != null) {
			vo.setProductCode(vo.getCategoryMainCode() + vo.getCategorySubCode() + "-" + codeIdx);
		} else {
			vo.setProductCode(vo.getCategoryMainCode() + "-" + codeIdx);
		}

		int idx = originVO.getIdx();
		adminDAO.setProductUpdate(vo, idx);
	}

	@Override
	public void imgCheckProductDelete(int idx) {
		ProductVO vo = adminDAO.getProductInfoIdx(idx);
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/product/");
		File file = new File(readPath + vo.getFSName());
		if (file.exists()) file.delete();
		
		String shopPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		int position = 34;
		
		
		boolean dSw = true;
		String content = vo.getContent();
		String contentImg = content.substring(content.indexOf("src=\"/") + position);
		while(dSw) {
			String delImgFile = contentImg.substring(0,contentImg.indexOf("\""));
			File delFile = new File(shopPath+delImgFile);
			if(delFile.exists()) delFile.delete();
			File delFileCopy = new File(shopPath + "product/" + delImgFile);
			if(delFileCopy.exists()) delFileCopy.delete();
			
			if (contentImg.indexOf("src=\"/") == -1)
				dSw = false;
			else
				contentImg = contentImg.substring(contentImg.indexOf("src=\"/") + position);
		}
		
		adminDAO.setProductDelete(idx);
	}

	@Override
	public void setProductCategoryUpdate(String mName, String originSCode, String sCode) {
		CategoryMainVO vo = adminDAO.getCategoryMainInfo(mName);
		
		
		String pCode = vo.getCategoryMainCode() + sCode;
		System.out.println(pCode);
		adminDAO.setProductCategoryUpdate(mName, originSCode, pCode);
	}

	@Override
	public ArrayList<CouponVO> getCouponList(int startIndexNo, int pageSize) {
		return adminDAO.getCouponList(startIndexNo, pageSize);
	}

	@Override
	public int setCouponInput(CouponVO couponVO) {
		return adminDAO.setCouponInput(couponVO);
	}

	@Override
	public ArrayList<CouponVO> getCouponDupli(String number, String name) {
		return adminDAO.getCouponDupli(number, name);
	}

	@Override
	public int setCouponDelete(String number) {
		return adminDAO.setCouponDelete(number);
	}

	@Override
	public ArrayList<CouponVO> getCouponListAll() {
		return adminDAO.getCouponListAll();
	}

	@Override
	public int setMemberCouponGive(String[] midArr, int coupon, int date) {
		return adminDAO.setMemberCouponGive(midArr, coupon, date);
	}
}
