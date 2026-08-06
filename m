Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD827BF93
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029231; cv=none; b=iDUphe2hgOULIQTEOcsOtGx51pXGu56UcqfdHdMmpLMmmFniNffb+vo4Xv1sUypHmpQBn3DGCXhalipb5jeNic5PvflbP6pCZK9/1TbCDIQtwACcWqfQrzGLBUFFkDcpZ1NebofpFg9uewYTUclus+iyvDj9t9fsiNbbEH9f9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029231; c=relaxed/simple;
	bh=VHXw5kYnFUWRZwkbrYPxjTDiRVXJZTtaOQHvhuQAauY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxCol2Xy1peiMtNAgTv018FsebvZJL+RJv4oh2hXJxrncPHt7ohyBpvpvMMeo5pUKGzWA4vNm7imo21EjMKhVzcCqd2L5Yx2h625Q1LAxGGu3iN8OedNh0M/mN+MkqlSGJPIyjRoDPS88XOel4VdIOb3vNwMUl+zn/AqkY+1kE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qOKV6tW+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qOKV6tW+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnwjD3014104;
	Thu, 6 Aug 2026 15:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b4pFwHt9GZU3g+SK5
	1dtHW8/gZHGGGYv64zDUS1DO/0=; b=qOKV6tW+L4Vg16ukp6BUA2KrS6Atap1xj
	ynIZ7j0q+MtjltckBCaG4XJD7mvr9gabSFs2KFjrwrOdVISCEOX22VXeXSoG47Cl
	yN0LB00qnZHGGYoTIupGtb+AnCcIATrVJZPtFDQag7aclT8jGtnLn9INdVhI/XaO
	KGR9wVCPlVbkAPc4zLZedxBAop98gWO4z0RM9795eLGgRnLGBTXPrOt8fWrMGz6/
	0BLXRBngAnPbZ2gZZtYHYnnTwwyvNOxo4JAo0LmE41FNKdCcBilUYuTee0OUi1wm
	NDZl9ND0UPSlGdV9Ljhxh6HGHrlGIsJVksmXLjvSxOKs5NZAeRXMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev0938-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:13:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBGQA030813;
	Thu, 6 Aug 2026 15:13:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qutjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:13:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FD8BG26608284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:13:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 417D620040;
	Thu,  6 Aug 2026 15:13:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F50120043;
	Thu,  6 Aug 2026 15:13:07 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:13:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v14 19/19] tests/tcg/s390x: Add tests for CPACF instructions
Date: Thu,  6 Aug 2026 17:13:01 +0200
Message-ID: <20260806151302.26846-20-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806151302.26846-1-freude@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NovRoLpk9r0_CooJJUkwzslWySmKv2Zy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX4+ZOu19Gattz
 N1FW4JFT7PkbP4OhkUDVypm93ua/5jAkXYvEawKUSp4QqqI6AVN4JtGTy2sKJIktd10UH/XZcMR
 zfx0dOXTxEXdkz94Ago7LKWjmJRkGBk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX6gdI7xvS1WSO
 TPjNbCufrk99hz5Aq2nEXXHe4QIu5ux+yvmnA2IKKRwGTUTd4AfBZql94dJNiH4TDU43XSUqRAy
 5FoG2kRD1+kCGv6Pbl7r/zjjOxgFAsbPVEMhW8MBi3lOTXuthUzvj9X950v0by0h0T4s/WPnAwJ
 wV1ganM8QQV3DgMEs5bCi1693hpD0vBF7rkh12weaTd7D1nWkuUCBa9lwiwr3UKpGImIQjqkrYh
 cH/qSfHBrA2o+IkwOhg6lp/aQnyz1Sx1+m/lnuosVEc/PUdhzw0CeVAQOi3fnrwLKyXza/PGtFZ
 6j+SWqrshRb+qgBTkBSbR6EsDCczaUzeEGCxWif+hCZiD0/rKdVfqmAuHO1CZ+oJ9cFkV7vDY+E
 DDTUPhbpnJTqIBxGMFCkSHylVB1cQLx0GiBSvmDIXtoDC8xuU6Gc/sHmNadQ+hMdD5EZF5At98h
 w4+dprbwMrh1wxRx6bw==
X-Proofpoint-GUID: NovRoLpk9r0_CooJJUkwzslWySmKv2Zy
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74a48a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=eyG1h_TRBkkYXk9k3fkA:9
 a=9gp5PUktWgSiYFtD:21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115

Add simple tests for the CPACF instructions implemented:
- kdsa - minimal as only query is implemented
- kimd - query, sha256, sha512
- klmd - query, sha256, sha512
- km - query, aes 128, 192, 256 with clear and prot key
- kmac - minimal as only query is implemented
- kmc - query, aes 128, 192, 256 with clear and prot key
- kmctr - query, aes 128, 192, 256 with clear and prot key
- pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
- pckmo - run query and check for SIGILL
- prno - query, trng
No test for kma, kmf, kmo as these instructions are currently
not implemented at all.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h        |   7 +
 tests/tcg/s390x/Makefile.target |  10 +
 tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
 tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
 tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
 tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
 tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
 tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
 tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
 tests/tcg/s390x/cpacf-pckmo.c   |  45 +++
 tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
 tests/tcg/s390x/cpacf.h         | 571 +++++++++++++++++++++++++++++++
 13 files changed, 2798 insertions(+)
 create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
 create mode 100644 tests/tcg/s390x/cpacf-kimd.c
 create mode 100644 tests/tcg/s390x/cpacf-klmd.c
 create mode 100644 tests/tcg/s390x/cpacf-km.c
 create mode 100644 tests/tcg/s390x/cpacf-kmac.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
 create mode 100644 tests/tcg/s390x/cpacf-pcc.c
 create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
 create mode 100644 tests/tcg/s390x/cpacf-prno.c
 create mode 100644 tests/tcg/s390x/cpacf.h

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index dc29834cf8..2f0cabc85a 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -223,6 +223,8 @@
 #define CPACF_KDSA_PSIGN_ED25519   48
 #define CPACF_KDSA_PSIGN_ED448     52
 
+#ifndef CPACF_H_INCLUDE_FOR_TESTS
+
 /* from cpacf_sha256.c */
 int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                  uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
@@ -254,6 +256,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
 
+#endif /* CPACF_H_INCLUDE_FOR_TESTS */
+
 /*
  * Support for protected key cpacf functions. Note that this is
  * a fake implementation intended for debugging and development.
@@ -279,6 +283,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E }
 
+#ifndef CPACF_H_INCLUDE_FOR_TESTS
+
 /* from cpacf_aes.c */
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc);
@@ -302,4 +308,5 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
 
+#endif /* CPACF_H_INCLUDE_FOR_TESTS */
 #endif /* S390X_CPACF_H */
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded0..e2f1ca8a68 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -50,6 +50,16 @@ TESTS+=cvb
 TESTS+=ts
 TESTS+=ex-smc
 TESTS+=divide-to-integer
