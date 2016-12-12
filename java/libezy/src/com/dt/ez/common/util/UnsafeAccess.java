package com.dt.ez.common.util;

import java.lang.reflect.Field;
import java.nio.ByteOrder;
import java.security.AccessController;
import java.security.PrivilegedAction;

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//import org.apache.hadoop.hbase.classification.InterfaceAudience;
//import org.apache.hadoop.hbase.classification.InterfaceStability;

import sun.misc.Unsafe;

//@InterfaceAudience.Private
//@InterfaceStability.Evolving
//@edu.umd.cs.findbugs.annotations.SuppressWarnings(value="REC_CATCH_EXCEPTION",
//  justification="If exception, presume unaligned")
public final class UnsafeAccess {

//  private static final Log LOG = LogFactory.getLog(UnsafeAccess.class);

  public static final Unsafe theUnsafe;

  /** The offset to the first element in a byte array. */
  public static final int BYTE_ARRAY_BASE_OFFSET;

  static {
    theUnsafe = (Unsafe) AccessController.doPrivileged(new PrivilegedAction<Object>() {
      @Override
      public Object run() {
        try {
          Field f = Unsafe.class.getDeclaredField("theUnsafe");
          f.setAccessible(true);
          return f.get(null);
        } catch (Throwable e) {
          System.out.println ("sun.misc.Unsafe is not accessible" + e);
        }
        return null;
      }
    });

    if(theUnsafe != null){
      BYTE_ARRAY_BASE_OFFSET = theUnsafe.arrayBaseOffset (byte[].class);
    } else{
      BYTE_ARRAY_BASE_OFFSET = -1;
    }
  }

  private UnsafeAccess(){}

  public static final boolean littleEndian = ByteOrder.nativeOrder()
      .equals(ByteOrder.LITTLE_ENDIAN);
}


