package cn.cslg.microblog.Service;

import java.util.HashMap;
import java.util.List;

import com.sun.javafx.collections.MappingChange.Map;

public interface SearchService {
	/**
	 * 根据搜索框内的值，找出符合条件的所有用户和所有微博
	 * @param value
	 * @return
	 */
	HashMap<String, List> searchResult(String value);
}
