Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8173D524D;
	Wed, 15 Apr 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243158; cv=none; b=PhOKnvibOLbYNRLBN4Z0ophS2t/E41dru63eJHBmfTGWoo9wdlpP9wgzakoVA/SLGbNiAy9vKyysMyixkXCUtiikaZX2UC2ni5++Jm9akulUQEN0zjijeiyOM58HJI1m9+GtZjpQVIz8/PQigOuINIWV5+Us0rxdXVfIBN3tNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243158; c=relaxed/simple;
	bh=fSLaOmt5HNv+se7/vqJxYbsLibxXxZtgt0hzFZd1MbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3iJ+4q4jJZKzoTwyeem2zWPGQt0kiau+rZlQti8MF9jyGQqIGkcYVe8MOxmIkSUEhz3KeSBahoDUEsjNIcRd60XdrNGyZlvCuQ8pl8vODXb+8Ws2nzJWqvuuKiziFRsn28AHyBUqx2hfep9Ej3iWD7wEZnaQD0Ycf8I4TFNg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sKt6jeYr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sKt6jeYr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4QiOh2130784;
	Wed, 15 Apr 2026 08:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GoNI+qDJk1X4FWJxz
	gTlopra1gsXK4UFpP9t7a619YE=; b=sKt6jeYrVlfeUird3imVQpcpR2MBJbEba
	tjEWevYqJccZ4eOp7v5e97I4SERL4948nqX/HP9MFskDsw0HrkcYzjNo+gSqUUXI
	WWA/cbbr9PZ1fV0fjxFIijP5FmHjj2Fl0NZ5vBrgFWazDw/czav/bVlOb78112z8
	xmKXdBBOPPyYrvNuGwYLhd3THUoAKSksaAeaCuOrAZ+eCx7xRIlTXAOuyKzB+FEs
	0yWMsJEte/t16Pilnn8i7eXUWZ0qEaBOseP/qxwnMYwXzv2pFl84RVauI5NLIPQO
	XVryq6N5HkXIkuDv0qC0AAIDZXnNMmwCkiEMzdFdrKA1RZrjKiU9Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nf633-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F7stF9003610;
	Wed, 15 Apr 2026 08:52:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mndds2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qVcX50332032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ACAD20040;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DD052004E;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 1/5] lib: s390x: Add function to get page root
Date: Wed, 15 Apr 2026 08:45:41 +0000
Message-ID: <20260415085145.91197-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415085145.91197-1-frankja@linux.ibm.com>
References: <20260415085145.91197-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EBsRqebd9YqQ1wJUz1PWubZ8rwoilOQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfX/TDLnFvhQFY7
 At9OwybrifFw/3q9WOTnWnF2dG35OU5Lfch6a+EjxtkjjcYBKuH/4UBTH27TGKj62SJFtU8uRG9
 dmO9O8VQjWPktjTl8IqcHVTslEKtmiNEh+dAXjWz0swZKS04Wi9errFm063S680ud1kcIwJ467F
 Bxq1RgPqxY71zGaWTCpDZV6SVb2y0gyY1VHOGroWrmA4jxeHH/VUhJJQbKwGM3IbVIXLtRSwSzW
 THtn0A0KNJzCZbwdfZx8cf6sI1o5I1iTI2eHp5C/EUYwJp27jQz2k39feHr4HXoNzhKVN/4/pR2
 jZo+abJPzUydFsyR9yhl+gFsBFSNYLGD0MrRZfqfvMR5OSjh6cw7cPnfF07R2LC9d4uyefK9pJb
 g+e14s+IEZmcBk5QNKXx7rqDdQGa1AHF3cYdfk119NW7BGd158HQkapybaV0/Tf3WUMo2HdQR0d
 p3idqs1PpC1lkjd4miw==
X-Proofpoint-ORIG-GUID: EBsRqebd9YqQ1wJUz1PWubZ8rwoilOQP
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69df51d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=nJ3R9p0tC0mFShMZQ2QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150080

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
index dadc2e60..6ba19d28 100644
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
 
+static inline pgd_t *get_page_root(void)
+{
+	return (pgd_t *)(stctg(1) & PAGE_MASK);
+}
+
 #endif /* _ASMS390X_MMU_H_ */
diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 0fa915cf..a397400b 100644
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
+	root = get_page_root();
 
 	/*
 	 * Start of guest memory in host virtual space needs to be aligned to
diff --git a/s390x/diag258.c b/s390x/diag258.c
index 8ba75a72..bbcb92db 100644
--- a/s390x/diag258.c
+++ b/s390x/diag258.c
@@ -82,7 +82,7 @@ static void test_priv(void)
 
 static void *page_map_outside_real_space(phys_addr_t page_real)
 {
-	pgd_t *root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	pgd_t *root = get_page_root();
 	void *vaddr = alloc_vpage();
 
 	install_page(root, page_real, vaddr);
@@ -109,7 +109,7 @@ static void test_refbk_real(void)
 	refbk_page = alloc_page();
 
 	/* Map refblk page outside of physical memory identity mapping */
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_page_root();
 	refbk = page_map_outside_real_space(virt_to_pte_phys(root, refbk_page));
 
 	/* Assert the mapping really is outside identity mapping */
diff --git a/s390x/edat.c b/s390x/edat.c
index 89b9c2d3..c6a8021a 100644
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
+	root = get_page_root();
 
 	/*
 	 * Get a pgd worth of virtual memory, so we can test things later
diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
index 893de2cf..8666d554 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -89,7 +89,7 @@ static void setup_guest(void)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_page_root();
 
 	snippet_setup_guest(&vm, false);
 	snippet_init(&vm, SNIPPET_NAME_START(c, mvpg_snippet),
diff --git a/s390x/pv-edat1.c b/s390x/pv-edat1.c
index 6acfe6c4..43b3bd4c 100644
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
+	root = get_page_root();
 	ctl_set_bit(0, CTL0_EDAT);
 
 	guest_memory = alloc_pages(GUEST_ORDER - PAGE_SHIFT);
diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
index 44bf29fe..18b536d1 100644
--- a/s390x/sie-dat.c
+++ b/s390x/sie-dat.c
@@ -69,7 +69,7 @@ static void setup_guest(void)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_page_root();
 
 	snippet_setup_guest(&vm, false);
 
diff --git a/s390x/skey.c b/s390x/skey.c
index 7c7a8090..0aa4b6c6 100644
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
+	pgd_t *root = get_page_root();
 
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
+	pgd_t *root = get_page_root();
 	int cc;
 
 	report_prefix_push("MSCH");
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
 	test_device_sid = css_enumerate();
 
 	if (!(test_device_sid & SCHID_ONE)) {
-- 
2.51.0

