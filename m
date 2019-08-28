Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbfH1Lga (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 07:36:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SBYpX5037482
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 07:36:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unr929ayt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 07:36:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 28 Aug 2019 12:36:27 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/4] s390x: Move pfmf to lib and make address void
Date: Wed, 28 Aug 2019 13:36:12 +0200
In-Reply-To: <20190828113615.4769-1-frankja@linux.ibm.com>
References: <20190828113615.4769-1-frankja@linux.ibm.com>
Message-Id: <20190828113615.4769-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

It's needed by other tests soon.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/mem.h | 31 ++++++++++++++++++++++++
 s390x/pfmf.c        | 57 +++++++++++----------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/lib/s390x/asm/mem.h b/lib/s390x/asm/mem.h
index 75bd778..9b8fd70 100644
--- a/lib/s390x/asm/mem.h
+++ b/lib/s390x/asm/mem.h
@@ -54,4 +54,35 @@ static inline unsigned char get_storage_key(unsigned long addr)
 	asm volatile("iske %0,%1" : "=d" (skey) : "a" (addr));
 	return skey;
 }
+
+#define PFMF_FSC_4K 0
+#define PFMF_FSC_1M 1
+#define PFMF_FSC_2G 2
+
+union pfmf_r1 {
+	struct {
+		unsigned long pad0 : 32;
+		unsigned long pad1 : 12;
+		unsigned long pad_fmfi : 2;
+		unsigned long sk : 1; /* set key*/
+		unsigned long cf : 1; /* clear frame */
+		unsigned long ui : 1; /* usage indication */
+		unsigned long fsc : 3;
+		unsigned long pad2 : 1;
+		unsigned long mr : 1;
+		unsigned long mc : 1;
+		unsigned long pad3 : 1;
+		unsigned long key : 8; /* storage keys */
+	} reg;
+	unsigned long val;
+};
+
+static inline void *pfmf(unsigned long r1, void *paddr)
+{
+	register void * addr asm("1") = paddr;
+
+	asm volatile(".insn rre,0xb9af0000,%[r1],%[addr]"
+		     : [addr] "+a" (addr) : [r1] "d" (r1) : "memory");
+	return addr;
+}
 #endif
diff --git a/s390x/pfmf.c b/s390x/pfmf.c
index 9bf434a..9986624 100644
--- a/s390x/pfmf.c
+++ b/s390x/pfmf.c
@@ -16,60 +16,29 @@
 #include <asm/facility.h>
 #include <asm/mem.h>
 
-#define FSC_4K 0
-#define FSC_1M 1
-#define FSC_2G 2
-
-union r1 {
-	struct {
-		unsigned long pad0 : 32;
-		unsigned long pad1 : 12;
-		unsigned long pad_fmfi : 2;
-		unsigned long sk : 1; /* set key*/
-		unsigned long cf : 1; /* clear frame */
-		unsigned long ui : 1; /* usage indication */
-		unsigned long fsc : 3;
-		unsigned long pad2 : 1;
-		unsigned long mr : 1;
-		unsigned long mc : 1;
-		unsigned long pad3 : 1;
-		unsigned long key : 8; /* storage keys */
-	} reg;
-	unsigned long val;
-};
-
 static uint8_t pagebuf[PAGE_SIZE * 256] __attribute__((aligned(PAGE_SIZE * 256)));
 
-static inline unsigned long pfmf(unsigned long r1, unsigned long paddr)
-{
-	register uint64_t addr asm("1") = paddr;
-
-	asm volatile(".insn rre,0xb9af0000,%[r1],%[addr]"
-		     : [addr] "+a" (addr) : [r1] "d" (r1) : "memory");
-	return addr;
-}
-
 static void test_priv(void)
 {
 	report_prefix_push("privileged");
 	expect_pgm_int();
 	enter_pstate();
-	pfmf(0, (unsigned long) pagebuf);
+	pfmf(0, pagebuf);
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 }
 
 static void test_4k_key(void)
 {
-	union r1 r1;
+	union pfmf_r1 r1;
 	union skey skey;
 
 	report_prefix_push("4K");
 	r1.val = 0;
 	r1.reg.sk = 1;
-	r1.reg.fsc = FSC_4K;
+	r1.reg.fsc = PFMF_FSC_4K;
 	r1.reg.key = 0x30;
-	pfmf(r1.val, (unsigned long) pagebuf);
+	pfmf(r1.val, pagebuf);
 	skey.val = get_storage_key((unsigned long) pagebuf);
 	skey.val &= SKEY_ACC | SKEY_FP;
 	report("set storage keys", skey.val == 0x30);
@@ -80,15 +49,15 @@ static void test_1m_key(void)
 {
 	int i;
 	bool rp = true;
-	union r1 r1;
+	union pfmf_r1 r1;
 	union skey skey;
 
 	report_prefix_push("1M");
 	r1.val = 0;
 	r1.reg.sk = 1;
-	r1.reg.fsc = FSC_1M;
+	r1.reg.fsc = PFMF_FSC_1M;
 	r1.reg.key = 0x30;
-	pfmf(r1.val, (unsigned long) pagebuf);
+	pfmf(r1.val, pagebuf);
 	for (i = 0; i < 256; i++) {
 		skey.val = get_storage_key((unsigned long) pagebuf + i * PAGE_SIZE);
 		skey.val &= SKEY_ACC | SKEY_FP;
@@ -103,15 +72,15 @@ static void test_1m_key(void)
 
 static void test_4k_clear(void)
 {
-	union r1 r1;
+	union pfmf_r1 r1;
 
 	r1.val = 0;
 	r1.reg.cf = 1;
-	r1.reg.fsc = FSC_4K;
+	r1.reg.fsc = PFMF_FSC_4K;
 
 	report_prefix_push("4K");
 	memset(pagebuf, 42, PAGE_SIZE);
-	pfmf(r1.val, (unsigned long) pagebuf);
+	pfmf(r1.val, pagebuf);
 	report("clear memory", !memcmp(pagebuf, pagebuf + PAGE_SIZE, PAGE_SIZE));
 	report_prefix_pop();
 }
@@ -119,16 +88,16 @@ static void test_4k_clear(void)
 static void test_1m_clear(void)
 {
 	int i;
-	union r1 r1;
+	union pfmf_r1 r1;
 	unsigned long sum = 0;
 
 	r1.val = 0;
 	r1.reg.cf = 1;
-	r1.reg.fsc = FSC_1M;
+	r1.reg.fsc = PFMF_FSC_1M;
 
 	report_prefix_push("1M");
 	memset(pagebuf, 42, PAGE_SIZE * 256);
-	pfmf(r1.val, (unsigned long) pagebuf);
+	pfmf(r1.val, pagebuf);
 	for (i = 0; i < PAGE_SIZE * 256; i++)
 		sum |= pagebuf[i];
 	report("clear memory", !sum);
-- 
2.17.0
