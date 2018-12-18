From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 09:26:45 +0000
Subject: [kvm-unit-tests PATCH v3 01/13] s390x: Add Sigp order codes
Message-Id: <20181218092657.46466-2-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's get rid of the magic numbers and add some definitions that will
be used in the future.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/arch_def.h | 18 ++++++++++++++++++
 lib/s390x/io.c           |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index d2cd727..d2d6e02 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -10,6 +10,24 @@
 #ifndef _ASM_S390X_ARCH_DEF_H_
 #define _ASM_S390X_ARCH_DEF_H_
 
+/* SIGP order codes */
+#define SIGP_SENSE			1
+#define SIGP_EXTERNAL_CALL		2
+#define SIGP_EMERGENCY_SIGNAL		3
+#define SIGP_START			4
+#define SIGP_STOP			5
+#define SIGP_RESTART			6
+#define SIGP_STOP_AND_STORE_STATUS	9
+#define SIGP_INITIAL_CPU_RESET		11
+#define SIGP_CPU_RESET			12
+#define SIGP_SET_PREFIX			13
+#define SIGP_STORE_STATUS_AT_ADDRESS	14
+#define SIGP_SET_ARCHITECTURE		18
+#define SIGP_COND_EMERGENCY_SIGNAL	19
+#define SIGP_SENSE_RUNNING		21
+#define SIGP_SET_MULTI_THREADING	22
+#define SIGP_STORE_ADDITIONAL_STATUS	23
+
 struct psw {
 	uint64_t	mask;
 	uint64_t	addr;
diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index 7bca637..54ad233 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -14,6 +14,7 @@
 #include <argv.h>
 #include <asm/spinlock.h>
 #include <asm/facility.h>
+#include <asm/arch_def.h>
 #include "sclp.h"
 
 extern char ipl_args[];
@@ -37,7 +38,7 @@ static void sigp_stop(void)
 
 	asm volatile(
 		"	sigp %0,%1,0(%2)\n"
-		: "+d" (status)  : "d" (cpu), "d" (5) : "cc");
+		: "+d" (status)  : "d" (cpu), "d" (SIGP_STOP) : "cc");
 }
 
 void setup(void)
-- 
2.14.3
