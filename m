Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733056AbhALNWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 08:22:02 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 7/9] s390x: Add diag318 intercept test
Date: Tue, 12 Jan 2021 08:20:52 -0500
Message-Id: <20210112132054.49756-8-frankja@linux.ibm.com>
In-Reply-To: <20210112132054.49756-1-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Not much to test except for the privilege and specification
exceptions.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/sclp.c  |  1 +
 lib/s390x/sclp.h  |  6 +++++-
 s390x/intercept.c | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 06819a6..7a9b2c5 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -138,6 +138,7 @@ void sclp_facilities_setup(void)
 	assert(read_info);
 
 	cpu = sclp_get_cpu_entries();
+	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
 		 * The logic for only reading the facilities from the
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 6c86037..58f8e54 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -105,7 +105,8 @@ extern struct sclp_facilities sclp_facilities;
 
 struct sclp_facilities {
 	uint64_t has_sief2 : 1;
-	uint64_t : 63;
+	uint64_t has_diag318 : 1;
+	uint64_t : 62;
 };
 
 typedef struct ReadInfo {
@@ -130,6 +131,9 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t reserved7[134 - 128];
+    uint8_t byte_134_diag318 : 1;
+    uint8_t : 7;
     struct CPUEntry entries[0];
 } __attribute__((packed)) ReadInfo;
 
diff --git a/s390x/intercept.c b/s390x/intercept.c
index cde2f5f..86e57e1 100644
--- a/s390x/intercept.c
+++ b/s390x/intercept.c
@@ -8,6 +8,7 @@
  *  Thomas Huth <thuth@redhat.com>
  */
 #include <libcflat.h>
+#include <sclp.h>
 #include <asm/asm-offsets.h>
 #include <asm/interrupt.h>
 #include <asm/page.h>
@@ -152,6 +153,23 @@ static void test_testblock(void)
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
+static void test_diag318(void)
+{
+	expect_pgm_int();
+	enter_pstate();
+	asm volatile("diag %0,0,0x318\n" : : "d" (0x42));
+	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
+
+	if (!sclp_facilities.has_diag318)
+		expect_pgm_int();
+
+	asm volatile("diag %0,0,0x318\n" : : "d" (0x42));
+
+	if (!sclp_facilities.has_diag318)
+		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+
+}
+
 struct {
 	const char *name;
 	void (*func)(void);
@@ -162,6 +180,7 @@ struct {
 	{ "stap", test_stap, false },
 	{ "stidp", test_stidp, false },
 	{ "testblock", test_testblock, false },
+	{ "diag318", test_diag318, false },
 	{ NULL, NULL, false }
 };
 
-- 
2.25.1
