From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 13:41:13 +0000
Subject: [CRIU][PATCH 2/3] s390/zdtm: Also support z900 (debian)
Message-Id: <20170714134114.36870-3-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Debian is compiled for z900 - therefore we can't use the "laa"
instruction.

Fix this and replace "laa" by the older "cs" (compare and swap) loop.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 test/zdtm/lib/arch/s390/include/asm/atomic.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/test/zdtm/lib/arch/s390/include/asm/atomic.h b/test/zdtm/lib/arch/s390/include/asm/atomic.h
index 9cf7236..b7c4b2c 100644
--- a/test/zdtm/lib/arch/s390/include/asm/atomic.h
+++ b/test/zdtm/lib/arch/s390/include/asm/atomic.h
@@ -5,24 +5,26 @@
 
 typedef uint32_t atomic_t;
 
-#define __ATOMIC_OP(op_name, op_type, op_string, op_barrier)		\
+#define __ATOMIC_OP(op_name, op_type, op_string)			\
 static inline op_type op_name(op_type val, op_type *ptr)		\
 {									\
-	op_type old;							\
+	op_type old, new;						\
 									\
 	asm volatile(							\
-		op_string "	%[old],%[val],%[ptr]\n"			\
-		op_barrier						\
-		: [old] "=d" (old), [ptr] "+Q" (*ptr)			\
-		: [val] "d" (val) : "cc", "memory");			\
+		"0:	lr	%[new],%[old]\n"			\
+		op_string "	%[new],%[val]\n"			\
+		"	cs	%[old],%[new],%[ptr]\n"			\
+		"	jl	0b"					\
+		: [old] "=d" (old), [new] "=&d" (new), [ptr] "+Q" (*ptr)\
+		: [val] "d" (val), "0" (*ptr) : "cc", "memory");	\
 	return old;							\
-}									\
+}
 
 #define __ATOMIC_OPS(op_name, op_type, op_string)			\
-	__ATOMIC_OP(op_name, op_type, op_string, "\n")			\
-	__ATOMIC_OP(op_name##_barrier, op_type, op_string, "bcr 14,0\n")
+	__ATOMIC_OP(op_name, op_type, op_string)			\
+	__ATOMIC_OP(op_name##_barrier, op_type, op_string)
 
-__ATOMIC_OPS(__atomic_add, uint32_t, "laa")
+__ATOMIC_OPS(__atomic_add, uint32_t, "ar")
 
 #undef __ATOMIC_OPS
 #undef __ATOMIC_OP
-- 
2.7.4
