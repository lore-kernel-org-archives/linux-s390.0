Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15098 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgKQPnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:43:02 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 3/5] s390x: SCLP feature checking
Date: Tue, 17 Nov 2020 10:42:13 -0500
Message-Id: <20201117154215.45855-4-frankja@linux.ibm.com>
In-Reply-To: <20201117154215.45855-1-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

Availability of SIE is announced via a feature bit in a SCLP info CPU
entry. Let's add a framework that allows us to easily check for such
facilities.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/io.c   |  1 +
 lib/s390x/sclp.c | 19 +++++++++++++++++++
 lib/s390x/sclp.h | 15 +++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index e19a1f3..e843601 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -37,6 +37,7 @@ void setup(void)
 	setup_args_progname(ipl_args);
 	setup_facilities();
 	sclp_read_info();
+	sclp_facilities_setup();
 	sclp_console_setup();
 	sclp_memory_setup();
 	smp_setup();
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index ea6324e..599e022 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -11,6 +11,7 @@
  */
 
 #include <libcflat.h>
+#include <bitops.h>
 #include <asm/page.h>
 #include <asm/arch_def.h>
 #include <asm/interrupt.h>
@@ -27,6 +28,7 @@ static uint64_t max_ram_size;
 static uint64_t ram_size;
 char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));
 static ReadInfo *read_info;
+struct sclp_facilities sclp_facilities;
 
 char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
 static volatile bool sclp_busy;
@@ -128,6 +130,23 @@ CPUEntry *sclp_get_cpu_entries(void)
 	return (void *)read_info + read_info->offset_cpu;
 }
 
+void sclp_facilities_setup(void)
+{
+	unsigned short cpu0_addr = stap();
+	CPUEntry *cpu;
+	int i;
+
+	assert(read_info);
+
+	cpu = (void *)read_info + read_info->offset_cpu;
+	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
+		if (cpu->address == cpu0_addr) {
+			sclp_facilities.has_sief2 = test_bit_inv(SCLP_CPU_FEATURE_SIEF2_BIT, (void *)&cpu->address);
+			break;
+		}
+	}
+}
+
 /* Perform service call. Return 0 on success, non-zero otherwise. */
 int sclp_service_call(unsigned int command, void *sccb)
 {
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 6620531..bcc9f4b 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -101,6 +101,20 @@ typedef struct CPUEntry {
     uint8_t reserved1;
 } __attribute__((packed)) CPUEntry;
 
+extern struct sclp_facilities sclp_facilities;
+
+struct sclp_facilities {
+	u64 has_sief2 : 1;
+};
+
+/*
+ * test_bit() uses unsigned long ptrs so we give it the ptr to the
+ * address member and offset bits by 16.
+ */
+enum sclp_cpu_feature_bit {
+	SCLP_CPU_FEATURE_SIEF2_BIT = 16 + 4,
+};
+
 typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
@@ -274,6 +288,7 @@ void sclp_print(const char *str);
 void sclp_read_info(void);
 int sclp_get_cpu_num(void);
 CPUEntry *sclp_get_cpu_entries(void);
+void sclp_facilities_setup(void);
 int sclp_service_call(unsigned int command, void *sccb);
 void sclp_memory_setup(void);
 uint64_t get_ram_size(void);
-- 
2.25.1
