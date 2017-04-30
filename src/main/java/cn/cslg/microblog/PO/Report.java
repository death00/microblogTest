package cn.cslg.microblog.PO;

/**
 * 举报
 * @author Administrator
 *
 */
public class Report {
    private Integer id;
    
    private Integer reporterid;	//举报人的用户ID
    
    private User reporterUser;	//举报人的用户

    private Integer type;		//举报内容类型（1：用户举报；2：微博举报；3：评论举报；）

    private Integer reportedid;	//被举报的id（如果type为1，则为userId；如果type为2，则为microblogId；如果type为3，则为remarkId）
    
    private Object reported;	//被举报的对象（如果type为1，则为user；如果type为2，则为microblog；如果type为3，则为remark）

    private String reportreason;//举报理由

    private Integer state;		//状态（1：待处理；2：已通过；3：未通过；）
    
    //被举报者的用户ID（type为1，则和reportedId相同；type为2，则为该微博所属用户；type为3，则为该评论所属用户）
    //这个字段是用来统计举报的，无论是微博还是评论，最终都是对用户进行分析
    private Integer reportedUserId;
    
    private User reportedUser;	//被举报用户

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getReporterid() {
        return reporterid;
    }

    public void setReporterid(Integer reporterid) {
        this.reporterid = reporterid;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getReportedid() {
        return reportedid;
    }

    public void setReportedid(Integer reportedid) {
        this.reportedid = reportedid;
    }

    public Object getReported() {
		return reported;
	}

	public void setReported(Object reported) {
		this.reported = reported;
	}

	public String getReportreason() {
        return reportreason;
    }

    public void setReportreason(String reportreason) {
        this.reportreason = reportreason == null ? null : reportreason.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	public Integer getReportedUserId() {
		return reportedUserId;
	}

	public void setReportedUserId(Integer reportedUserId) {
		this.reportedUserId = reportedUserId;
	}

	public User getReporterUser() {
		return reporterUser;
	}

	public void setReporterUser(User reporterUser) {
		this.reporterUser = reporterUser;
	}

	public User getReportedUser() {
		return reportedUser;
	}

	public void setReportedUser(User reportedUser) {
		this.reportedUser = reportedUser;
	}
	
}