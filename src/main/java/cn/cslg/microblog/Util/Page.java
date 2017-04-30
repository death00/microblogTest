package cn.cslg.microblog.Util;

import java.util.List;

public class Page
{
  private int everyPage = 10;
  private int totalCount;
  private int totalPage;
  private int beginPage = 1;
  private boolean hasPrePage;
  private boolean hasNextPage;
  private List list;
  
  public int getEveryPage()
  {
    return this.everyPage;
  }
  
  public void setEveryPage(int everyPage)
  {
    this.everyPage = everyPage;
  }
  
  public int getTotalCount()
  {
    return this.totalCount;
  }
  
  public void setTotalCount(int totalCount)
  {
    this.totalCount = totalCount;
  }
  
  public int getTotalPage()
  {
    return this.totalPage;
  }
  
  public void setTotalPage(int totalPage)
  {
    this.totalPage = totalPage;
  }
  
  public int getBeginPage()
  {
    return this.beginPage;
  }
  
  public void setBeginPage(int beginPage)
  {
    this.beginPage = beginPage;
  }
  
  public boolean isHasPrePage()
  {
    return this.hasPrePage;
  }
  
  public void setHasPrePage(boolean hasPrePage)
  {
    this.hasPrePage = hasPrePage;
  }
  
  public boolean isHasNextPage()
  {
    return this.hasNextPage;
  }
  
  public void setHasNextPage(boolean hasNextPage)
  {
    this.hasNextPage = hasNextPage;
  }
  
  public List getList()
  {
    return this.list;
  }
  
  public void setList(List list)
  {
    this.list = list;
  }
  
  public void init(){
	  int totalPage = totalCount % everyPage == 0 ? totalCount / everyPage : totalCount / everyPage + 1;
	  this.setTotalPage(totalPage);
	  this.setHasNextPage(beginPage >= totalCount);
	  this.setHasPrePage(beginPage <= 1);
  }
}
