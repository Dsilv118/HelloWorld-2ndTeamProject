package com.lec.helloworld.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;
import com.lec.helloworld.dao.QnaBoardDao;
import com.lec.helloworld.util.Paging;
import com.lec.helloworld.vo.QnaBoard;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	@Autowired
	private QnaBoardDao qnaBoardDao;
	private String backupPath = "D:/webPro/project/helloWorld/helloworld/src/main/webapp/qnaBoardFileUp/";
	
	private int filecopy(String serverFile, String backupFile) {
		int isCopy = 0;
		FileInputStream is = null;
		FileOutputStream os = null;
		try {
			is = new FileInputStream(serverFile);
			os = new FileOutputStream(backupFile);
			File sFile = new File(serverFile);
			byte[] buff = new byte[(int)sFile.length()];
			while(true) {
				int nRead = is.read(buff);
				if(nRead == -1) {
					break;
				}
				os.write(buff, 0, nRead);
			}
			isCopy = 1;
		} catch (FileNotFoundException e) {
			System.out.println("복사 예외0 : "+e.getMessage());
		} catch (IOException e) {
			System.out.println("복사 예외1 : "+e.getMessage());
		} finally {
			try {
				if(os!=null) {
					os.close();
				}
				if(is!=null) {
					is.close();
				}
			} catch (Exception e) {
			}
		}
		return isCopy;
	}
	
	@Override
	public List<QnaBoard> qnaBoardList(QnaBoard qnaBoard, String pageNum, Model model) {
		Paging paging = new Paging(qnaBoardDao.totCntQna(qnaBoard), pageNum, 10, 10);
		qnaBoard.setStartRow(paging.getStartRow());
		qnaBoard.setEndRow(paging.getEndRow());
		model.addAttribute("paging", paging);
		return qnaBoardDao.qnaBoardList(qnaBoard);
	}

	@Override
	public int totCntQna(QnaBoard qnaBoard) {
		return qnaBoardDao.totCntQna(qnaBoard);
	}

	@Override
	public QnaBoard contentQna(int qanum) {
		qnaBoardDao.hitUpQna(qanum);
		return qnaBoardDao.contentQna(qanum);
	}

	@Override
	public void writeQna(QnaBoard qnaBoard, MultipartHttpServletRequest mRequest, Model model) {
		String uploadPath = mRequest.getRealPath("fileUp/");
		Iterator<String> params = mRequest.getFileNames();
		String qafile = "";
		if(params.hasNext()) {
			String param = params.next();
			MultipartFile mFile = mRequest.getFile(param);
			qafile = mFile.getOriginalFilename();
			
			if(qafile!=null && !qafile.equals("")) {
				if(new File(uploadPath + qafile).exists()) {
					qafile = System.currentTimeMillis() + "_" + qafile;
				} // 중복된 파일은 파일명 변경
				try {
					mFile.transferTo(new File(uploadPath + qafile));
					System.out.println("서버파일 : " + uploadPath + qafile);
					System.out.println("백업파일 : " + backupPath + qafile);
					int result = filecopy(uploadPath + qafile, backupPath + qafile);
					System.out.println(result == 1? "파일 복사 성공" : "파일 복사 실패");
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}// while
		qnaBoard.setQafile(qafile);
		try {
			qnaBoardDao.writeQna(qnaBoard);
			model.addAttribute("successMsg", "글쓰기가 완료되었습니다");
		}catch (Exception e) {
			model.addAttribute("failMsg", "글쓰기에 실패했습니다");
		}
	}

	@Override
	public void modifyQna(QnaBoard qnaBoard, MultipartHttpServletRequest mRequest, Model model) {
		String uploadPath = mRequest.getRealPath("fileUp/");
		Iterator<String> params = mRequest.getFileNames();
		String qafile = "";
		if(params.hasNext()) {
			String param = params.next();
			MultipartFile mFile = mRequest.getFile(param);
			qafile = mFile.getOriginalFilename();
			
			if(qafile!=null && !qafile.equals("")) {
				if(new File(uploadPath + qafile).exists()) {
					qafile = System.currentTimeMillis() + "_" + qafile;
				} // 중복된 파일은 파일명 변경
				try {
					mFile.transferTo(new File(uploadPath + qafile));
					System.out.println("서버파일 : " + uploadPath + qafile);
					System.out.println("백업파일 : " + backupPath + qafile);
					int result = filecopy(uploadPath + qafile, backupPath + qafile);
					System.out.println(result == 1? "파일 복사 성공" : "파일 복사 실패");
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}// while
		qnaBoard.setQafile(qafile);
		try {
			qnaBoardDao.writeQna(qnaBoard);
			model.addAttribute("successMsg", "글쓰기가 완료되었습니다");
		}catch (Exception e) {
			model.addAttribute("failMsg", "글쓰기에 실패했습니다");
		}
	}

	@Override
	public void replyQna(QnaBoard qnaBoard, MultipartHttpServletRequest mRequest, Model model) {
		// TODO Auto-generated method stub
	}

	@Override
	public int deleteQna(int qagroup, Model model) {
		int result = 0;
		try {
			result = qnaBoardDao.deleteQna(qagroup);
			model.addAttribute("successMsg", "글 삭제를 완료되었습니다");
		}catch (Exception e) {
			model.addAttribute("failMsg", "글 삭제에 실패했습니다");
		}
		return result;
	}

	@Override
	public void imageUpload(HttpServletRequest req, HttpServletResponse resp, MultipartHttpServletRequest multiFile) {
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		
		if(file != null) {
			if(file.getSize() >0 && StringUtils.isNotBlank(file.getName())) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
				    try{
				    	 
			            String fileName = file.getOriginalFilename();
			            byte[] bytes = file.getBytes();
			           
			            String uploadPath = req.getSession().getServletContext().getRealPath("/resources/bBoardimg"); //저장경로
			            System.out.println("uploadPath:"+uploadPath);

			            File uploadFile = new File(uploadPath);
			            if(!uploadFile.exists()) {
			            	uploadFile.mkdir();
			            }
			            String fileName2 = UUID.randomUUID().toString();
			            uploadPath = uploadPath + "/" + fileName2 +fileName;
			            
			            out = new FileOutputStream(new File(uploadPath));
			            out.write(bytes);
			            int result = filecopy(uploadPath, "D:/webPro/project/helloWorld/helloworld/src/main/webapp/resources/qnaBoardImg/"+fileName2+fileName);
			    		if(result==1) {
			    			System.out.println("파일 백업 성공");
			    		}
			            printWriter = resp.getWriter();
			            String fileUrl = req.getContextPath() + "/resources/bBoardimg/" +fileName2 +fileName; //url경로
			            System.out.println("fileUrl :" + fileUrl);
			            JsonObject json = new JsonObject();
			            json.addProperty("uploaded", 1);
			            json.addProperty("fileName", fileName);
			            json.addProperty("url", fileUrl);
			            printWriter.print(json);
			            System.out.println(json);
			 
			        }catch(IOException e){
			           System.out.println(e.getMessage());
			        } finally {
			        	try {
				            if (out != null) { out.close(); }
			                if (printWriter != null) {printWriter.close();}
			        	}catch (Exception e) {
							// TODO: handle exception
						}
			        }//try
				}//if
			}//if
		}//if
	}

}
