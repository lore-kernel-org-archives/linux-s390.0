Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075438A733;
	Mon, 20 Apr 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674988; cv=none; b=B0NGZ6SxkgKvdaiA+TdDBDK8CULIiOw1my4uN8QNpDriARu3a/7jpxh2Kv09wWAeNPQQ7WNwvzcRggJkxOns1CORevX6nO9kL3TQSzj80QKuECWTDw6AEJUkBVofjraDlk6CFxG0ung+a4guay+FVYkRRrbUEG+Y7gmrc1PrTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674988; c=relaxed/simple;
	bh=A+rDZU1OTnj/Xb0uMr0u/2j5ZhxiiS603Y50RhI6oeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a265VQEFVoYcdtz7lqI7e1mENtXG4ssTbZ/4gv0B9JBMuCoWqtXDdR8xARRKKsEF1kVVgPi7QVy1SjjCyry8beFCbU4FS7cSMXFFPKjOia2YBnXKcgW4kctVLuMG1YvOBGtWQdY8mQYPg0JT1juxE1g+5H/B5YGmSY0AvjD4fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MAcfRGEN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MAcfRGEN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JFEiic2320504;
	Mon, 20 Apr 2026 08:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jKLOM5boPFvFaFBgT
	hW/0eeWVQJ3yXXrt9K3dcyzX7Q=; b=MAcfRGENniR3/djLHGRODo4aOEK2BdDZa
	X1xCoV9/3HThDgmRxNrlBuKWs52hhqh4708Uy3Zd4OCUnNC7zrNog+L8HY2OSP2A
	O58jznwSyLMhpHeHurJZJSORe1V5m4UpQA2l6Hj/1UNh8j8JvYkL5zcw1BXHo9jq
	2hDdL8HVTq7SGqx6QHUHO/YHEyAoJo0D3vFGu+8+MsRF/tn3Lxxhj0/V0DbIfvaf
	LUTKi11BhfDz5mKkUuvN4yLJ9JEDlj0R5D1wyKbsJqyCaRMvXVkbkpR9v5Jlqhuk
	fs0/1/P6T+DeGA0DFCr6U8dgmrVriNpjxMZkKoKEjfX04nvE0KviQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6eap3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K8ZLmm012591;
	Mon, 20 Apr 2026 08:49:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvm4re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K8nfRw25559300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:49:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E19A22004D;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BEC2004F;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 1/4] lib: s390x: Add function to get page root
Date: Mon, 20 Apr 2026 08:44:22 +0000
Message-ID: <20260420084933.251244-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260420084933.251244-1-frankja@linux.ibm.com>
References: <20260420084933.251244-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e5e8a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nJ3R9p0tC0mFShMZQ2QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NCBTYWx0ZWRfX+XghmNE4Ey1e
 tEu195vJRkmj+FIlL54ITgKZFghWZu/2tSCgaxqiP+dUzVlbP/MehxccWyisYVnhflKvtWozDdL
 2CorGFZ1Fu0AVO+ZnCrhdwWTlL+HmD3ifEghozEjnzoCuKr0uxVis9CsVNH/L+7dvpiS2oH/K5Z
 LuLRapKOF701ktGdH/zdbS5Wow2HDYFO7//cIPOApGde3JDDdqxoHw7l0kGM4ccUdh9zoUUYQBh
 OA6/FATiw+c0XD6T8QE/yvZMD9Vv6A82o72k9ls9Regxylr0SQzO02srr49wPW883Pg0bSAscDm
 fK4jg7/ru9hTOwHEotOBA/uN+js7tns87dR2v2RyPU89CxNG16OBn3FS3+JGG49ot6HfEdekOXN
 J9udBE7dO0bBDI5lvbO8jTIvXenR8GXL6n1YiJH9Jdo9PzCV4TwJkWnqF9urlwpcq7bn3k/HBCv
 KZ+Fh6o+HyCJI+2oJ/g==
X-Proofpoint-GUID: -aKBJI-WIztk-hU27sXGpq-ymk_WGfkQ
X-Proofpoint-ORIG-GUID: -aKBJI-WIztk-hU27sXGpq-ymk_WGfkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200084

It's time to hide the access to cr1 behind a function and add typing
to the tests that used void* instead of pgdt_t*.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/mmu.h  | 7 +++++++
 lib/s390x/sie.c  | 3 ++-
 s390x/diag258.c  | 4 ++--
 s390x/edat.c     | 5 +++--
 s390x/mvpg-sie.c | 2 +-
 s390x/pv-edat1.c | 4 ++--
 s390x/sie-dat.c  | 2 +-
 s390x/skey.c     | 7 +++----
 8 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/lib/s390x/mmu.h b/lib/s390x/mmu.h
index dadc2e60..19c46c58 100644
--- a/lib/s390x/mmu.h
+++ b/lib/s390x/mmu.h
@@ -10,6 +10,8 @@
 #ifndef _S390X_MMU_H_
 #define _S390X_MMU_H_
 
