From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 09:26:56 +0000
Subject: [kvm-unit-tests RFC v3 12/13] s390x: Add time functions to lib
Message-Id: <20181218092657.46466-13-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Always good to know what time it is.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/time.c |  18 ++++++++++
 lib/s390x/time.h | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 s390x/Makefile   |   1 +
 3 files changed, 123 insertions(+)
 create mode 100644 lib/s390x/time.c
 create mode 100644 lib/s390x/time.h

diff --git a/lib/s390x/time.c b/lib/s390x/time.c
new file mode 100644
index 0000000..e0fbcfc
--- /dev/null
+++ b/lib/s390x/time.c
@@ -0,0 +1,18 @@
+#include <libcflat.h>
+#include "time.h"
+
+uint64_t time_get_ns(void)
+{
+	unsigned long long tod;
+
+	tod = stckf();
+	return tod_to_ns(tod);
+}
+
+uint64_t time_get_s(void)
+{
+	uint64_t ns;
+
+	ns = time_get_ns();
+	return ns / 1000000UL;
+}
diff --git a/lib/s390x/time.h b/lib/s390x/time.h
new file mode 100644
index 0000000..26060bd
--- /dev/null
+++ b/lib/s390x/time.h
@@ -0,0 +1,104 @@
+/*
+ * Time related definitions.
+ *
+ * Mostly copied from arch/s390/include/asm/timex.h from the Linux
+ * kernel git.
+ *
+ * Copyright IBM Corp. 1999
+ *
+ * Derived from "include/asm-i386/timex.h"
+ * Copyright (C) 1992, Linus Torvalds
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+
+#ifndef TIME_H
+#define TIME_H
+
+static inline void set_clock_comparator(uint64_t time)
+{
+	asm volatile("sckc %0" : : "Q" (time));
+}
+
+static inline void store_clock_comparator(uint64_t *time)
+{
+	asm volatile("stckc %0" : "=Q" (*time));
+}
+
+static inline int set_tod_clock(uint64_t time)
+{
+	int cc;
+
+	asm volatile(
+		"   sck   %1\n"
+		"   ipm   %0\n"
+		"   srl   %0,28\n"
+		: "=d" (cc) : "Q" (time) : "cc");
+	return cc;
+}
+
+static inline unsigned long long stck(void)
+{
+	unsigned long long tod;
+
+	asm volatile(
+		"	stck	%[tod]\n"
+		: [tod] "=Q" (tod) : : "cc"
+		);
+	return tod;
+}
+
+static inline unsigned long long stckf(void)
+{
+	unsigned long long tod;
+
+	asm volatile(
+		"	.machine push\n"
+		"	.machine \"z9-109\"\n"
+		"	stckf	%[tod]\n"
+		"	.machine pop\n"
+		: [tod] "=Q" (tod)
+		: : "cc");
+	return tod;
+}
+
+static inline unsigned long long stcke(void)
+{
+	unsigned long long tod;
+
+	asm volatile(
+		"	stcke	%[tod]\n"
+		: [tod] "=Q" (tod)
+		: : "cc");
+	return tod;
+}
+
+
+/**
+ * tod_to_ns - convert a TOD format value to nanoseconds
+ * @todval: to be converted TOD format value
+ * Returns: number of nanoseconds that correspond to the TOD format value
+ *
+ * Converting a 64 Bit TOD format value to nanoseconds means that the value
+ * must be divided by 4.096. In order to achieve that we multiply with 125
+ * and divide by 512:
+ *
+ *    ns = (todval * 125) >> 9;
+ *
+ * In order to avoid an overflow with the multiplication we can rewrite this.
+ * With a split todval == 2^9 * th + tl (th upper 55 bits, tl lower 9 bits)
+ * we end up with
+ *
+ *    ns = ((2^9 * th + tl) * 125 ) >> 9;
+ * -> ns = (th * 125) + ((tl * 125) >> 9);
+ *
+ */
+static inline unsigned long long tod_to_ns(unsigned long long todval)
+{
+	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
+}
+
+
+uint64_t time_get_ns(void);
+uint64_t time_get_s(void);
+#endif
diff --git a/s390x/Makefile b/s390x/Makefile
index eaad18c..f41d5be 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -43,6 +43,7 @@ cflatobjs += lib/s390x/sclp.o
 cflatobjs += lib/s390x/sclp-console.o
 cflatobjs += lib/s390x/interrupt.o
 cflatobjs += lib/s390x/mmu.o
+cflatobjs += lib/s390x/time.o
 
 OBJDIRS += lib/s390x
 
-- 
2.14.3
