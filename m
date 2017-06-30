From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:41 +0000
Subject: [CRIU][PATCH v3 06/15] s390:zdtm: Enable zdtm for s390
Message-Id: <20170630183150.76021-7-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 test/zdtm/lib/arch/s390/include/asm/atomic.h     | 66 ++++++++++++++++++++++++
 test/zdtm/static/fanotify00.c                    |  3 ++
 test/zdtm/static/mntns-deleted-dst               |  0
 test/zdtm/static/netns-nf.desc                   |  2 +-
 test/zdtm/static/rtc.desc                        |  2 +-
 test/zdtm/static/socket-tcp-closed-last-ack.desc |  4 +-
 6 files changed, 73 insertions(+), 4 deletions(-)
 create mode 100644 test/zdtm/lib/arch/s390/include/asm/atomic.h
 create mode 100644 test/zdtm/static/mntns-deleted-dst

diff --git a/test/zdtm/lib/arch/s390/include/asm/atomic.h b/test/zdtm/lib/arch/s390/include/asm/atomic.h
new file mode 100644
index 0000000..9cf7236
--- /dev/null
+++ b/test/zdtm/lib/arch/s390/include/asm/atomic.h
@@ -0,0 +1,66 @@
+#ifndef __ARCH_S390_ATOMIC__
+#define __ARCH_S390_ATOMIC__
+
+#include <stdint.h>
+
+typedef uint32_t atomic_t;
+
+#define __ATOMIC_OP(op_name, op_type, op_string, op_barrier)		\
+static inline op_type op_name(op_type val, op_type *ptr)		\
+{									\
+	op_type old;							\
+									\
+	asm volatile(							\
+		op_string "	%[old],%[val],%[ptr]\n"			\
+		op_barrier						\
+		: [old] "=d" (old), [ptr] "+Q" (*ptr)			\
+		: [val] "d" (val) : "cc", "memory");			\
+	return old;							\
+}									\
+
+#define __ATOMIC_OPS(op_name, op_type, op_string)			\
+	__ATOMIC_OP(op_name, op_type, op_string, "\n")			\
+	__ATOMIC_OP(op_name##_barrier, op_type, op_string, "bcr 14,0\n")
+
+__ATOMIC_OPS(__atomic_add, uint32_t, "laa")
+
+#undef __ATOMIC_OPS
+#undef __ATOMIC_OP
+
+static inline int atomic_get(const atomic_t *v)
+{
+	int c;
+
+	asm volatile(
+		"	l	%0,%1\n"
+		: "=d" (c) : "Q" (*v));
+	return c;
+}
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	asm volatile(
+		"	st	%1,%0\n"
+		: "=Q" (*v) : "d" (i));
+}
+
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	return __atomic_add_barrier(i, v) + i;
+}
+
+static inline void atomic_add(int i, atomic_t *v)
+{
+	__atomic_add(i, v);
+}
+
+#define atomic_sub(_i, _v)		atomic_add(-(int)(_i), _v)
+
+static inline int atomic_inc(atomic_t *v)
+{
+	return atomic_add_return(1, v) - 1;
+}
+
+#define atomic_dec(_v)			atomic_sub(1, _v)
+
+#endif /* __ARCH_S390_ATOMIC__  */
diff --git a/test/zdtm/static/fanotify00.c b/test/zdtm/static/fanotify00.c
index 9fc3d7a..e948a63 100644
--- a/test/zdtm/static/fanotify00.c
+++ b/test/zdtm/static/fanotify00.c
@@ -25,6 +25,9 @@
 #elif __aarch64__
 # define __NR_fanotify_init     262
 # define __NR_fanotify_mark     263
+#elif __s390x__
+# define __NR_fanotify_init     332
+# define __NR_fanotify_mark     333
 #else
 # define __NR_fanotify_init	338
 # define __NR_fanotify_mark	339
diff --git a/test/zdtm/static/mntns-deleted-dst b/test/zdtm/static/mntns-deleted-dst
new file mode 100644
index 0000000..e69de29
diff --git a/test/zdtm/static/netns-nf.desc b/test/zdtm/static/netns-nf.desc
index 23496bb..618e256 100644
--- a/test/zdtm/static/netns-nf.desc
+++ b/test/zdtm/static/netns-nf.desc
@@ -1,6 +1,6 @@
 {   'deps': [   '/bin/sh',
                 '/sbin/iptables',
-                '/usr/lib64/xtables/libxt_standard.so|/usr/lib/iptables/libxt_standard.so|/lib/xtables/libxt_standard.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_standard.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_standard.so',
+                '/usr/lib64/xtables/libxt_standard.so|/usr/lib/iptables/libxt_standard.so|/lib/xtables/libxt_standard.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_standard.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_standard.so|/usr/lib/s390x-linux-gnu/xtables/libxt_standard.so',
                 '/usr/bin/diff'],
     'flags': 'suid',
     'flavor': 'ns uns'}
diff --git a/test/zdtm/static/rtc.desc b/test/zdtm/static/rtc.desc
index 80094be..2c9c7e5 100644
--- a/test/zdtm/static/rtc.desc
+++ b/test/zdtm/static/rtc.desc
@@ -1 +1 @@
-{'flavor': 'h', 'flags': 'suid crlib'}
+{'flavor': 'h', 'flags': 'suid crlib','arch': 'x86_64 aarch64 arm ppc64'}
diff --git a/test/zdtm/static/socket-tcp-closed-last-ack.desc b/test/zdtm/static/socket-tcp-closed-last-ack.desc
index bc56073..590bc58 100644
--- a/test/zdtm/static/socket-tcp-closed-last-ack.desc
+++ b/test/zdtm/static/socket-tcp-closed-last-ack.desc
@@ -1,7 +1,7 @@
 {   'deps': [   '/bin/sh',
                 '/sbin/iptables',
-                '/usr/lib64/xtables/libxt_tcp.so|/lib/xtables/libxt_tcp.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_tcp.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_tcp.so',
-                '/usr/lib64/xtables/libxt_standard.so|/lib/xtables/libxt_standard.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_standard.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_standard.so',
+                '/usr/lib64/xtables/libxt_tcp.so|/lib/xtables/libxt_tcp.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_tcp.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_tcp.so|/usr/lib/s390x-linux-gnu/xtables/libxt_tcp.so',
+                '/usr/lib64/xtables/libxt_standard.so|/lib/xtables/libxt_standard.so|/usr/lib/powerpc64le-linux-gnu/xtables/libxt_standard.so|/usr/lib/x86_64-linux-gnu/xtables/libxt_standard.so|/usr/lib/s390x-linux-gnu/xtables/libxt_standard.so',
 	],
 	'opts': '--tcp-established',
 	'flags': 'suid nouser samens',
-- 
2.7.4
