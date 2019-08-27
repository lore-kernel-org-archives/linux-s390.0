Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfH0OAI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 10:00:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RDt2Mq087844
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2019 10:00:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2un469wppk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2019 10:00:05 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 27 Aug 2019 14:49:51 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/3] s390x: Storage key library functions now take void ptr addresses
Date: Tue, 27 Aug 2019 15:49:35 +0200
In-Reply-To: <20190827134936.1705-1-frankja@linux.ibm.com>
References: <20190827134936.1705-1-frankja@linux.ibm.com>
Message-Id: <20190827134936.1705-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Now all mem.h functions are consistent in how they take a memory
address. Also we have less casting in the future.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/mem.h |  9 +++------
 s390x/pfmf.c        |  4 ++--
 s390x/skey.c        | 24 +++++++++++-------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/asm/mem.h b/lib/s390x/asm/mem.h
index 9b8fd70..c78bfa2 100644
--- a/lib/s390x/asm/mem.h
+++ b/lib/s390x/asm/mem.h
@@ -26,9 +26,7 @@ union skey {
 	uint8_t val;
 };
 
-static inline void set_storage_key(unsigned long addr,
-				   unsigned char skey,
-				   int nq)
+static inline void set_storage_key(void *addr, unsigned char skey, int nq)
 {
 	if (nq)
 		asm volatile(".insn rrf,0xb22b0000,%0,%1,8,0"
@@ -37,8 +35,7 @@ static inline void set_storage_key(unsigned long addr,
 		asm volatile("sske %0,%1" : : "d" (skey), "a" (addr));
 }
 
-static inline unsigned long set_storage_key_mb(unsigned long addr,
-					       unsigned char skey)
+static inline void *set_storage_key_mb(void *addr, unsigned char skey)
 {
 	assert(test_facility(8));
 
@@ -47,7 +44,7 @@ static inline unsigned long set_storage_key_mb(unsigned long addr,
 	return addr;
 }
 
-static inline unsigned char get_storage_key(unsigned long addr)
+static inline unsigned char get_storage_key(void *addr)
 {
 	unsigned char skey;
 
diff --git a/s390x/pfmf.c b/s390x/pfmf.c
index 0aa5822..2840cf5 100644
--- a/s390x/pfmf.c
+++ b/s390x/pfmf.c
@@ -39,7 +39,7 @@ static void test_4k_key(void)
 	r1.reg.fsc = PFMF_FSC_4K;
 	r1.reg.key = 0x30;
 	pfmf(r1.val, pagebuf);
-	skey.val = get_storage_key((unsigned long) pagebuf);
+	skey.val = get_storage_key(pagebuf);
 	skey.val &= SKEY_ACC | SKEY_FP;
 	report("set storage keys", skey.val == 0x30);
 	report_prefix_pop();
@@ -62,7 +62,7 @@ static void test_1m_key(void)
 	       addr = pfmf(r1.val, addr);
 	}
 	for (i = 0; i < 256; i++) {
-		skey.val = get_storage_key((unsigned long) pagebuf + i * PAGE_SIZE);
+		skey.val = get_storage_key(pagebuf + i * PAGE_SIZE);
 		skey.val &= SKEY_ACC | SKEY_FP;
 		if (skey.val != 0x30) {
 			rp = false;
diff --git a/s390x/skey.c b/s390x/skey.c
index fd4fcc7..efc4eca 100644
--- a/s390x/skey.c
+++ b/s390x/skey.c
@@ -18,14 +18,12 @@
 
 
 static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
-const unsigned long page0 = (unsigned long)pagebuf;
-const unsigned long page1 = (unsigned long)(pagebuf + PAGE_SIZE);
 
 static void test_set_mb(void)
 {
 	union skey skey, ret1, ret2;
-	unsigned long addr = 0x10000 - 2 * PAGE_SIZE;
-	unsigned long end = 0x10000;
+	void *addr = (void *)0x10000 - 2 * PAGE_SIZE;
+	void *end = (void *)0x10000;
 
 	/* Multi block support came with EDAT 1 */
 	if (!test_facility(8))
@@ -46,10 +44,10 @@ static void test_chg(void)
 	union skey skey1, skey2;
 
 	skey1.val = 0x30;
-	set_storage_key(page0, skey1.val, 0);
-	skey1.val = get_storage_key(page0);
+	set_storage_key(pagebuf, skey1.val, 0);
+	skey1.val = get_storage_key(pagebuf);
 	pagebuf[0] = 3;
-	skey2.val = get_storage_key(page0);
+	skey2.val = get_storage_key(pagebuf);
 	report("chg bit test", !skey1.str.ch && skey2.str.ch);
 }
 
@@ -58,9 +56,9 @@ static void test_set(void)
 	union skey skey, ret;
 
 	skey.val = 0x30;
-	ret.val = get_storage_key(page0);
-	set_storage_key(page0, skey.val, 0);
-	ret.val = get_storage_key(page0);
+	ret.val = get_storage_key(pagebuf);
+	set_storage_key(pagebuf, skey.val, 0);
+	ret.val = get_storage_key(pagebuf);
 	/*
 	 * For all set tests we only test the ACC and FP bits. RF and
 	 * CH are set by the machine for memory references and changes
@@ -103,11 +101,11 @@ static void test_priv(void)
 	report_prefix_push("sske");
 	expect_pgm_int();
 	enter_pstate();
-	set_storage_key(page0, 0x30, 0);
+	set_storage_key(pagebuf, 0x30, 0);
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 
-	skey.val = get_storage_key(page0);
+	skey.val = get_storage_key(pagebuf);
 	report("skey did not change on exception", skey.str.acc != 3);
 
 	report_prefix_push("iske");
@@ -117,7 +115,7 @@ static void test_priv(void)
 	} else {
 		expect_pgm_int();
 		enter_pstate();
-		get_storage_key(page0);
+		get_storage_key(pagebuf);
 		check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	}
 	report_prefix_pop();
-- 
2.17.0
