import com.chen.code.common.utils.ToolUtils;

import java.sql.*;
import java.util.*;

/**
 * Created by Administrator on 2017/11/20.
 */
public class JDBCUtils {

	//JDBC配置，请修改为你项目的实际配置
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/authority";
	private static final String JDBC_USERNAME = "root";
	private static final String JDBC_PASSWORD = "123";
	private static final String JDBC_DIVER_CLASS_NAME = "com.mysql.jdbc.Driver";

	static{
		try {
			Class.forName(JDBC_DIVER_CLASS_NAME); // 注册驱动
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}
	private static Connection getConnection(){
		try {
			return DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static void close(Connection conn , PreparedStatement ps , ResultSet rs ){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				if(ps != null){
					try {
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}finally{
						if(rs != null){
							try {
								rs.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
					}
				}
			}
		}
	}



	//DDL操作
	public static List<Map> getMapBySql(String sql,Object...params){
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			conn = JDBCUtils.getConnection();
			ps = conn.prepareStatement(sql);
			if(params != null && params.length>0){
				for(int i = 0 ; i < params.length ; i++){
					ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			//类ResultSet有getMetaData()会返回数据的列和对应的值的信息，然后我们将列名和对应的值作为map的键值存入map对象之中...
			ResultSetMetaData  rsmd = rs.getMetaData();

			int colCount = rsmd.getColumnCount();
			// 因为要存储列的名字，所以要与列的个数相同
			String[] colNames = new String[colCount];

            /* 装上列的名字
             * getColumnLabel 别名
             * getColumnLabel()方法的索引是从1开始的
             */
			for (int i = 1; i <= colCount; i++) {
				colNames[i-1] = rsmd.getColumnLabel(i);
			}

			List<Map> mapList = new ArrayList();
			while(rs.next()){
				Map<String,Object> data = new HashMap();
				for(int i = 0 ; i < colCount ; i++){
					String key = colNames[i];
					Object value = rs.getObject(colNames[i]);
					data.put(key, value);
				}
				mapList.add(data);
			}
			return mapList;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally{
			JDBCUtils.close(conn, ps, rs);
		}
	}


	public static List<Map> queryColumns(String tableName){
		String sql = "select column_name columnName, data_type dataType, column_comment columnComment, column_key columnKey, extra,CHARACTER_MAXIMUM_LENGTH len from information_schema.columns" +
				" where table_name = ? and table_schema = (select database()) order by ordinal_position";
		List<Map> data = JDBCUtils.getMapBySql(sql, tableName);
		return data;
	}

	public static Map<String,String> queryTable(String tableName) {
		String sql = "select table_name tableName, engine, table_comment tableComment, create_time createTime,TABLE_SCHEMA dbName  from information_schema.tables " +
				"where table_schema = (select database()) and table_name = ?";
		List<Map> data = JDBCUtils.getMapBySql(sql, tableName);
		if(ToolUtils.isEmpty(data)){
			return Collections.emptyMap();
		}
		return data.get(0);
	}

}
