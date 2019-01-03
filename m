From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 03 Jan 2019 10:07:59 +0000
Subject: [kvm-unit-tests PATCH v4 06/13] s390x: Move common sclp data and functions to sclp.c
Message-Id: <20190103100806.9039-7-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

sclp.c will provide the common functionality in the future and the
base memory detection as it is quite small.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/sclp-console.c | 20 --------------------
 lib/s390x/sclp.c         | 20 ++++++++++++++++++++
 lib/s390x/sclp.h         |  2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
index deacbde..bc01f41 100644
--- a/lib/s390x/sclp-console.c
+++ b/lib/s390x/sclp-console.c
@@ -13,26 +13,6 @@
 #include <asm/page.h>
 #include "sclp.h"
 
-char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
-
-/* Perform service call. Return 0 on success, non-zero otherwise. */
-int sclp_service_call(unsigned int command, void *sccb)
-{
-        int cc;
-
-        asm volatile(
-                "       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
-                "       ipm     %0\n"
-                "       srl     %0,28"
-                : "=&d" (cc) : "d" (command), "a" (__pa(sccb))
-                : "cc", "memory");
-        if (cc == 3)
-                return -1;
-        if (cc == 2)
-                return -1;
-        return 0;
-}
-
 static void sclp_set_write_mask(void)
 {
 	WriteEventMask *sccb = (void *)_sccb;
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index cccfdc2..7f556e5 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -23,6 +23,8 @@ static uint64_t storage_increment_size;
 static uint64_t max_ram_size;
 static uint64_t ram_size;
 
+char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
+
 static void mem_init(phys_addr_t mem_end)
 {
 	phys_addr_t freemem_start = (phys_addr_t)&stacktop;
@@ -50,6 +52,24 @@ static void sclp_read_scp_info(ReadInfo *ri, int length)
 	report_abort("READ_SCP_INFO failed");
 }
 
+/* Perform service call. Return 0 on success, non-zero otherwise. */
+int sclp_service_call(unsigned int command, void *sccb)
+{
+	int cc;
+
+	asm volatile(
+		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
+		"       ipm     %0\n"
+		"       srl     %0,28"
+		: "=&d" (cc) : "d" (command), "a" (__pa(sccb))
+		: "cc", "memory");
+	if (cc == 3)
+		return -1;
+	if (cc == 2)
+		return -1;
+	return 0;
+}
+
 void sclp_memory_setup(void)
 {
 	ReadInfo *ri = (void *)_sccb;
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 4c60061..583c4e5 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -212,9 +212,9 @@ typedef struct ReadEventData {
     uint32_t mask;
 } __attribute__((packed)) ReadEventData;
 
+extern char _sccb[];
 void sclp_console_setup(void);
 void sclp_print(const char *str);
-extern char _sccb[];
 int sclp_service_call(unsigned int command, void *sccb);
 void sclp_memory_setup(void);
 
-- 
2.14.3
