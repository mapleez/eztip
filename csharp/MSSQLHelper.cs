using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

namespace SQLAccess
{
    /// <summary>
    /// 数据库操作类
    /// </summary>
    public class DataAccess
    {
        private SqlCommand comm;
        private SqlConnection conn;
        private SqlDataAdapter adapter;
		
		private String connString;

        public DataAccess()
        {
			this.connString = ConfigurationManager.AppSettings["sqlConnString"];
			this.conn = new SqlConnection (this.connString);
			this.comm = new SqlCommand ();
			this.comm.Connection = this.conn;
			this.adapter = new SqlDataAdapter ();
        }
		
		
        /// <summary>
        /// 执行带参数或不带参数的sql语句或存储过程，返回执行状态
        /// </summary>
        /// <param name="sqlStr">sql语句</param>
        /// <param name="type">执行类型</param>
        /// <param name="paras">默认数量的参数</param>
        /// <returns>返回数据库执行状态码</returns>
        public int ExecuteNonQuery(string _sql, CommandType _type, params SqlParameter[] _paras)
        {
			int res = -1;
			this.comm.Parameters.Clear ();
			if (_paras != null)
				this.comm.Parameters.AddRange (_paras);
            this.comm.CommandText = _sql;
            this.comm.CommandType = _type;
            try {
                this.conn.Open ();
                res = comm.ExecuteNonQuery ();
                return res;
            }
            catch (Exception ex) {
				  // throw all onto upper layer 
                return res;
            }
			finally {
				conn.Close ();
			}
        }

        /// <summary>
        /// 执行带参数或不带参数的存储过程，返回存储过程中的int型返回值
        /// </summary>
        /// <param name="sqlStr">存储过程名</param>
        /// <param name="paras">任意多的参数</param>
        /// <returns></returns>
        public int ExecuteNonQueryWithReturn(string _sql, params SqlParameter[] _paras)
        {
			// add return parameter
            SqlParameter rtn = new SqlParameter ();
            returnValue.Direction = ParameterDirection.ReturnValue;
			this.comm.Parameters.Clear ();
			if (_paras != null) 
				this.comm.Parameters.AddRange (_paras);
            this.comm.Parameters.Add (rtn);
            this.comm.CommandText = _sql;
            this.comm.CommandType = CommandType.StoredProcedure;
            try {
                conn.Open();
                comm.ExecuteNonQuery();
                return int.Parse(rtn.Value.ToString());
            }
            catch (Exception ex) {
				// throw all onto upper layer 
                return -1;
            }
			finally {
				conn.Close ();
			}
        }

        /// <summary>
        /// 异步执行,作为静态方法，是执行的最小单元
        /// </summary>
        /// <param name="sqlStr"></param>
        /// <param name="paras"></param>
        /// <returns></returns>
        public static int BeginExecuteQuery(string _sql, CommandType _type, params SqlParameter[] _paras)
        {
            SqlConnection _con = new SqlConnection (ConfigurationManager.AppSettings["sqlConnString"]);
            SqlCommand _cmd = new SqlCommand (_con);
            _cmd.CommandText = _sql;
            _cmd.CommandType = _type
			_cmd.Parameters.Clear ();
            _cmd.Parameters.AddRange(_paras);
			
            try {
                _con.Open ();
                //  async run
                IAsyncResult asyncResult = _cmd.BeginExecuteNonQuery (DataAccess.CallBackExecuteNonQuery, null);
                return 1;   // indicate as an success in call the fxn
            }
            catch (Exception ex) {
				// throw all onto upper layer 
                return -1;
            }
            finally {
                if (_con != null) {
                    _con.Close ();
                    _con.Dispose ();
					_cmd.Dispose ();
                }
            }
        }

        /// <summary>
        /// 异步执行回调函数，用于传给command对象的异步回调代理
        /// </summary>
        /// <param name="callBack"></param>
        protected static void CallBackExecuteNonQuery(IAsyncResult _call_back)
        {
            SqlCommand _cmd = null;
            try
            {
                _cmd = (SqlCommand)callBack.AsyncState;
                if (_cmd != null)
					_cmd.EndExecuteNonQuery (_call_back);
				return;
            }
            catch (Exception ex)
            {
            }
            finally
            {
                //关闭相关的实体
                if (_cmd != null && _cmd.Connection != null)
                {
                    _cmd.Connection.Close();
					_cmd.Dispose();
                }
            }

        }

        /// <summary>
        /// 执行并返回结果集
        /// </summary>
        /// <param name="sqlStr">存储过程名称或结果集</param>
        /// <param name="ct">命令形式</param>
        /// <param name="paras">参数类型</param>
        /// <returns>结果集</returns>
        public DataTable ExecuteQuery(string _sql, CommandType _type, params SqlParameter[] _paras) {
		
            DataTable dset = null;
			this.comm.Parameters.Clear ();
			if (_paras != null)
				this.comm.Parameters.AddRange(_paras);
            this.comm.CommandText = _sql;
            this.comm.CommandType = _type;
			this.adapter.SelectCommand = comm;
            try {
                conn.Open();
                adapter.Fill(dset);
                return dset;
            }
            catch (Exception ex) {
                return dset;
            }
            finally {
                conn.Close();
            }
        }
    }
}
