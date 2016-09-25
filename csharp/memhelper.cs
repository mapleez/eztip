/*
 * 编写人： ez
 * 创建日期：2014/9/20
 *
 * 类说明：内存操作助手类，提供字节运算，内存操作等静态方法
 * v1.0  2014/9/20
 * v1.1  2015/3/14
 * v1.2  2015/10/8
 */
 
 namespace lib_ez {
	
	public static class memhelper {

		public static ushort b2toint2 (byte [] __val, bool __tobig = false) {
			return __tobig ? 
				tobig16 (__val) : tolittle16 (__val);
		}

    public static ushort b2toint2 (byte __lo_addr, byte __hi_addr, bool __tobig = false) {
			return __tobig ? 
				tobig16 (__lo_addr, __hi_addr) :
				tolittle16 (__lo_addr, __hi_addr);
      }
		
		// 2 bytes to unsigned short (BE)
		public static ushort tobig16 (params byte [] __val) {
			ushort val = 0;
            val = (ushort) _val[0];     // hi bits
			val <<= 8;
			val |= _val[1];             // lo bits
			return val;
		}

		// 2 bytes to unsigned short (LE)
		public static ushort tolittle16 (params byte [] __val) {
			ushort val = 0;
			val = (ushort) _val[1];     // hi bits
			val <<= 8;
			val |= _val[0];             // lo bits
			return val;
		}

		
		// convert unsigned short to 2 bytes
		public static byte [] int2tob2 (ushort __val, bool __tobig = false) {
			byte [] res = _tobig ? new byte [] {

					(byte) (_val >> 8),      // lo bits
					(byte) (_val & 0x00ff)   // hi bits

				} : new byte [] {

					(byte) (_val & 0x00ff),  // lo bits
					(byte) (_val >> 8)       // hi bits

			};
			return res;
		}
		
		// Is the parameter an even number
		// Return true if it is 
		// Return false if it's an odd number
		public static bool iseven (int _x) {
			return ( (_x & 0x00000001) == 0);
		}
		
		// 2 bytes sub 2 bytes and return 2 bytes
		// do not use this function, its fail
		// changed at 2015/4/3
		public static byte[] b2_sub_b2 (byte[] _val1, byte[] _val2, bool _isbig = false) {
            if (_isbig)
                ushort res = (ushort) (((((ushort) (_val1[0])) << 8) | ((ushort) _val1[1]))
                        - ((((ushort) (_val2[0])) << 8) | (ushort) (_val2[1])));
				return shtob2 (res, _isbig);
            else
                ushort res = (ushort) (((((ushort) (_val1[1])) << 8) | ((ushort) _val1[0]))
                        - ((((ushort) (_val2[1])) << 8) | (ushort) (_val2[0])));
				return shtob2 (res, _isbig);
		}

        // 2 bytes sub 2 bytes and return 2 bytes
        // do not use this function, its fail
		// changed at 2015/4/3
        public static ushort b2_sub_b2(byte[] _val1, byte[] _val2, bool _isbig = false) {
            if (_isbig)
                return (ushort) (((((ushort) (_val1[0])) << 8) | ((ushort) _val1[1]))
                        - ((((ushort) (_val2[0])) << 8) | (ushort) (_val2[1])));
                
            else 
                return (ushort) (((((ushort) (_val1[1])) << 8) | ((ushort) _val1[0])) 
                        - ((((ushort) (_val2[1])) << 8) | (ushort) (_val2[0])));
        }
		
		// public static byte [] get_count (byte [] _addr1, byte [] _addr2, bool _isbig = false) {
			// if (_isbig) {
				// ushort addr1 = _addr1 [0];
				// addr1 <<= 8;
				// addr1 | (ushort) _addr1 [1];
				// ushort addr2 = _addr2 [0];
				// addr2 <<= 8;
				// addr2 | (ushort) _addr2 [1];
				// ushort res = addr1 - addr2;
				// return new byte [] {
					// (ushort) (res & 0xff00),
					// (ushort) (res & 0x00ff)
				// };
			// } else {
				// ushort addr1 = _addr1 [1];
				// addr1 <<= 8;
				// addr1 | (ushort) _addr1 [0];
				// ushort addr2 = _addr2 [1];
				// addr2 <<= 8;
				// addr2 | (ushort) _addr2 [0];
				// ushort res = addr1 - addr2;
				// return new byte [] {
					// (ushort) (res & 0x00ff),
					// (ushort) (res & 0xff00)
				// };
			// }
		// }

        public static bool b2_seq(byte[] _val1, byte[] _val2, byte[] _sub , bool _isbig = false) {
            ushort val1 = 0;
            ushort val2 = 0;
            ushort sub = 0;
            if (_isbig) {
                val1 = _val1[1];
                val1 <<= 8;
                val1 |= _val1[0];

                val2 = _val2[1];
                val2 <<= 8;
                val2 |= _val2[0];

                sub = _sub[1];
                sub <<= 8;
                sub |= _sub[0];

                ushort __sub = val1 > val2 ?
                    (ushort) (val1 - val2) : (ushort) (val2 - val1);
                return (__sub == sub);
            }
            else {
                val1 = _val1[0];
                val1 <<= 8;
                val1 |= _val1[1];

                val2 = _val2[0];
                val2 <<= 8;
                val2 |= _val2[1];

                sub = _sub[0];
                sub <<= 8;
                sub |= _sub[1];

                ushort __sub = val1 > val2 ? 
                    (ushort) (val1 - val2) : (ushort) (val2 - val1);
                return (__sub == sub);
            }
        }

        public static bool b2_seq(byte[] _val1, byte[] _val2, ushort _sub, bool _isbig = false) {
            ushort val1 = 0;
            ushort val2 = 0;
            if (_isbig)
            {
                val1 = _val1[1];
                val1 <<= 8;
                val1 |= _val1[0];

                val2 = _val2[1];
                val2 <<= 8;
                val2 |= _val2[0];

                ushort __sub = val1 > val2 ?
                    (ushort)(val1 - val2) : (ushort)(val2 - val1);
                return (__sub == _sub);
            }
            else
            {
                val1 = _val1[0];
                val1 <<= 8;
                val1 |= _val1[1];

                val2 = _val2[0];
                val2 <<= 8;
                val2 |= _val2[1];

                ushort __sub = val1 > val2 ?
                    (ushort)(val1 - val2) : (ushort)(val2 - val1);
                return (__sub == _sub);
            }
        }

		// 4 bytes integer to 2 bytes array
		public static byte [] int4tob4 (int __val, bool __tobig = false) {
			// if (_val > 0x0000ffff)  // cannot stored this number in two bytes
			// 	return null;
			byte [] res = __tobig ? new byte [] { // big endian

				(byte)  (__val & 0x000000ff),
				(byte) ((__val & 0x0000ff00) >> 8),
				(byte) ((__val & 0x00ff0000) >> 16),
				(byte) ((__val & 0xff000000) >> 24)

			} : new byte [] { // little endian

        (byte) ((__val & 0xff000000) >> 24),
				(byte) ((__val & 0x00ff0000) >> 16),
				(byte) ((__val & 0x0000ff00) >> 8),
				(byte)  (__val & 0x000000ff)

			};
            return res;
		}

		public static byte [] b4toint4 (params byte [] __val, bool __tobig = false) {
			int val = 0;
			if (__tobig) { // big endian

				val |= __val [3];
				val |= ((int) __val [2]) << 8;
				val |= ((int) __val [1]) << 16;
				val |= ((int) __val [0]) << 24;

			} else { // little endian

				val |= __val [0];
				val |= ((int) __val [1]) << 8;
				val |= ((int) __val [2]) << 16;
				val |= ((int) __val [3]) << 24;

			}
			return val;
		}
		
		// 4bytes integer to 3 bytes array
		// public static byte [] int4tob3 (int _val, bool _isbig = false) {
		// 	byte[] __res = _isbig ? new byte[3] {
		// 		(byte) (_val >> 24),
		// 		(byte) ((_val & 0x00ff0000) >> 16),
		// 		(byte) ((_val & 0x0000ff00) >> 8),
		// 		// (byte) (_val & 0x000000ff)
		// 	} : new byte[3] {
		// 		(byte) (_val & 0x000000ff),
		// 		(byte) ((_val & 0x0000ff00) >> 8),
		// 		(byte) ((_val & 0x00ff0000) >> 16)
		// 	};
		// 	return __res;
		// }
		
		
		// public static int ui4tob (int _val, out byte[] _res, bool _isbig = false) {
		// 	byte [] __arr = null;
		// 	if ((_val & 0xff000000) > 0) {
		// 		__arr = _isbig ? new byte [] {
		// 			(byte) ((_val & 0xff000000) >> 24),
		// 			(byte) ((_val & 0x00ff0000) >> 16),
		// 			(byte) ((_val & 0x0000ff00) >> 8),
		// 			(byte)  (_val & 0x000000ff)
		// 		} : new byte [] {
		// 			(byte)  (_val & 0x000000ff),
		// 			(byte) ((_val & 0x0000ff00) >> 8),
		// 			(byte) ((_val & 0x00ff0000) >> 16),
		// 			(byte) ((_val & 0xff000000) >> 24)
		// 		};
        //         _res = __arr;
        //         return 4;
		// 	} else if ((_val & 0x00ff0000) > 0) {
		// 		__arr = _isbig ? new byte [] {
		// 			(byte) ((_val & 0x00ff0000) >> 16),
		// 			(byte) ((_val & 0x0000ff00) >> 8),
		// 			(byte)  (_val & 0x000000ff)
		// 		} : new byte [] {
		// 			(byte)  (_val & 0x000000ff),
		// 			(byte) ((_val & 0x0000ff00) >> 8),
		// 			(byte) ((_val & 0x00ff0000) >> 16)
		// 		};
        //         _res = __arr;
        //         return 3;
		// 	} else if ((_val & 0x0000ff00) > 0) {
		// 		__arr = _isbig ? new byte [] {
		// 			(byte) ((_val & 0x0000ff00) >> 8),
		// 			(byte)  (_val & 0x000000ff)
		// 		} : new byte [] {
		// 			(byte)  (_val & 0x000000ff),
		// 			(byte) ((_val & 0x0000ff00) >> 8)
		// 		};
        //         _res = __arr;
        //         return 2;
		// 	} else {
		// 		__arr = _isbig ? new byte [] {
		// 			(byte)  (_val & 0x000000ff),
		// 			0x00
		// 		} : new byte [] {
		// 			0x00,
		// 			(byte)  (_val & 0x000000ff)
		// 		};
        //         _res = __arr;
        //         return 2;
		// 	}
		// }
		
		/*
			PARAMETERS :
				_isbig : 是否大端字节序
				_arr : 字节序列
		*/
		// public static int b3toint4 (bool _isbig, params byte[] _arr) {
		// 	if (_arr.Length < 3) return 0x7fffffff;
		// 	else {
		// 		if (_isbig) { // big-endian
		// 			int __res = _arr[0];
		// 			__res <<= 16;
		// 			int __tmp = _arr[1];
		// 			__tmp <<= 8;
		// 			__tmp |= _arr[2];
		// 			__res |= __tmp;
		// 			return __res;
		// 		} else {    // little-endian
		// 			int __res = _arr[2];
		// 			__res <<= 16;
		// 			int __tmp = _arr[1];
		// 			__tmp <<= 8;
		// 			__tmp |= _arr[0];
		// 			__res |= __tmp;
		// 			return __res;
		// 		}
		// 	}
		// }
		
		// long 8 bytes to 8 bytes array
		public static byte [] long8tob8 (long _val, bool _isbig = false) {
			byte [] __res = new byte[8];
            long __stamp = 0x000000ff;
            int __bit = 0;
            if (!_isbig) {
                for (int i = 0; i < 8; i ++) {
                    long __tmp = (long) (__stamp & _val);
                    __res [i] = (byte)(__tmp >> __bit);
                    __bit += 8;
                    __stamp <<= 8;
                }
            } else {
                for (int i = 7; i >= 0; i --) {
                    long __tmp = (long) (__stamp & _val);
                    __res [i] = (byte)(__tmp >> __bit);
                    __bit += 8;
                    __stamp <<= 8;
                }
            }
            return __res;
		}
		
		// is the local machine cpu big ending
		public static bool is_big_ending () {
			ushort __tmp = 0x0001;
			bool __res = ((__tmp & 0x00ff) == 0x0000 ? 
								false : true);
			return __res;
		}
		
		/*
			AUTHOR: YEZ
			DATE : 2014/11/12
			DESCRIBE : CALC crc16 value with message block
		*/
		public static void crc16 (byte [] _msg, ref byte [] _crc) {
            ushort CRCFull = 0xFFFF;
            byte CRCHigh = 0xFF, CRCLow = 0xFF;
            char CRCLSB;

            for (int i = 0; i < (_msg.Length) - 2; i++) {
                CRCFull = (ushort) (CRCFull ^ _msg[i]);

                for (int j = 0; j < 8; j++) {
                    CRCLSB = (char) (CRCFull & 0x0001);
                    CRCFull = (ushort) ( (CRCFull >> 1) & 0x7FFF);
                    if (CRCLSB == 1)
                        CRCFull = (ushort) (CRCFull ^ 0xA001);
                }
            }
            _crc[1] = CRCHigh = (byte) ( (CRCFull >> 8) & 0xFF);
            _crc[0] = CRCLow = (byte) (CRCFull & 0xFF);
        }
		
		/*
			AUTHOR: YEZ
			DATE : 2014/11/12
			DESCRIBE : CALC crc16 value with message block
		*/
		public static uint crc16 (byte[] _msg) {
            uint crc = 0xffff;
            int len = _msg.Length;
            int index = 0;
            while (len-- > 0) {
                crc ^= _msg[index++];
                for (int i = 0; i < 8; i++) {
                    if ((crc & 0x0001) > 0) {
                        crc = (crc >> 1) ^ 0xa001;
                    }
                    else
                        crc = crc >> 1;
                }
            }
            return crc;
        }
		
		public static ushort crc16_quick_u (byte[] _msg) {
			byte crchi = 0xff;
			byte crclo = 0xff;
			byte index;
			int circle = _msg.Length;
			int i = 0;
			while ((circle --) != 0) {
                index = (byte) (crchi ^ _msg[i++]);
				crchi = (byte) (crclo ^ auch_crc_hi [index]);
				crclo = (byte) (auch_crc_lo [index]);
			}
			return (ushort) ((crchi << 8) | crclo);
		}
		

		public static byte[] crc16_quick (byte[] _msg) {
			byte[] crc = new byte [] {0xff, 0xff};
			byte crchi = 0xff;
			int circle = _msg.Length;
			int i = 0;
            byte index;
			while ((circle --) != 0) {
				index = (byte) (crc [0] ^ _msg [i ++]);
				crc [0] = (byte) (crc [1] ^ auch_crc_hi [index]);
				crc [1] = (byte) (auch_crc_lo [index]);
			}
			return crc;
			
		}
		
		private static byte[] auch_crc_hi = new byte [] {
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,
			0x00,0xC1,0x81,0x40,0x00,0xC1,0x81,0x40,0x01,0xC0,
			0x80,0x41,0x01,0xC0,0x80,0x41,0x00,0xC1,0x81,0x40,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x00,0xC1,
			0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,0x80,0x41,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x00,0xC1,
			0x81,0x40,0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x00,0xC1,0x81,0x40,
			0x01,0xC0,0x80,0x41,0x01,0xC0,0x80,0x41,0x00,0xC1,
			0x81,0x40,0x01,0xC0,0x80,0x41,0x00,0xC1,0x81,0x40,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x00,0xC1,0x81,0x40,
			0x01,0xC0,0x80,0x41,0x00,0xC1,0x81,0x40,0x01,0xC0,
			0x80,0x41,0x01,0xC0,0x80,0x41,0x00,0xC1,0x81,0x40,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,
			0x00,0xC1,0x81,0x40,0x00,0xC1,0x81,0x40,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,
			0x01,0xC0,0x80,0x41,0x00,0xC1,0x81,0x40,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40,0x00,0xC1,0x81,0x40,
			0x01,0xC0,0x80,0x41,0x01,0xC0,0x80,0x41,0x00,0xC1,
			0x81,0x40,0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,
			0x00,0xC1,0x81,0x40,0x01,0xC0,0x80,0x41,0x01,0xC0,
			0x80,0x41,0x00,0xC1,0x81,0x40
		};
		
		private static byte[] auch_crc_lo = new byte[] {
			0x00,0xC0,0xC1,0x01,0xC3,0x03,0x02,0xC2,0xC6,0x06,
			0x07,0xC7,0x05,0xC5,0xC4,0x04,0xCC,0x0C,0x0D,0xCD,
			0x0F,0xCF,0xCE,0x0E,0x0A,0xCA,0xCB,0x0B,0xC9,0x09,
			0x08,0xC8,0xD8,0x18,0x19,0xD9,0x1B,0xDB,0xDA,0x1A,
			0x1E,0xDE,0xDF,0x1F,0xDD,0x1D,0x1C,0xDC,0x14,0xD4,
			0xD5,0x15,0xD7,0x17,0x16,0xD6,0xD2,0x12,0x13,0xD3,
			0x11,0xD1,0xD0,0x10,0xF0,0x30,0x31,0xF1,0x33,0xF3,
			0xF2,0x32,0x36,0xF6,0xF7,0x37,0xF5,0x35,0x34,0xF4,
			0x3C,0xFC,0xFD,0x3D,0xFF,0x3F,0x3E,0xFE,0xFA,0x3A,
			0x3B,0xFB,0x39,0xF9,0xF8,0x38,0x28,0xE8,0xE9,0x29,
			0xEB,0x2B,0x2A,0xEA,0xEE,0x2E,0x2F,0xEF,0x2D,0xED,
			0xEC,0x2C,0xE4,0x24,0x25,0xE5,0x27,0xE7,0xE6,0x26,
			0x22,0xE2,0xE3,0x23,0xE1,0x21,0x20,0xE0,0xA0,0x60,
			0x61,0xA1,0x63,0xA3,0xA2,0x62,0x66,0xA6,0xA7,0x67,
			0xA5,0x65,0x64,0xA4,0x6C,0xAC,0xAD,0x6D,0xAF,0x6F,
			0x6E,0xAE,0xAA,0x6A,0x6B,0xAB,0x69,0xA9,0xA8,0x68,
			0x78,0xB8,0xB9,0x79,0xBB,0x7B,0x7A,0xBA,0xBE,0x7E,
			0x7F,0xBF,0x7D,0xBD,0xBC,0x7C,0xB4,0x74,0x75,0xB5,
			0x77,0xB7,0xB6,0x76,0x72,0xB2,0xB3,0x73,0xB1,0x71,
			0x70,0xB0,0x50,0x90,0x91,0x51,0x93,0x53,0x52,0x92,
			0x96,0x56,0x57,0x97,0x55,0x95,0x94,0x54,0x9C,0x5C,
			0x5D,0x9D,0x5F,0x9F,0x9E,0x5E,0x5A,0x9A,0x9B,0x5B,
			0x99,0x59,0x58,0x98,0x88,0x48,0x49,0x89,0x4B,0x8B,
			0x8A,0x4A,0x4E,0x8E,0x8F,0x4F,0x8D,0x4D,0x4C,0x8C,
			0x44,0x84,0x85,0x45,0x87,0x47,0x46,0x86,0x82,0x42,
			0x43,0x83,0x41,0x81,0x80,0x40	
			
		};
		
	}
 }
