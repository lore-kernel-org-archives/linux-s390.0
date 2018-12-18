From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 09:26:46 +0000
Subject: [kvm-unit-tests PATCH v3 02/13] s390x: Rename and cleanup sclp-ascii.c
Message-Id: <20181218092657.46466-3-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's rename to the more fitting name sclp-console.c and fix some
indentation problems.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/io.c                             |  2 +-
 lib/s390x/{sclp-ascii.c => sclp-console.c} | 38 +++++++++++++++---------------
 lib/s390x/sclp.h                           |  2 +-
 s390x/Makefile                             |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)
 rename lib/s390x/{sclp-ascii.c => sclp-console.c} (54%)

diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index 54ad233..05a0765 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -45,7 +45,7 @@ void setup(void)
 {
 	setup_args_progname(ipl_args);
 	setup_facilities();
-	sclp_ascii_setup();
+	sclp_console_setup();
 	sclp_memory_setup();
 }
 
diff --git a/lib/s390x/sclp-ascii.c b/lib/s390x/sclp-console.c
similarity index 54%
rename from lib/s390x/sclp-ascii.c
rename to lib/s390x/sclp-console.c
index 893ca17..deacbde 100644
--- a/lib/s390x/sclp-ascii.c
+++ b/lib/s390x/sclp-console.c
@@ -35,34 +35,34 @@ int sclp_service_call(unsigned int command, void *sccb)
 
 static void sclp_set_write_mask(void)
 {
-    WriteEventMask *sccb = (void *)_sccb;
+	WriteEventMask *sccb = (void *)_sccb;
 
-    sccb->h.length = sizeof(WriteEventMask);
-    sccb->mask_length = sizeof(unsigned int);
-    sccb->receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->cp_receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->send_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->cp_send_mask = SCLP_EVENT_MASK_MSG_ASCII;
+	sccb->h.length = sizeof(WriteEventMask);
+	sccb->mask_length = sizeof(unsigned int);
+	sccb->receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
+	sccb->cp_receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
+	sccb->send_mask = SCLP_EVENT_MASK_MSG_ASCII;
+	sccb->cp_send_mask = SCLP_EVENT_MASK_MSG_ASCII;
 
-    sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
+	sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
 }
 
-void sclp_ascii_setup(void)
+void sclp_console_setup(void)
 {
-    sclp_set_write_mask();
+	sclp_set_write_mask();
 }
 
 void sclp_print(const char *str)
 {
-    int len = strlen(str);
-    WriteEventData *sccb = (void *)_sccb;
+	int len = strlen(str);
+	WriteEventData *sccb = (void *)_sccb;
 
-    sccb->h.length = sizeof(WriteEventData) + len;
-    sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
-    sccb->ebh.length = sizeof(EventBufferHeader) + len;
-    sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
-    sccb->ebh.flags = 0;
-    memcpy(sccb->data, str, len);
+	sccb->h.length = sizeof(WriteEventData) + len;
+	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
+	sccb->ebh.length = sizeof(EventBufferHeader) + len;
+	sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
+	sccb->ebh.flags = 0;
+	memcpy(sccb->data, str, len);
 
-    sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
+	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 }
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 629e9e2..4c60061 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -212,7 +212,7 @@ typedef struct ReadEventData {
     uint32_t mask;
 } __attribute__((packed)) ReadEventData;
 
-void sclp_ascii_setup(void);
+void sclp_console_setup(void);
 void sclp_print(const char *str);
 extern char _sccb[];
 int sclp_service_call(unsigned int command, void *sccb);
diff --git a/s390x/Makefile b/s390x/Makefile
index 8ba2b92..ede2961 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -38,7 +38,7 @@ cflatobjs += lib/alloc_phys.o
 cflatobjs += lib/s390x/io.o
 cflatobjs += lib/s390x/stack.o
 cflatobjs += lib/s390x/sclp.o
-cflatobjs += lib/s390x/sclp-ascii.o
+cflatobjs += lib/s390x/sclp-console.o
 cflatobjs += lib/s390x/interrupt.o
 cflatobjs += lib/s390x/mmu.o
 
-- 
2.14.3