+TESTS+=cpacf-kdsa
+TESTS+=cpacf-kimd
+TESTS+=cpacf-klmd
+TESTS+=cpacf-km
+TESTS+=cpacf-kmac
+TESTS+=cpacf-kmc
+TESTS+=cpacf-kmctr
+TESTS+=cpacf-pcc
+TESTS+=cpacf-pckmo
+TESTS+=cpacf-prno
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/cpacf-kdsa.c b/tests/tcg/s390x/cpacf-kdsa.c
new file mode 100644
index 0000000000..cc06e60f11
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kdsa.c
@@ -0,0 +1,58 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for the CPACF KDSA instruction
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected kdsa query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static int test_kdsa_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_kdsa(CPACF_KDSA_QUERY, query_block, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc;
+
+    /* Test query function */
+    rc = test_kdsa_query();
+
+    /* As of now only KDSA query is implemented */
+
+    if (rc) {
+        printf("cpacf-kdsa: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kimd.c b/tests/tcg/s390x/cpacf-kimd.c
new file mode 100644
index 0000000000..61c5268ccb
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kimd.c
@@ -0,0 +1,166 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF KIMD instruction
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected kimd query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* SHA-256 test data */
+static const uint8_t sha256in[] = {
+    0x5a, 0x86, 0xb7, 0x37, 0xea, 0xea, 0x8e, 0xe9,
+    0x76, 0xa0, 0xa2, 0x4d, 0xa6, 0x3e, 0x7e, 0xd7,
+    0xee, 0xfa, 0xd1, 0x8a, 0x10, 0x1c, 0x12, 0x11,
+    0xe2, 0xb3, 0x65, 0x0c, 0x51, 0x87, 0xc2, 0xa8,
+    0xa6, 0x50, 0x54, 0x72, 0x08, 0x25, 0x1f, 0x6d,
+    0x42, 0x37, 0xe6, 0x61, 0xc7, 0xbf, 0x4c, 0x77,
+    0xf3, 0x35, 0x39, 0x03, 0x94, 0xc3, 0x7f, 0xa1,
+    0xa9, 0xf9, 0xbe, 0x83, 0x6a, 0xc2, 0x85, 0x09
+};
+
+/* SHA-512 test data */
+static const uint8_t sha512in[] = {
+    0xfd, 0x22, 0x03, 0xe4, 0x67, 0x57, 0x4e, 0x83,
+    0x4a, 0xb0, 0x7c, 0x90, 0x97, 0xae, 0x16, 0x45,
+    0x32, 0xf2, 0x4b, 0xe1, 0xeb, 0x5d, 0x88, 0xf1,
+    0xaf, 0x77, 0x48, 0xce, 0xff, 0x0d, 0x2c, 0x67,
+    0xa2, 0x1f, 0x4e, 0x40, 0x97, 0xf9, 0xd3, 0xbb,
+    0x4e, 0x9f, 0xbf, 0x97, 0x18, 0x6e, 0x0d, 0xb6,
+    0xdb, 0x01, 0x00, 0x23, 0x0a, 0x52, 0xb4, 0x53,
+    0xd4, 0x21, 0xf8, 0xab, 0x9c, 0x9a, 0x60, 0x43,
+    0xaa, 0x32, 0x95, 0xea, 0x20, 0xd2, 0xf0, 0x6a,
+    0x2f, 0x37, 0x47, 0x0d, 0x8a, 0x99, 0x07, 0x5f,
+    0x1b, 0x8a, 0x83, 0x36, 0xf6, 0x22, 0x8c, 0xf0,
+    0x8b, 0x59, 0x42, 0xfc, 0x1f, 0xb4, 0x29, 0x9c,
+    0x7d, 0x24, 0x80, 0xe8, 0xe8, 0x2b, 0xce, 0x17,
+    0x55, 0x40, 0xbd, 0xfa, 0xd7, 0x75, 0x2b, 0xc9,
+    0x5b, 0x57, 0x7f, 0x22, 0x95, 0x15, 0x39, 0x4f,
+    0x3a, 0xe5, 0xce, 0xc8, 0x70, 0xa4, 0xb2, 0xf8
+};
+
+/*
+ * Query test for kimd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kimd_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_kimd(CPACF_KIMD_QUERY, query_block, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KIMD_SHA_256 test for kimd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kimd_sha256(void)
+{
+    uint32_t param[8];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Initialize SHA-256 hash values */
+    param[0] = 0x6a09e667u;
+    param[1] = 0xbb67ae85u;
+    param[2] = 0x3c6ef372u;
+    param[3] = 0xa54ff53au;
+    param[4] = 0x510e527fu;
+    param[5] = 0x9b05688cu;
+    param[6] = 0x1f83d9abu;
+    param[7] = 0x5be0cd19u;
+
+    /* Process input data */
+    cpacf_kimd(CPACF_KIMD_SHA_256, param, sha256in, sizeof(sha256in), &cc);
+
+    /* No check of the result in param block as this is an intermediate value */
+
+    /* Check for correct condition code (should be 0 on success) */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KIMD_SHA_512 test for kimd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kimd_sha512(void)
+{
+    uint64_t param[8];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Initialize SHA-512 hash values */
+    param[0] = 0x6a09e667f3bcc908lu;
+    param[1] = 0xbb67ae8584caa73blu;
+    param[2] = 0x3c6ef372fe94f82blu;
+    param[3] = 0xa54ff53a5f1d36f1lu;
+    param[4] = 0x510e527fade682d1lu;
+    param[5] = 0x9b05688c2b3e6c1flu;
+    param[6] = 0x1f83d9abfb41bd6blu;
+    param[7] = 0x5be0cd19137e2179lu;
+
+    /* Process input data */
+    cpacf_kimd(CPACF_KIMD_SHA_512, param, sha512in, sizeof(sha512in), &cc);
+
+    /* No check of the result in param block as this is an intermediate value */
+
+    /* Check for correct condition code (should be 0 on success) */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_kimd_query();
+
+    /* Test SHA-256 */
+    rc += test_kimd_sha256();
+
+    /* Test SHA-512 */
+    rc += test_kimd_sha512();
+
+    if (rc) {
+        printf("cpacf-kimd: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-klmd.c b/tests/tcg/s390x/cpacf-klmd.c
new file mode 100644
index 0000000000..1761bb64f9
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-klmd.c
@@ -0,0 +1,206 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF KLMD instruction
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected klmd query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* SHA-256 test data */
+static const uint8_t sha256in[] = {
+    0x5a, 0x86, 0xb7, 0x37, 0xea, 0xea, 0x8e, 0xe9,
+    0x76, 0xa0, 0xa2, 0x4d, 0xa6, 0x3e, 0x7e, 0xd7,
+    0xee, 0xfa, 0xd1, 0x8a, 0x10, 0x1c, 0x12, 0x11,
+    0xe2, 0xb3, 0x65, 0x0c, 0x51, 0x87, 0xc2, 0xa8,
+    0xa6, 0x50, 0x54, 0x72, 0x08, 0x25, 0x1f, 0x6d,
+    0x42, 0x37, 0xe6, 0x61, 0xc7, 0xbf, 0x4c, 0x77,
+    0xf3, 0x35, 0x39, 0x03, 0x94, 0xc3, 0x7f, 0xa1,
+    0xa9, 0xf9, 0xbe, 0x83, 0x6a, 0xc2, 0x85, 0x09
+};
+
+static const uint8_t sha256md[] = {
+    0x42, 0xe6, 0x1e, 0x17, 0x4f, 0xbb, 0x38, 0x97,
+    0xd6, 0xdd, 0x6c, 0xef, 0x3d, 0xd2, 0x80, 0x2f,
+    0xe6, 0x7b, 0x33, 0x19, 0x53, 0xb0, 0x61, 0x14,
+    0xa6, 0x5c, 0x77, 0x28, 0x59, 0xdf, 0xc1, 0xaa
+};
+
+/* SHA-512 test data */
+static const uint8_t sha512in[] = {
+    0xfd, 0x22, 0x03, 0xe4, 0x67, 0x57, 0x4e, 0x83,
+    0x4a, 0xb0, 0x7c, 0x90, 0x97, 0xae, 0x16, 0x45,
+    0x32, 0xf2, 0x4b, 0xe1, 0xeb, 0x5d, 0x88, 0xf1,
+    0xaf, 0x77, 0x48, 0xce, 0xff, 0x0d, 0x2c, 0x67,
+    0xa2, 0x1f, 0x4e, 0x40, 0x97, 0xf9, 0xd3, 0xbb,
+    0x4e, 0x9f, 0xbf, 0x97, 0x18, 0x6e, 0x0d, 0xb6,
+    0xdb, 0x01, 0x00, 0x23, 0x0a, 0x52, 0xb4, 0x53,
+    0xd4, 0x21, 0xf8, 0xab, 0x9c, 0x9a, 0x60, 0x43,
+    0xaa, 0x32, 0x95, 0xea, 0x20, 0xd2, 0xf0, 0x6a,
+    0x2f, 0x37, 0x47, 0x0d, 0x8a, 0x99, 0x07, 0x5f,
+    0x1b, 0x8a, 0x83, 0x36, 0xf6, 0x22, 0x8c, 0xf0,
+    0x8b, 0x59, 0x42, 0xfc, 0x1f, 0xb4, 0x29, 0x9c,
+    0x7d, 0x24, 0x80, 0xe8, 0xe8, 0x2b, 0xce, 0x17,
+    0x55, 0x40, 0xbd, 0xfa, 0xd7, 0x75, 0x2b, 0xc9,
+    0x5b, 0x57, 0x7f, 0x22, 0x95, 0x15, 0x39, 0x4f,
+    0x3a, 0xe5, 0xce, 0xc8, 0x70, 0xa4, 0xb2, 0xf8
+};
+
+static const uint8_t sha512md[] = {
+    0xa2, 0x1b, 0x10, 0x77, 0xd5, 0x2b, 0x27, 0xac,
+    0x54, 0x5a, 0xf6, 0x3b, 0x32, 0x74, 0x6c, 0x6e,
+    0x3c, 0x51, 0xcb, 0x0c, 0xb9, 0xf2, 0x81, 0xeb,
+    0x9f, 0x35, 0x80, 0xa6, 0xd4, 0x99, 0x6d, 0x5c,
+    0x99, 0x17, 0xd2, 0xa6, 0xe4, 0x84, 0x62, 0x7a,
+    0x9d, 0x5a, 0x06, 0xfa, 0x1b, 0x25, 0x32, 0x7a,
+    0x9d, 0x71, 0x0e, 0x02, 0x73, 0x87, 0xfc, 0x3e,
+    0x07, 0xd7, 0xc4, 0xd1, 0x4c, 0x60, 0x86, 0xcc
+};
+
+/*
+ * Query test for klmd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_klmd_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_klmd(CPACF_KLMD_QUERY, query_block, NULL, 0, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KLMD_SHA_256 test for klmd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_klmd_sha256(void)
+{
+    uint8_t param[40]; /* 32 bytes hash + 8 bytes message bit length */
+    uint32_t *hash = (uint32_t *)param;
+    uint64_t *mbl = (uint64_t *)(param + 32);
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Initialize SHA-256 hash values (H0-H7) */
+    hash[0] = 0x6a09e667u;
+    hash[1] = 0xbb67ae85u;
+    hash[2] = 0x3c6ef372u;
+    hash[3] = 0xa54ff53au;
+    hash[4] = 0x510e527fu;
+    hash[5] = 0x9b05688cu;
+    hash[6] = 0x1f83d9abu;
+    hash[7] = 0x5be0cd19u;
+
+    /* Set message bit length for KLMD */
+    *mbl = sizeof(sha256in) * 8;
+
+    /* Process input data with KLMD (finalize hash) */
+    cpacf_klmd(CPACF_KLMD_SHA_256, param, sha256in,
+               sizeof(sha256in), NULL, 0, &cc);
+
+    /* Check for correct condition code (should be 0 on success) */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare hash result in param with expected message digest */
+    if (memcmp(param, sha256md, sizeof(sha256md))) {
+        printf("%s failed: hash mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KLMD_SHA_512 test for klmd
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_klmd_sha512(void)
+{
+    uint8_t param[80]; /* 64 bytes hash + 16 bytes message bit length */
+    uint64_t *hash = (uint64_t *)param;
+    uint64_t *mbl_high = (uint64_t *)(param + 64);
+    uint64_t *mbl_low = (uint64_t *)(param + 72);
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Initialize SHA-512 hash values (H0-H7) */
+    hash[0] = 0x6a09e667f3bcc908lu;
+    hash[1] = 0xbb67ae8584caa73blu;
+    hash[2] = 0x3c6ef372fe94f82blu;
+    hash[3] = 0xa54ff53a5f1d36f1lu;
+    hash[4] = 0x510e527fade682d1lu;
+    hash[5] = 0x9b05688c2b3e6c1flu;
+    hash[6] = 0x1f83d9abfb41bd6blu;
+    hash[7] = 0x5be0cd19137e2179lu;
+
+    /* Set message bit length for KLMD (128-bit, high and low) */
+    *mbl_high = 0;
+    *mbl_low = sizeof(sha512in) * 8;
+
+    /* Process input data with KLMD (finalize hash) */
+    cpacf_klmd(CPACF_KLMD_SHA_512, param, sha512in,
+               sizeof(sha512in), NULL, 0, &cc);
+
+    /* Check for correct condition code (should be 0 on success) */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare hash result in param with expected message digest */
+    if (memcmp(param, sha512md, sizeof(sha512md))) {
+        printf("%s failed: hash mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_klmd_query();
+
+    /* Test SHA-256 */
+    rc += test_klmd_sha256();
+
+    /* Test SHA-512 */
+    rc += test_klmd_sha512();
+
+    if (rc) {
+        printf("cpacf-klmd: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-km.c b/tests/tcg/s390x/cpacf-km.c
new file mode 100644
index 0000000000..35a5ecbfef
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-km.c
@@ -0,0 +1,590 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF KM instruction
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected km query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x38, 0x38, 0x00, 0x00, 0x28, 0x28,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* KM AES-128 test data */
+static const uint8_t kmaes128key[] = {
+    0xed, 0xfd, 0xb2, 0x57, 0xcb, 0x37, 0xcd, 0xf1,
+    0x82, 0xc5, 0x45, 0x5b, 0x0c, 0x0e, 0xfe, 0xbb
+};
+static const uint8_t kmaes128plain[] = {
+    0x16, 0x95, 0xfe, 0x47, 0x54, 0x21, 0xca, 0xce,
+    0x35, 0x57, 0xda, 0xca, 0x01, 0xf4, 0x45, 0xff
+};
+static const uint8_t kmaes128cipher[] = {
+    0x78, 0x88, 0xbe, 0xae, 0x6e, 0x7a, 0x42, 0x63,
+    0x32, 0xa7, 0xea, 0xa2, 0xf8, 0x08, 0xe6, 0x37
+};
+
+/* KM AES-192 test data */
+static const uint8_t kmaes192key[] = {
+    0x61, 0x39, 0x6c, 0x53, 0x0c, 0xc1, 0x74, 0x9a,
+    0x5b, 0xab, 0x6f, 0xbc, 0xf9, 0x06, 0xfe, 0x67,
+    0x2d, 0x0c, 0x4a, 0xb2, 0x01, 0xaf, 0x45, 0x54
+};
+static const uint8_t kmaes192plain[] = {
+    0x60, 0xbc, 0xdb, 0x94, 0x16, 0xba, 0xc0, 0x8d,
+    0x7f, 0xd0, 0xd7, 0x80, 0x35, 0x37, 0x40, 0xa5
+};
+static const uint8_t kmaes192cipher[] = {
+    0x24, 0xf4, 0x0c, 0x4e, 0xec, 0xd9, 0xc4, 0x98,
+    0x25, 0x00, 0x0f, 0xcb, 0x49, 0x72, 0x64, 0x7a
+};
+
+/* KM AES-256 test data */
+static const uint8_t kmaes256key[] = {
+    0xcc, 0x22, 0xda, 0x78, 0x7f, 0x37, 0x57, 0x11,
+    0xc7, 0x63, 0x02, 0xbe, 0xf0, 0x97, 0x9d, 0x8e,
+    0xdd, 0xf8, 0x42, 0x82, 0x9c, 0x2b, 0x99, 0xef,
+    0x3d, 0xd0, 0x4e, 0x23, 0xe5, 0x4c, 0xc2, 0x4b
+};
+static const uint8_t kmaes256plain[] = {
+    0xcc, 0xc6, 0x2c, 0x6b, 0x0a, 0x09, 0xa6, 0x71,
+    0xd6, 0x44, 0x56, 0x81, 0x8d, 0xb2, 0x9a, 0x4d
+};
+static const uint8_t kmaes256cipher[] = {
+    0xdf, 0x86, 0x34, 0xca, 0x02, 0xb1, 0x3a, 0x12,
+    0x5b, 0x78, 0x6e, 0x1d, 0xce, 0x90, 0x65, 0x8b
+};
+
+/* KM AES XTS-128 test data */
+static const uint8_t kmaesxts128key1[] = {
+    0xa1, 0xb9, 0x0c, 0xba, 0x3f, 0x06, 0xac, 0x35,
+    0x3b, 0x2c, 0x34, 0x38, 0x76, 0x08, 0x17, 0x62
+};
+static const uint8_t kmaesxts128key2[] = {
+    0x09, 0x09, 0x23, 0x02, 0x6e, 0x91, 0x77, 0x18,
+    0x15, 0xf2, 0x9d, 0xab, 0x01, 0x93, 0x2f, 0x2f
+};
+static const uint8_t kmaesxts128sect[] = {
+    0x4f, 0xae, 0xf7, 0x11, 0x7c, 0xda, 0x59, 0xc6,
+    0x6e, 0x4b, 0x92, 0x01, 0x3e, 0x76, 0x8a, 0xd5
+};
+static const uint8_t kmaesxts128plain[] = {
+    0xeb, 0xab, 0xce, 0x95, 0xb1, 0x4d, 0x3c, 0x8d,
+    0x6f, 0xb3, 0x50, 0x39, 0x07, 0x90, 0x31, 0x1c
+};
+static const uint8_t kmaesxts128cipher[] = {
+    0x77, 0x8a, 0xe8, 0xb4, 0x3c, 0xb9, 0x8d, 0x5a,
+    0x82, 0x50, 0x81, 0xd5, 0xbe, 0x47, 0x1c, 0x63
+};
+
+/* KM AES XTS-256 test data */
+static const uint8_t kmaesxts256key1[] = {
+    0x1e, 0xa6, 0x61, 0xc5, 0x8d, 0x94, 0x3a, 0x0e,
+    0x48, 0x01, 0xe4, 0x2f, 0x4b, 0x09, 0x47, 0x14,
+    0x9e, 0x7f, 0x9f, 0x8e, 0x3e, 0x68, 0xd0, 0xc7,
+    0x50, 0x52, 0x10, 0xbd, 0x31, 0x1a, 0x0e, 0x7c
+};
+static const uint8_t kmaesxts256key2[] = {
+    0xd6, 0xe1, 0x3f, 0xfd, 0xf2, 0x41, 0x8d, 0x8d,
+    0x19, 0x11, 0xc0, 0x04, 0xcd, 0xa5, 0x8d, 0xa3,
+    0xd6, 0x19, 0xb7, 0xe2, 0xb9, 0x14, 0x1e, 0x58,
+    0x31, 0x8e, 0xea, 0x39, 0x2c, 0xf4, 0x1b, 0x08
+};
+static const uint8_t kmaesxts256sect[] = {
+    0xad, 0xf8, 0xd9, 0x26, 0x27, 0x46, 0x4a, 0xd2,
+    0xf0, 0x42, 0x8e, 0x84, 0xa9, 0xf8, 0x75, 0x64
+};
+static const uint8_t kmaesxts256plain[] = {
+    0x2e, 0xed, 0xea, 0x52, 0xcd, 0x82, 0x15, 0xe1,
+    0xac, 0xc6, 0x47, 0xe8, 0x10, 0xbb, 0xc3, 0x64,
+    0x2e, 0x87, 0x28, 0x7f, 0x8d, 0x2e, 0x57, 0xe3,
+    0x6c, 0x0a, 0x24, 0xfb, 0xc1, 0x2a, 0x20, 0x2e
+};
+static const uint8_t kmaesxts256cipher[] = {
+    0xcb, 0xaa, 0xd0, 0xe2, 0xf6, 0xce, 0xa3, 0xf5,
+    0x0b, 0x37, 0xf9, 0x34, 0xd4, 0x6a, 0x9b, 0x13,
+    0x0b, 0x9d, 0x54, 0xf0, 0x7e, 0x34, 0xf3, 0x6a,
+    0xf7, 0x93, 0xe8, 0x6f, 0x73, 0xc6, 0xd7, 0xdb
+};
+
+/* static byte array containing the WKVP */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * Query test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_km(CPACF_KM_QUERY, query_block, NULL, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_AES_128 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_aes_128(void)
+{
+    uint8_t param[16]; /* key only, no IV for ECB mode */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmaes128key, sizeof(kmaes128key));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_AES_128, param, output, kmaes128plain,
+             sizeof(kmaes128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes128cipher, sizeof(kmaes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_AES_192 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_aes_192(void)
+{
+    uint8_t param[24]; /* key only, no IV for ECB mode */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmaes192key, sizeof(kmaes192key));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_AES_192, param, output, kmaes192plain,
+             sizeof(kmaes192plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes192cipher, sizeof(kmaes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_AES_256 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_aes_256(void)
+{
+    uint8_t param[32]; /* key only, no IV for ECB mode */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmaes256key, sizeof(kmaes256key));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_AES_256, param, output, kmaes256plain,
+             sizeof(kmaes256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes256cipher, sizeof(kmaes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_PAES_128 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_paes_128(void)
+{
+    uint8_t param[16 + 32]; /* protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmaes128key, sizeof(kmaes128key));
+    encrypt_clrkey(param, sizeof(kmaes128key));
+    memcpy(param + sizeof(kmaes128key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_PAES_128, param, output, kmaes128plain,
+             sizeof(kmaes128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes128cipher, sizeof(kmaes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_PAES_192 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_paes_192(void)
+{
+    uint8_t param[24 + 32]; /* protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmaes192key, sizeof(kmaes192key));
+    encrypt_clrkey(param, sizeof(kmaes192key));
+    memcpy(param + sizeof(kmaes192key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_PAES_192, param, output, kmaes192plain,
+             sizeof(kmaes192plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes192cipher, sizeof(kmaes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_PAES_256 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_paes_256(void)
+{
+    uint8_t param[32 + 32]; /* protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmaes256key, sizeof(kmaes256key));
+    encrypt_clrkey(param, sizeof(kmaes256key));
+    memcpy(param + sizeof(kmaes256key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_PAES_256, param, output, kmaes256plain,
+             sizeof(kmaes256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaes256cipher, sizeof(kmaes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_XTS_128 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_xts_128(void)
+{
+    uint8_t param[16 + 16]; /* key + initial XTS value */
+    uint8_t output[16];
+    uint8_t init_xts[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* First compute initial XTS value using key2 and sector */
+    memcpy(param, kmaesxts128key2, sizeof(kmaesxts128key2));
+    cpacf_km(CPACF_KM_AES_128, param, init_xts, kmaesxts128sect,
+             sizeof(kmaesxts128sect), &cc);
+
+    if (cc != 0) {
+        printf("%s failed: initial XTS computation cc=%lu\n", __func__, cc);
+        return 1;
+    }
+
+    /* Setup parameter block: key1 + initial XTS value */
+    memcpy(param, kmaesxts128key1, sizeof(kmaesxts128key1));
+    memcpy(param + 16, init_xts, sizeof(init_xts));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_XTS_128, param, output, kmaesxts128plain,
+             sizeof(kmaesxts128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaesxts128cipher, sizeof(kmaesxts128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_XTS_256 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_xts_256(void)
+{
+    uint8_t param[32 + 16]; /* key + initial XTS value */
+    uint8_t output[32];
+    uint8_t init_xts[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* First compute initial XTS value using key2 and sector */
+    memcpy(param, kmaesxts256key2, sizeof(kmaesxts256key2));
+    cpacf_km(CPACF_KM_AES_256, param, init_xts, kmaesxts256sect,
+             sizeof(kmaesxts256sect), &cc);
+
+    if (cc != 0) {
+        printf("%s failed: initial XTS computation cc=%lu\n", __func__, cc);
+        return 1;
+    }
+
+    /* Setup parameter block: key1 + initial XTS value */
+    memcpy(param, kmaesxts256key1, sizeof(kmaesxts256key1));
+    memcpy(param + 32, init_xts, sizeof(init_xts));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_XTS_256, param, output, kmaesxts256plain,
+             sizeof(kmaesxts256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaesxts256cipher, sizeof(kmaesxts256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_PXTS_128 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_pxts_128(void)
+{
+    uint8_t param[16 + 32 + 16]; /* protected key + wkvp + initial XTS value */
+    uint8_t output[16];
+    uint8_t init_xts[16];
+    uint8_t key2_param[16 + 32];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* First compute initial XTS value using protected key2 and sector */
+    memcpy(key2_param, kmaesxts128key2, sizeof(kmaesxts128key2));
+    encrypt_clrkey(key2_param, sizeof(kmaesxts128key2));
+    memcpy(key2_param + sizeof(kmaesxts128key2),
+           protkey_wkvp, sizeof(protkey_wkvp));
+
+    cpacf_km(CPACF_KM_PAES_128, key2_param, init_xts, kmaesxts128sect,
+             sizeof(kmaesxts128sect), &cc);
+
+    if (cc != 0) {
+        printf("%s failed: initial XTS computation cc=%lu\n", __func__, cc);
+        return 1;
+    }
+
+    /* Setup parameter block: protected key1 + wkvp + initial XTS value */
+    memcpy(param, kmaesxts128key1, sizeof(kmaesxts128key1));
+    encrypt_clrkey(param, sizeof(kmaesxts128key1));
+    memcpy(param + sizeof(kmaesxts128key1), protkey_wkvp, sizeof(protkey_wkvp));
+    memcpy(param + sizeof(kmaesxts128key1) + sizeof(protkey_wkvp),
+           init_xts, sizeof(init_xts));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_PXTS_128, param, output, kmaesxts128plain,
+             sizeof(kmaesxts128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaesxts128cipher, sizeof(kmaesxts128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KM_PXTS_256 test for km
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_km_pxts_256(void)
+{
+    uint8_t param[32 + 32 + 16]; /* protected key + wkvp + initial XTS value */
+    uint8_t output[32];
+    uint8_t init_xts[16];
+    uint8_t key2_param[32 + 32];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* First compute initial XTS value using protected key2 and sector */
+    memcpy(key2_param, kmaesxts256key2, sizeof(kmaesxts256key2));
+    encrypt_clrkey(key2_param, sizeof(kmaesxts256key2));
+    memcpy(key2_param + sizeof(kmaesxts256key2),
+           protkey_wkvp, sizeof(protkey_wkvp));
+
+    cpacf_km(CPACF_KM_PAES_256, key2_param, init_xts, kmaesxts256sect,
+             sizeof(kmaesxts256sect), &cc);
+
+    if (cc != 0) {
+        printf("%s failed: initial XTS computation cc=%lu\n", __func__, cc);
+        return 1;
+    }
+
+    /* Setup parameter block: protected key1 + wkvp + initial XTS value */
+    memcpy(param, kmaesxts256key1, sizeof(kmaesxts256key1));
+    encrypt_clrkey(param, sizeof(kmaesxts256key1));
+    memcpy(param + sizeof(kmaesxts256key1), protkey_wkvp, sizeof(protkey_wkvp));
+    memcpy(param + sizeof(kmaesxts256key1) + sizeof(protkey_wkvp),
+           init_xts, sizeof(init_xts));
+
+    /* Encrypt */
+    cpacf_km(CPACF_KM_PXTS_256, param, output, kmaesxts256plain,
+             sizeof(kmaesxts256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmaesxts256cipher, sizeof(kmaesxts256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_km_query();
+
+    /* Test AES-128 */
+    rc += test_km_aes_128();
+
+    /* Test AES-192 */
+    rc += test_km_aes_192();
+
+    /* Test AES-256 */
+    rc += test_km_aes_256();
+
+    /* Test PAES-128 */
+    rc += test_km_paes_128();
+
+    /* Test PAES-192 */
+    rc += test_km_paes_192();
+
+    /* Test PAES-256 */
+    rc += test_km_paes_256();
+
+    /* Test XTS-128 */
+    rc += test_km_xts_128();
+
+    /* Test XTS-256 */
+    rc += test_km_xts_256();
+
+    /* Test PXTS-128 */
+    rc += test_km_pxts_128();
+
+    /* Test PXTS-256 */
+    rc += test_km_pxts_256();
+
+    if (rc) {
+        printf("cpacf-km: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kmac.c b/tests/tcg/s390x/cpacf-kmac.c
new file mode 100644
index 0000000000..c9ef847110
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kmac.c
@@ -0,0 +1,58 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for the CPACF KMAC instruction
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected kmac query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static int test_kmac_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_kmac(CPACF_KMAC_QUERY, query_block, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc;
+
+    /* Test query function */
+    rc = test_kmac_query();
+
+    /* As of now only KMAC query is implemented */
+
+    if (rc) {
+        printf("cpacf-kmac: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kmc.c b/tests/tcg/s390x/cpacf-kmc.c
new file mode 100644
index 0000000000..671a8f3171
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kmc.c
@@ -0,0 +1,351 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF KMC instruction
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected kmc query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x38, 0x38, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* KMC AES-128 test data */
+static const uint8_t kmcaes128key[] = {
+    0x1f, 0x8e, 0x49, 0x73, 0x95, 0x3f, 0x3f, 0xb0,
+    0xbd, 0x6b, 0x16, 0x66, 0x2e, 0x9a, 0x3c, 0x17
+};
+static const uint8_t kmcaes128iv[] = {
+    0x2f, 0xe2, 0xb3, 0x33, 0xce, 0xda, 0x8f, 0x98,
+    0xf4, 0xa9, 0x9b, 0x40, 0xd2, 0xcd, 0x34, 0xa8
+};
+static const uint8_t kmcaes128plain[] = {
+    0x45, 0xcf, 0x12, 0x96, 0x4f, 0xc8, 0x24, 0xab,
+    0x76, 0x61, 0x6a, 0xe2, 0xf4, 0xbf, 0x08, 0x22
+};
+static const uint8_t kmcaes128cipher[] = {
+    0x0f, 0x61, 0xc4, 0xd4, 0x4c, 0x51, 0x47, 0xc0,
+    0x3c, 0x19, 0x5a, 0xd7, 0xe2, 0xcc, 0x12, 0xb2
+};
+
+/* KMC AES-192 test data */
+static const uint8_t kmcaes192key[] = {
+    0xba, 0x75, 0xf4, 0xd1, 0xd9, 0xd7, 0xcf, 0x7f,
+    0x55, 0x14, 0x45, 0xd5, 0x6c, 0xc1, 0xa8, 0xab,
+    0x2a, 0x07, 0x8e, 0x15, 0xe0, 0x49, 0xdc, 0x2c
+};
+static const uint8_t kmcaes192iv[] = {
+    0x53, 0x1c, 0xe7, 0x81, 0x76, 0x40, 0x16, 0x66,
+    0xaa, 0x30, 0xdb, 0x94, 0xec, 0x4a, 0x30, 0xeb
+};
+static const uint8_t kmcaes192plain[] = {
+    0xc5, 0x1f, 0xc2, 0x76, 0x77, 0x4d, 0xad, 0x94,
+    0xbc, 0xdc, 0x1d, 0x28, 0x91, 0xec, 0x86, 0x68
+};
+static const uint8_t kmcaes192cipher[] = {
+    0x70, 0xdd, 0x95, 0xa1, 0x4e, 0xe9, 0x75, 0xe2,
+    0x39, 0xdf, 0x36, 0xff, 0x4a, 0xee, 0x1d, 0x5d
+};
+
+/* KMC AES-256 test data */
+static const uint8_t kmcaes256key[] = {
+    0x6e, 0xd7, 0x6d, 0x2d, 0x97, 0xc6, 0x9f, 0xd1,
+    0x33, 0x95, 0x89, 0x52, 0x39, 0x31, 0xf2, 0xa6,
+    0xcf, 0xf5, 0x54, 0xb1, 0x5f, 0x73, 0x8f, 0x21,
+    0xec, 0x72, 0xdd, 0x97, 0xa7, 0x33, 0x09, 0x07
+};
+static const uint8_t kmcaes256iv[] = {
+    0x85, 0x1e, 0x87, 0x64, 0x77, 0x6e, 0x67, 0x96,
+    0xaa, 0xb7, 0x22, 0xdb, 0xb6, 0x44, 0xac, 0xe8
+};
+static const uint8_t kmcaes256plain[] = {
+    0x62, 0x82, 0xb8, 0xc0, 0x5c, 0x5c, 0x15, 0x30,
+    0xb9, 0x7d, 0x48, 0x16, 0xca, 0x43, 0x47, 0x62
+};
+static const uint8_t kmcaes256cipher[] = {
+    0x6a, 0xcc, 0x04, 0x14, 0x2e, 0x10, 0x0a, 0x65,
+    0xf5, 0x1b, 0x97, 0xad, 0xf5, 0x17, 0x2c, 0x41
+};
+
+/* static byte array containing the WKVP */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * Query test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_kmc(CPACF_KMC_QUERY, query_block, NULL, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_AES_128 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_aes_128(void)
+{
+    uint8_t param[16 + 16]; /* IV + key */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV followed by key */
+    memcpy(param, kmcaes128iv, sizeof(kmcaes128iv));
+    memcpy(param + sizeof(kmcaes128iv), kmcaes128key, sizeof(kmcaes128key));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_AES_128, param, output, kmcaes128plain,
+              sizeof(kmcaes128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes128cipher, sizeof(kmcaes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_AES_192 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_aes_192(void)
+{
+    uint8_t param[16 + 24]; /* IV + key */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV followed by key */
+    memcpy(param, kmcaes192iv, sizeof(kmcaes192iv));
+    memcpy(param + sizeof(kmcaes192iv), kmcaes192key, sizeof(kmcaes192key));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_AES_192, param, output, kmcaes192plain,
+              sizeof(kmcaes192plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes192cipher, sizeof(kmcaes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_AES_256 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_aes_256(void)
+{
+    uint8_t param[16 + 32]; /* IV + key */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV followed by key */
+    memcpy(param, kmcaes256iv, sizeof(kmcaes256iv));
+    memcpy(param + sizeof(kmcaes256iv), kmcaes256key, sizeof(kmcaes256key));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_AES_256, param, output, kmcaes256plain,
+              sizeof(kmcaes256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes256cipher, sizeof(kmcaes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_PAES_128 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_paes_128(void)
+{
+    uint8_t param[16 + 16 + 32]; /* IV + protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV + protected key + wkvp */
+    memcpy(param, kmcaes128iv, sizeof(kmcaes128iv));
+    memcpy(param + sizeof(kmcaes128iv), kmcaes128key, sizeof(kmcaes128key));
+    encrypt_clrkey(param + sizeof(kmcaes128iv), sizeof(kmcaes128key));
+    memcpy(param + sizeof(kmcaes128iv) + sizeof(kmcaes128key),
+           protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_PAES_128, param, output, kmcaes128plain,
+              sizeof(kmcaes128plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes128cipher, sizeof(kmcaes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_PAES_192 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_paes_192(void)
+{
+    uint8_t param[16 + 24 + 32]; /* IV + protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV + protected key + wkvp */
+    memcpy(param, kmcaes192iv, sizeof(kmcaes192iv));
+    memcpy(param + sizeof(kmcaes192iv), kmcaes192key, sizeof(kmcaes192key));
+    encrypt_clrkey(param + sizeof(kmcaes192iv), sizeof(kmcaes192key));
+    memcpy(param + sizeof(kmcaes192iv) + sizeof(kmcaes192key),
+           protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_PAES_192, param, output, kmcaes192plain,
+              sizeof(kmcaes192plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes192cipher, sizeof(kmcaes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMC_PAES_256 test for kmc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmc_paes_256(void)
+{
+    uint8_t param[16 + 32 + 32]; /* IV + protected key + wkvp */
+    uint8_t output[16];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: IV + protected key + wkvp */
+    memcpy(param, kmcaes256iv, sizeof(kmcaes256iv));
+    memcpy(param + sizeof(kmcaes256iv), kmcaes256key, sizeof(kmcaes256key));
+    encrypt_clrkey(param + sizeof(kmcaes256iv), sizeof(kmcaes256key));
+    memcpy(param + sizeof(kmcaes256iv) + sizeof(kmcaes256key),
+           protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Encrypt */
+    cpacf_kmc(CPACF_KMC_PAES_256, param, output, kmcaes256plain,
+              sizeof(kmcaes256plain), &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmcaes256cipher, sizeof(kmcaes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_kmc_query();
+
+    /* Test AES-128 */
+    rc += test_kmc_aes_128();
+
+    /* Test AES-192 */
+    rc += test_kmc_aes_192();
+
+    /* Test AES-256 */
+    rc += test_kmc_aes_256();
+
+    /* Test PAES-128 */
+    rc += test_kmc_paes_128();
+
+    /* Test PAES-192 */
+    rc += test_kmc_paes_192();
+
+    /* Test PAES-256 */
+    rc += test_kmc_paes_256();
+
+    if (rc) {
+        printf("cpacf-kmc: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kmctr.c b/tests/tcg/s390x/cpacf-kmctr.c
new file mode 100644
index 0000000000..515f94038b
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kmctr.c
@@ -0,0 +1,360 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF KMCTR instruction
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected kmctr query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x38, 0x38, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* KMCTR AES-128 test data */
+static const uint8_t kmctraes128key[] = {
+    0xed, 0xfd, 0xb2, 0x57, 0xcb, 0x37, 0xcd, 0xf1,
+    0x82, 0xc5, 0x45, 0x5b, 0x0c, 0x0e, 0xfe, 0xbb
+};
+static const uint8_t kmctraes128plain[] = {
+    0x16, 0x95, 0xfe, 0x47, 0x54, 0x21, 0xca, 0xce,
+    0x35, 0x57, 0xda, 0xca, 0x01, 0xf4, 0x45, 0xff
+};
+static const uint8_t kmctraes128cipher[] = {
+    0x78, 0x88, 0xbe, 0xae, 0x6e, 0x7a, 0x42, 0x63,
+    0x32, 0xa7, 0xea, 0xa2, 0xf8, 0x08, 0xe6, 0x37
+};
+
+/* KMCTR AES-192 test data */
+static const uint8_t kmctraes192key[] = {
+    0x61, 0x39, 0x6c, 0x53, 0x0c, 0xc1, 0x74, 0x9a,
+    0x5b, 0xab, 0x6f, 0xbc, 0xf9, 0x06, 0xfe, 0x67,
+    0x2d, 0x0c, 0x4a, 0xb2, 0x01, 0xaf, 0x45, 0x54
+};
+static const uint8_t kmctraes192plain[] = {
+    0x60, 0xbc, 0xdb, 0x94, 0x16, 0xba, 0xc0, 0x8d,
+    0x7f, 0xd0, 0xd7, 0x80, 0x35, 0x37, 0x40, 0xa5
+};
+static const uint8_t kmctraes192cipher[] = {
+    0x24, 0xf4, 0x0c, 0x4e, 0xec, 0xd9, 0xc4, 0x98,
+    0x25, 0x00, 0x0f, 0xcb, 0x49, 0x72, 0x64, 0x7a
+};
+
+/* KMCTR AES-256 test data */
+static const uint8_t kmctraes256key[] = {
+    0xcc, 0x22, 0xda, 0x78, 0x7f, 0x37, 0x57, 0x11,
+    0xc7, 0x63, 0x02, 0xbe, 0xf0, 0x97, 0x9d, 0x8e,
+    0xdd, 0xf8, 0x42, 0x82, 0x9c, 0x2b, 0x99, 0xef,
+    0x3d, 0xd0, 0x4e, 0x23, 0xe5, 0x4c, 0xc2, 0x4b
+};
+static const uint8_t kmctraes256plain[] = {
+    0xcc, 0xc6, 0x2c, 0x6b, 0x0a, 0x09, 0xa6, 0x71,
+    0xd6, 0x44, 0x56, 0x81, 0x8d, 0xb2, 0x9a, 0x4d
+};
+static const uint8_t kmctraes256cipher[] = {
+    0xdf, 0x86, 0x34, 0xca, 0x02, 0xb1, 0x3a, 0x12,
+    0x5b, 0x78, 0x6e, 0x1d, 0xce, 0x90, 0x65, 0x8b
+};
+
+/* static byte array containing the WKVP */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * Query test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_kmctr(CPACF_KMCTR_QUERY, query_block, NULL, NULL, 0, NULL, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_AES_128 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_aes_128(void)
+{
+    uint8_t param[16];      /* Parameter block: AES-128 key */
+    uint8_t src[16] = {0};  /* Source data (zeros for this test) */
+    uint8_t counter[16];    /* Counter value */
+    uint8_t output[16];     /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmctraes128key, sizeof(kmctraes128key));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes128plain, sizeof(kmctraes128plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_AES_128, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes128cipher, sizeof(kmctraes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_AES_192 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_aes_192(void)
+{
+    uint8_t param[24];      /* Parameter block: AES-192 key */
+    uint8_t src[16] = {0};  /* Source data (zeros for this test) */
+    uint8_t counter[16];    /* Counter value */
+    uint8_t output[16];     /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmctraes192key, sizeof(kmctraes192key));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes192plain, sizeof(kmctraes192plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_AES_192, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes192cipher, sizeof(kmctraes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_AES_256 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_aes_256(void)
+{
+    uint8_t param[32];      /* Parameter block: AES-256 key */
+    uint8_t src[16] = {0};  /* Source data (zeros for this test) */
+    uint8_t counter[16];    /* Counter value */
+    uint8_t output[16];     /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key only */
+    memcpy(param, kmctraes256key, sizeof(kmctraes256key));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes256plain, sizeof(kmctraes256plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_AES_256, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes256cipher, sizeof(kmctraes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_PAES_128 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_paes_128(void)
+{
+    uint8_t param[16 + 32];  /* Parameter block: protected key + wkvp */
+    uint8_t src[16] = {0};   /* Source data (zeros for this test) */
+    uint8_t counter[16];     /* Counter value */
+    uint8_t output[16];      /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmctraes128key, sizeof(kmctraes128key));
+    encrypt_clrkey(param, sizeof(kmctraes128key));
+    memcpy(param + sizeof(kmctraes128key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes128plain, sizeof(kmctraes128plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_PAES_128, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes128cipher, sizeof(kmctraes128cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_PAES_192 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_paes_192(void)
+{
+    uint8_t param[24 + 32];  /* Parameter block: protected key + wkvp */
+    uint8_t src[16] = {0};   /* Source data (zeros for this test) */
+    uint8_t counter[16];     /* Counter value */
+    uint8_t output[16];      /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmctraes192key, sizeof(kmctraes192key));
+    encrypt_clrkey(param, sizeof(kmctraes192key));
+    memcpy(param + sizeof(kmctraes192key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes192plain, sizeof(kmctraes192plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_PAES_192, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes192cipher, sizeof(kmctraes192cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_KMCTR_PAES_256 test for kmctr
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_kmctr_paes_256(void)
+{
+    uint8_t param[32 + 32];  /* Parameter block: protected key + wkvp */
+    uint8_t src[16] = {0};   /* Source data (zeros for this test) */
+    uint8_t counter[16];     /* Counter value */
+    uint8_t output[16];      /* Output buffer */
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp */
+    memcpy(param, kmctraes256key, sizeof(kmctraes256key));
+    encrypt_clrkey(param, sizeof(kmctraes256key));
+    memcpy(param + sizeof(kmctraes256key), protkey_wkvp, sizeof(protkey_wkvp));
+
+    /* Setup counter buffer */
+    memcpy(counter, kmctraes256plain, sizeof(kmctraes256plain));
+
+    /* En/Decrypt src with given counter, note that src is all zero */
+    cpacf_kmctr(CPACF_KMCTR_PAES_256, param, output, src,
+                sizeof(src), counter, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare result with expected ciphertext */
+    if (memcmp(output, kmctraes256cipher, sizeof(kmctraes256cipher))) {
+        printf("%s failed: output mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_kmctr_query();
+
+    /* Test AES-128 */
+    rc += test_kmctr_aes_128();
+
+    /* Test AES-192 */
+    rc += test_kmctr_aes_192();
+
+    /* Test AES-256 */
+    rc += test_kmctr_aes_256();
+
+    /* Test PAES-128 */
+    rc += test_kmctr_paes_128();
+
+    /* Test PAES-192 */
+    rc += test_kmctr_paes_192();
+
+    /* Test PAES-256 */
+    rc += test_kmctr_paes_256();
+
+    if (rc) {
+        printf("cpacf-kmctr: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-pcc.c b/tests/tcg/s390x/cpacf-pcc.c
new file mode 100644
index 0000000000..e61672f98b
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-pcc.c
@@ -0,0 +1,245 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF PCC instruction
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+
+/* expected pcc query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x28,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* PCC XTS AES-128 test data */
+static const uint8_t kmaes128key[] = {
+    0xed, 0xfd, 0xb2, 0x57, 0xcb, 0x37, 0xcd, 0xf1,
+    0x82, 0xc5, 0x45, 0x5b, 0x0c, 0x0e, 0xfe, 0xbb
+};
+static const uint8_t kmaes128plain[] = {
+    0x16, 0x95, 0xfe, 0x47, 0x54, 0x21, 0xca, 0xce,
+    0x35, 0x57, 0xda, 0xca, 0x01, 0xf4, 0x45, 0xff
+};
+static const uint8_t kmaes128cipher[] = {
+    0x78, 0x88, 0xbe, 0xae, 0x6e, 0x7a, 0x42, 0x63,
+    0x32, 0xa7, 0xea, 0xa2, 0xf8, 0x08, 0xe6, 0x37
+};
+
+/* PCC XTS AES-256 test data */
+static const uint8_t kmaes256key[] = {
+    0xcc, 0x22, 0xda, 0x78, 0x7f, 0x37, 0x57, 0x11,
+    0xc7, 0x63, 0x02, 0xbe, 0xf0, 0x97, 0x9d, 0x8e,
+    0xdd, 0xf8, 0x42, 0x82, 0x9c, 0x2b, 0x99, 0xef,
+    0x3d, 0xd0, 0x4e, 0x23, 0xe5, 0x4c, 0xc2, 0x4b
+};
+static const uint8_t kmaes256plain[] = {
+    0xcc, 0xc6, 0x2c, 0x6b, 0x0a, 0x09, 0xa6, 0x71,
+    0xd6, 0x44, 0x56, 0x81, 0x8d, 0xb2, 0x9a, 0x4d
+};
+static const uint8_t kmaes256cipher[] = {
+    0xdf, 0x86, 0x34, 0xca, 0x02, 0xb1, 0x3a, 0x12,
+    0x5b, 0x78, 0x6e, 0x1d, 0xce, 0x90, 0x65, 0x8b
+};
+
+/* static byte array containing the WKVP */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * Query test for pcc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_pcc_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_pcc(CPACF_PCC_QUERY, query_block, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_PCC_XTS_AES_128 test for pcc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_pcc_xts_aes_128(void)
+{
+    uint8_t param[80];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key + plaintext + zeros */
+    memcpy(param, kmaes128key, sizeof(kmaes128key));
+    memcpy(param + 16, kmaes128plain, sizeof(kmaes128plain));
+    /* Clear Block Sequential Nr, Intermediate Bit Index, and XTS Parameter */
+    memset(param + 32, 0, 48);
+
+    /* Execute PCC to compute XTS parameter */
+    cpacf_pcc(CPACF_PCC_XTS_AES_128, param, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare computed XTS parameter (at offset 64) with expected cipher */
+    if (memcmp(param + 64, kmaes128cipher, sizeof(kmaes128cipher))) {
+        printf("%s failed: XTS parameter mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_PCC_XTS_AES_256 test for pcc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_pcc_xts_aes_256(void)
+{
+    uint8_t param[96];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: key + plaintext + zeros */
+    memcpy(param, kmaes256key, sizeof(kmaes256key));
+    memcpy(param + 32, kmaes256plain, sizeof(kmaes256plain));
+    /* Clear Block Sequential Nr, Intermediate Bit Index, and XTS Parameter */
+    memset(param + 48, 0, 48);
+
+    /* Execute PCC to compute XTS parameter */
+    cpacf_pcc(CPACF_PCC_XTS_AES_256, param, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare computed XTS parameter (at offset 80) with expected cipher */
+    if (memcmp(param + 80, kmaes256cipher, sizeof(kmaes256cipher))) {
+        printf("%s failed: XTS parameter mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_PCC_XTS_PAES_128 test for pcc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_pcc_xts_paes_128(void)
+{
+    uint8_t param[112];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp + plaintext + zeros */
+    memcpy(param, kmaes128key, sizeof(kmaes128key));
+    encrypt_clrkey(param, sizeof(kmaes128key));
+    memcpy(param + 16, protkey_wkvp, sizeof(protkey_wkvp));
+    memcpy(param + 48, kmaes128plain, sizeof(kmaes128plain));
+    /* Clear Block Sequential Nr, Intermediate Bit Index, and XTS Parameter */
+    memset(param + 64, 0, 48);
+
+    /* Execute PCC to compute XTS parameter */
+    cpacf_pcc(CPACF_PCC_XTS_PAES_128, param, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare computed XTS parameter (at offset 96) with expected cipher */
+    if (memcmp(param + 96, kmaes128cipher, sizeof(kmaes128cipher))) {
+        printf("%s failed: XTS parameter mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+/*
+ * Subfunction CPACF_PCC_XTS_PAES_256 test for pcc
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_pcc_xts_paes_256(void)
+{
+    uint8_t param[128];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Setup parameter block: protected key + wkvp + plaintext + zeros */
+    memcpy(param, kmaes256key, sizeof(kmaes256key));
+    encrypt_clrkey(param, sizeof(kmaes256key));
+    memcpy(param + 32, protkey_wkvp, sizeof(protkey_wkvp));
+    memcpy(param + 64, kmaes256plain, sizeof(kmaes256plain));
+    /* Clear Block Sequential Nr, Intermediate Bit Index, and XTS Parameter */
+    memset(param + 80, 0, 48);
+
+    /* Execute PCC to compute XTS parameter */
+    cpacf_pcc(CPACF_PCC_XTS_PAES_256, param, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu\n", __func__, cc);
+        rc = 1;
+    }
+
+    /* Compare computed XTS parameter (at offset 112) with expected cipher */
+    if (memcmp(param + 112, kmaes256cipher, sizeof(kmaes256cipher))) {
+        printf("%s failed: XTS parameter mismatch\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_pcc_query();
+
+    /* Test XTS-AES-128 */
+    rc += test_pcc_xts_aes_128();
+
+    /* Test XTS-AES-256 */
+    rc += test_pcc_xts_aes_256();
+
+    /* Test XTS-PAES-128 */
+    rc += test_pcc_xts_paes_128();
+
+    /* Test XTS-PAES-256 */
+    rc += test_pcc_xts_paes_256();
+
+    if (rc) {
+        printf("cpacf-pcc: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-pckmo.c b/tests/tcg/s390x/cpacf-pckmo.c
new file mode 100644
index 0000000000..affcc88d56
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-pckmo.c
@@ -0,0 +1,45 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF PCKMO instruction (privileged operation).
+ *
+ * As PCKMO is a privileged instruction, when executed in user mode,
+ * it triggers a privileged operation exception, which is mapped to SIGILL.
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "cpacf.h"
+
+static void handle_sigill(int sig, siginfo_t *info, void *ucontext)
+{
+    /* PCKMO is privileged, so we expect SIGILL - this is success */
+    _exit(EXIT_SUCCESS);
+}
+
+int main(void)
+{
+    struct sigaction act;
+    uint8_t param_block[32] = {0};  /* Parameter block for PCKMO */
+    int err;
+
+    /* Setup signal handler for SIGILL (privileged operation exception) */
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGILL, &act, NULL);
+    assert(err == 0);
+
+    /*
+     * Attempt to execute PCKMO with subfunction CPACF_PCKMO_QUERY.
+     * As PCKMO is privileged, it should trigger SIGILL.
+     */
+    cpacf_pckmo(CPACF_PCKMO_QUERY, param_block);
+
+    /* Should never be reached - PCKMO should trigger exception */
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/s390x/cpacf-prno.c b/tests/tcg/s390x/cpacf-prno.c
new file mode 100644
index 0000000000..1081a9e970
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-prno.c
@@ -0,0 +1,131 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Simple test for CPACF PRNO instruction
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include "cpacf.h"
+
+#define QUERY_BLOCK_SIZE 16
+#define TRNG_OUTPUT_SIZE 32
+
+/* expected prno query block */
+static uint8_t exp_query_block[QUERY_BLOCK_SIZE] = {
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+};
+
+/*
+ * Query test for prno
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_prno_query(void)
+{
+    uint8_t query_block[QUERY_BLOCK_SIZE] = {0};
+    unsigned long cc = 0;
+    int i, rc = 0;
+
+    cpacf_prno(CPACF_PRNO_QUERY, query_block, NULL, 0, NULL, 0, &cc);
+
+    /* compare with expected query block */
+    for (i = 0; i < QUERY_BLOCK_SIZE; i++) {
+        if ((query_block[i] & exp_query_block[i]) != exp_query_block[i]) {
+            rc++;
+            break;
+        }
+    }
+
+    if (rc) {
+        printf("%s failed\n", __func__);
+    }
+
+    return rc;
+}
+
+/* check for buffer is all zero */
+static bool is_all_zeros(const uint8_t *buf, size_t len)
+{
+    size_t i;
+
+    for (i = 0; i < len; i++) {
+        if (buf[i] != 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/*
+ * Subfunction CPACF_PRNO_TRNG test for prno
+ * returns > 0 on failure, otherwise 0
+ */
+static int test_prno_trng(void)
+{
+    uint8_t output1[TRNG_OUTPUT_SIZE];
+    uint8_t output2[TRNG_OUTPUT_SIZE];
+    unsigned long cc = 0;
+    int rc = 0;
+
+    /* Initialize outputs to detect if they get filled */
+    memset(output1, 0, sizeof(output1));
+    memset(output2, 0, sizeof(output2));
+
+    /* First TRNG call */
+    cpacf_prno(CPACF_PRNO_TRNG, NULL, output1, sizeof(output1), NULL, 0, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu on first call\n", __func__, cc);
+        rc = 1;
+    }
+    /* Verify output is not all zeros */
+    if (is_all_zeros(output1, TRNG_OUTPUT_SIZE)) {
+        printf("%s failed: output1 is all zeros\n", __func__);
+        rc = 1;
+    }
+
+    /* Second TRNG call */
+    cpacf_prno(CPACF_PRNO_TRNG, NULL, output2, sizeof(output2), NULL, 0, &cc);
+
+    /* Check for correct condition code */
+    if (cc != 0) {
+        printf("%s failed: unexpected cc=%lu on second call\n", __func__, cc);
+        rc = 1;
+    }
+    /* Verify output is not all zeros */
+    if (is_all_zeros(output2, TRNG_OUTPUT_SIZE)) {
+        printf("%s failed: output2 is all zeros\n", __func__);
+        rc = 1;
+    }
+
+    /* Verify the two outputs are different */
+    if (memcmp(output1, output2, TRNG_OUTPUT_SIZE) == 0) {
+        printf("%s failed: two TRNG calls produced same output\n", __func__);
+        rc = 1;
+    }
+
+    return rc;
+}
+
+int main(void)
+{
+    int rc = 0;
+
+    /* Test query function */
+    rc += test_prno_query();
+
+    /* Test TRNG */
+    rc += test_prno_trng();
+
+    if (rc) {
+        printf("cpacf-prno: %d failures\n", rc);
+    }
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf.h b/tests/tcg/s390x/cpacf.h
new file mode 100644
index 0000000000..76b02866b0
--- /dev/null
+++ b/tests/tcg/s390x/cpacf.h
@@ -0,0 +1,571 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Defines and inline functions around testing CPACF instructions
+ *
+ */
+
+#ifndef _S390_CPACF_H_
+#define _S390_CPACF_H_
+
+#define CPACF_H_INCLUDE_FOR_TESTS
+#include "../../../target/s390x/tcg/cpacf.h"
+
+union register_pair {
+    unsigned __int128 pair;
+    struct {
+        unsigned long even;
+        unsigned long odd;
+    };
+};
+
+/*
+ * Instruction opcodes for the CPACF instructions
+ */
+#define CPACF_KMAC              0xb91e          /* MSA  */
+#define CPACF_KM                0xb92e          /* MSA  */
+#define CPACF_KMC               0xb92f          /* MSA  */
+#define CPACF_KIMD              0xb93e          /* MSA  */
+#define CPACF_KLMD              0xb93f          /* MSA  */
+#define CPACF_PCKMO             0xb928          /* MSA3 */
+#define CPACF_KMF               0xb92a          /* MSA4 */
+#define CPACF_KMO               0xb92b          /* MSA4 */
+#define CPACF_PCC               0xb92c          /* MSA4 */
+#define CPACF_KMCTR             0xb92d          /* MSA4 */
+#define CPACF_PRNO              0xb93c          /* MSA5 */
+#define CPACF_KMA               0xb929          /* MSA8 */
+#define CPACF_KDSA              0xb93a          /* MSA9 */
+
+/*
+ * 'encrypt' the clear key value into a protected key
+ * by xor-ing the protkey_xor_pattern onto it.
+ */
+static inline void encrypt_clrkey(uint8_t *key, int keysize)
+{
+    const uint8_t protkey_xor_pattern[32] = PROTKEY_XOR_PATTERN;
+
+    for (int i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+}
+
+/**
+ * cpacf_km() - executes the KM instruction
+ * @func: the function code passed to KM; see CPACF_KM_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, number of processed bytes for
+ * encryption/decryption funcs
+ */
+static inline int cpacf_km(unsigned long func, void *param,
+                           uint8_t *dest, const uint8_t *src, long src_len,
+                           unsigned long *cc)
+{
+    union register_pair d, s;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,%[dst],%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KM)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_kmc() - executes the KMC instruction
+ * @func: the function code passed to KM; see CPACF_KMC_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, number of processed bytes for
+ * encryption/decryption funcs
+ */
+static inline int cpacf_kmc(unsigned long func, void *param,
+                            uint8_t *dest, const uint8_t *src, long src_len,
+                            unsigned long *cc)
+{
+    union register_pair d, s;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,%[dst],%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMC)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_kimd() - executes the KIMD instruction
+ * @func: the function code passed to KM; see CPACF_KIMD_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ */
+static inline void cpacf_kimd(unsigned long func, void *param,
+                              const uint8_t *src, long src_len,
+                              unsigned long *cc)
+{
+    union register_pair s;
+
+    *cc = 0;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,0,%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)(param)),
+                   [opc] "i" (CPACF_KIMD)
+                 : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_klmd() - executes the KLMD instruction
+ * @func: the function code passed to KM; see CPACF_KLMD_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ */
+static inline void cpacf_klmd(unsigned long func, void *param,
+                              const uint8_t *src, long src_len,
+                              uint8_t *dest, long dest_len,
+                              unsigned long *cc)
+{
+    union register_pair s, d;
+
+    *cc = 0;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    d.even = (unsigned long)dest;
+    d.odd  = (unsigned long)dest_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,%[dst],%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KLMD)
+                 : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_kmac() - executes the KMAC instruction
+ * @func: the function code passed to KM; see CPACF_KMAC_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, number of processed bytes for digest funcs
+ */
+static inline int cpacf_kmac(unsigned long func, void *param,
+                             const uint8_t *src, long src_len,
+                             unsigned long *cc)
+{
+    union register_pair s;
+
+    *cc = 0;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,0,%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMAC)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+static inline int cpacf_kmac_x(unsigned long *func, void *param,
+                               const uint8_t *src, long src_len,
+                               unsigned long *cc)
+{
+    union register_pair s;
+    unsigned long fc = *func;
+
+    *cc = 0;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,0,%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:    lgr     %[fc],0\n"
+                 : [fc] "+d" (fc), [src] "+&d" (s.pair), [__cc] "+Q" (*cc)
+                 : [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMAC)
+                 : "cc", "memory", "0", "1");
+
+    *func = fc;
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_kmctr() - executes the KMCTR instruction
+ * @func: the function code passed to KMCTR; see CPACF_KMCTR_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ * @counter: address of counter value
+ *
+ * Returns 0 for the query func, number of processed bytes for
+ * encryption/decryption funcs
+ */
+static inline int cpacf_kmctr(unsigned long func, void *param, uint8_t *dest,
+                              const uint8_t *src, long src_len,
+                              uint8_t *counter, unsigned long *cc)
+{
+    union register_pair d, s, c;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    c.even = (unsigned long)counter;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rrf,%[opc] << 16,%[dst],%[src],%[ctr],0\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair),
+                   [ctr] "+&d" (c.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMCTR)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_prno() - executes the PRNO instruction
+ * @func: the function code passed to PRNO; see CPACF_PRNO_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @dest_len: size of destination memory area in bytes
+ * @seed: address of seed data
+ * @seed_len: size of seed data in bytes
+ */
+static inline void cpacf_prno(unsigned long func, void *param,
+                              uint8_t *dest, unsigned long dest_len,
+                              const uint8_t *seed, unsigned long seed_len,
+                              unsigned long *cc)
+{
+    union register_pair d, s;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    d.odd  = (unsigned long)dest_len;
+    s.even = (unsigned long)seed;
+    s.odd  = (unsigned long)seed_len;
+    asm volatile (
+                  "     lgr     0,%[fc]\n"
+                  "     lgr     1,%[pba]\n"
+                  "0:   .insn   rre,%[opc] << 16,%[dst],%[seed]\n"
+                  "     brc     1,0b\n"          /* handle partial completion */
+                  "     brc     8,2f\n"
+                  "     brc     4,1f\n"
+                  "     agsi    %[__cc],1\n"
+                  "1:   agsi    %[__cc],1\n"
+                  "2:\n"
+                  : [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                  : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                    [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
+                  : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_trng() - executes the TRNG subfunction of the PRNO instruction
+ * @ucbuf: buffer for unconditioned data
+ * @ucbuf_len: amount of unconditioned data to fetch in bytes
+ * @cbuf: buffer for conditioned data
+ * @cbuf_len: amount of conditioned data to fetch in bytes
+ */
+static inline void cpacf_trng(uint8_t *ucbuf, unsigned long ucbuf_len,
+                              uint8_t *cbuf, unsigned long cbuf_len,
+                              unsigned long *cc)
+{
+    union register_pair u, c;
+
+    *cc = 0;
+    u.even = (unsigned long)ucbuf;
+    u.odd  = (unsigned long)ucbuf_len;
+    c.even = (unsigned long)cbuf;
+    c.odd  = (unsigned long)cbuf_len;
+    asm volatile (
+                  "     lghi    0,%[fc]\n"
+                  "0:   .insn   rre,%[opc] << 16,%[ucbuf],%[cbuf]\n"
+                  "     brc     1,0b\n"          /* handle partial completion */
+                  "     brc     8,2f\n"
+                  "     brc     4,1f\n"
+                  "     agsi    %[__cc],1\n"
+                  "1:   agsi    %[__cc],1\n"
+                  "2:\n"
+                  : [ucbuf] "+&d" (u.pair), [cbuf] "+&d" (c.pair),
+                    [__cc] "+Q" (*cc)
+                  : [fc] "K" (CPACF_PRNO_TRNG), [opc] "i" (CPACF_PRNO)
+                  : "cc", "memory", "0");
+}
+
+/**
+ * cpacf_pcc() - executes the PCC instruction
+ * @func: the function code passed to PCC; see CPACF_KM_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ */
+static inline void cpacf_pcc(unsigned long func, void *param, unsigned long *cc)
+{
+    *cc = 0;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,0,0\n" /* PCC opcode */
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_PCC)
+                 : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_pckmo() - executes the PCKMO instruction
+ * @func: the function code passed to PCKMO; see CPACF_PCKMO_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ */
+static inline void cpacf_pckmo(long func, void *param)
+{
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "      .insn   rre,%[opc] << 16,0,0\n" /* PCKMO opcode */
+                 :
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_PCKMO)
+                 : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_kma() - executes the KMA instruction
+ * @func: the function code passed to KMA; see CPACF_KMA_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ * @aad: address of additional authenticated data memory area
+ * @aad_len: length of aad operand in bytes
+ */
+static inline void cpacf_kma(unsigned long func, void *param, uint8_t *dest,
+                             const uint8_t *src, unsigned long src_len,
+                             const uint8_t *aad, unsigned long aad_len,
+                             unsigned long *cc)
+{
+    union register_pair d, s, a;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    a.even = (unsigned long)aad;
+    a.odd  = (unsigned long)aad_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
+                 "      brc     1,0b\n"         /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
+                   [aad] "+&d" (a.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMA)
+                 : "cc", "memory", "0", "1");
+}
+
+/**
+ * cpacf_kmf() - executes the KMF instruction
+ * @func: the function code passed to KMF; see CPACF_KMF_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, number of processed bytes for
+ * encryption/decryption funcs
+ */
+static inline int cpacf_kmf(unsigned long func, void *param,
+                            uint8_t *dest, const uint8_t *src, long src_len,
+                            unsigned long *cc)
+{
+    union register_pair d, s;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,%[dst],%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMF)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_kmo() - executes the KMO instruction
+ * @func: the function code passed to KMO; see CPACF_KMO_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, number of processed bytes for
+ * encryption/decryption funcs
+ */
+static inline int cpacf_kmo(unsigned long func, void *param,
+                            uint8_t *dest, const uint8_t *src, long src_len,
+                            unsigned long *cc)
+{
+    union register_pair d, s;
+
+    *cc = 0;
+    d.even = (unsigned long)dest;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,%[dst],%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KMO)
+                 : "cc", "memory", "0", "1");
+
+    return src_len - s.odd;
+}
+
+/**
+ * cpacf_kdsa() - executes the KDSA instruction
+ * @func: the function code passed to KDSA; see CPACF_KDSA_xxx defines
+ * @param: address of parameter block; see POP for details on each func
+ * @src: address of source memory area
+ * @src_len: length of src operand in bytes
+ *
+ * Returns 0 for the query func, otherwise the condition code is checked
+ * and 0 returned on cc 0, otherwise a value != 0 to indicate failure.
+ */
+static inline int cpacf_kdsa(unsigned long func, void *param,
+                             const uint8_t *src, long src_len,
+                             unsigned long *cc)
+{
+    union register_pair s;
+
+    *cc = 0;
+    s.even = (unsigned long)src;
+    s.odd  = (unsigned long)src_len;
+    asm volatile(
+                 "      lgr     0,%[fc]\n"
+                 "      lgr     1,%[pba]\n"
+                 "0:    .insn   rre,%[opc] << 16,0,%[src]\n"
+                 "      brc     1,0b\n" /* handle partial completion */
+                 "      brc     8,2f\n"
+                 "      brc     4,1f\n"
+                 "      agsi    %[__cc],1\n"
+                 "1:    agsi    %[__cc],1\n"
+                 "2:\n"
+                 : [src] "+&d" (s.pair), [__cc] "+Q" (*cc)
+                 : [fc] "d" (func), [pba] "d" ((unsigned long)param),
+                   [opc] "i" (CPACF_KDSA)
+                 : "cc", "memory", "0", "1");
+
+    return (int)(*cc != 0);
+}
+
+#endif  /* _S390_CPACF_H_ */
-- 
2.43.0