+#include <asm/arch_def.h>
+
 enum pgt_level {
 	pgtable_level_pgd = 1,
 	pgtable_level_p4d,
@@ -95,4 +97,9 @@ static inline void unprotect_page(void *vaddr, unsigned long prot)
 
 void *get_dat_entry(pgd_t *pgtable, void *vaddr, enum pgt_level level);
 
+static inline pgd_t *get_primary_page_root(void)
+{
+	return (pgd_t *)(stctg(1) & PAGE_MASK);
+}
+
 #endif /* _ASMS390X_MMU_H_ */
diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 0fa915cf..47d4cdde 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -17,6 +17,7 @@
 #include <alloc_page.h>
 #include <vmalloc.h>
 #include <sclp.h>
+#include <mmu.h>
 
 void sie_expect_validity(struct vm *vm)
 {
@@ -156,7 +157,7 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 
 	/*
 	 * Start of guest memory in host virtual space needs to be aligned to
diff --git a/s390x/diag258.c b/s390x/diag258.c
index 8ba75a72..2482ecf3 100644
--- a/s390x/diag258.c
+++ b/s390x/diag258.c
@@ -82,7 +82,7 @@ static void test_priv(void)
 
 static void *page_map_outside_real_space(phys_addr_t page_real)
 {
-	pgd_t *root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	pgd_t *root = get_primary_page_root();
 	void *vaddr = alloc_vpage();
 
 	install_page(root, page_real, vaddr);
@@ -109,7 +109,7 @@ static void test_refbk_real(void)
 	refbk_page = alloc_page();
 
 	/* Map refblk page outside of physical memory identity mapping */
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 	refbk = page_map_outside_real_space(virt_to_pte_phys(root, refbk_page));
 
 	/* Assert the mapping really is outside identity mapping */
diff --git a/s390x/edat.c b/s390x/edat.c
index 89b9c2d3..e54cd642 100644
--- a/s390x/edat.c
+++ b/s390x/edat.c
@@ -21,7 +21,8 @@
 
 static uint8_t prefix_buf[LC_SIZE] __attribute__((aligned(LC_SIZE)));
 static unsigned int tmp[1024] __attribute__((aligned(PAGE_SIZE)));
-static void *root, *mem, *m;
+static void *mem, *m;
+static pgd_t *root;
 volatile unsigned int *p;
 
 /*
@@ -237,7 +238,7 @@ static unsigned int setup(void)
 
 	/* Setup DAT 1:1 mapping and memory management */
 	setup_vm();
-	root = (void *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 
 	/*
 	 * Get a pgd worth of virtual memory, so we can test things later
diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
index 893de2cf..3050a8bb 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -89,7 +89,7 @@ static void setup_guest(void)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 
 	snippet_setup_guest(&vm, false);
 	snippet_init(&vm, SNIPPET_NAME_START(c, mvpg_snippet),
diff --git a/s390x/pv-edat1.c b/s390x/pv-edat1.c
index 6acfe6c4..e423f2fc 100644
--- a/s390x/pv-edat1.c
+++ b/s390x/pv-edat1.c
@@ -34,7 +34,7 @@
 #define PARAM(n, step)	(((unsigned long)(n) << 32) | (step))
 
 static struct vm vm;
-static void *root;
+static pgd_t *root;
 
 extern const char SNIPPET_NAME_START(c, pv_memhog)[];
 extern const char SNIPPET_NAME_END(c, pv_memhog)[];
@@ -441,7 +441,7 @@ static void init(void)
 
 	setup_vm();
 
-	root = (void *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 	ctl_set_bit(0, CTL0_EDAT);
 
 	guest_memory = alloc_pages(GUEST_ORDER - PAGE_SHIFT);
diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
index 44bf29fe..e40e348f 100644
--- a/s390x/sie-dat.c
+++ b/s390x/sie-dat.c
@@ -69,7 +69,7 @@ static void setup_guest(void)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 
 	snippet_setup_guest(&vm, false);
 
diff --git a/s390x/skey.c b/s390x/skey.c
index 7c7a8090..bb769730 100644
--- a/s390x/skey.c
+++ b/s390x/skey.c
@@ -13,6 +13,7 @@
 #include <asm/interrupt.h>
 #include <vmalloc.h>
 #include <css.h>
+#include <mmu.h>
 #include <asm/page.h>
 #include <asm/facility.h>
 #include <asm/mem.h>
@@ -465,10 +466,9 @@ static void test_set_prefix(void)
 	uint32_t *prefix_ptr = (uint32_t *)pagebuf;
 	uint32_t *no_override_prefix_ptr;
 	uint32_t old_prefix;
-	pgd_t *root;
+	pgd_t *root = get_primary_page_root();
 
 	report_prefix_push("SET PREFIX");
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
 	old_prefix = get_prefix();
 	memcpy(lowcore_tmp, 0, sizeof(lowcore_tmp));
 	assert(((uint64_t)&lowcore_tmp >> 31) == 0);
@@ -583,11 +583,10 @@ static void test_msch(void)
 	struct schib *schib = (struct schib *)pagebuf;
 	struct schib *no_override_schib;
 	int test_device_sid;
-	pgd_t *root;
+	pgd_t *root = get_primary_page_root();
 	int cc;
 
 	report_prefix_push("MSCH");
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
 	test_device_sid = css_enumerate();
 
 	if (!(test_device_sid & SCHID_ONE)) {
-- 
2.51.0

