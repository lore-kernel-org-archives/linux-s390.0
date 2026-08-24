Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F243BDC7;
	Mon, 24 Aug 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582305; cv=none; b=TQizsJkfS1p6dOgZNgmPVqmafPIVJAF7tV7GkViw32vRyb7bQ5QwDWz6WngNe+M23w1AQN45Nhx94t2dEUlBGgvcXgqbAC0J31yDvT97pbJe5gqN2q//kxP8B89miibIJN9+vB62QHWi/LDjTKKGi4y9obsCM8BYGF6vxlx5Bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582305; c=relaxed/simple;
	bh=oCHVOcHGnkjGq7Ymkj0YeQD/an+9oPJzt55tc7WRCLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Py/g10Q3eUmqxMRziRv4KyYAM+1FHcNSki9KuyeV837V3JpEBIPSXL+W7GFPVshGKEBwGs+bmG4ug2DJgJnV7TrP1x1yGFABknfrxZkxmMCiMYlKk6ZFGyASGnTRL5uORB2MGsPyjOIDi9OQq+aCyPTyxamXMEdZ9x+4tqShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dPbbmaqj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPbbmaqj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1WeJ1935720;
	Mon, 24 Aug 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u9t2ZGoQ119WDDyk/
	jQ90IhZnl5+ZzXPB/2U9YH9pp8=; b=dPbbmaqje+abLsA6O2rf0ND5eQTAUmo4+
	IHF9eI/65h0F61ei1ShibwmVtfg7TWnnXGVeu3450Q3k0E9RagDb8E/JMpuOWSd5
	7rMR6auHrzj/vYMpj8rF6cyp4ez9rRZs4w7R71Z0GQMt0bBjoL4Iz+0rp6zh7qIc
	meYizxToaz0gB+5gqNWjh0B3zfVk1D1iMO1MW2oGmnTDx8h50dD0KR5zzc8R94H/
	6OauFJwv1Ah2wIGrsaMPJ3u79k0ozs+xpI92JxvYVRuiWM2qAH96To841zALHpRy
	fAuYUKi4GxC1Js4zS4Z8aspWi85kaZ4N+qiLdFSQ+zMZ04FGQMr7A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t1pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGaQ029418;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pxqvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcF3s51642764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A692120043;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D512004D;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 01/13] lib: s390x: Add function to get page root
Date: Mon, 24 Aug 2026 14:35:33 +0000
Message-ID: <20260824143740.291583-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vyUhKlKoCAQtCbEvmPQrVdRcNykGnpfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX3qvqKmKcTQkh
 JvbPOzMpCJzxN8vUGoYfUQm1ergyqjR/2BpxUbK+HsDhpeS81Xuq7fp1DGCL2/FZxocd40vx1mw
 d4m4EqLkkl9AZJYf+hq1lYnGSL51LMK7pAUOiOi8cCoMPg0UQaGC4zw83vDdJpZAPCNLmmWkVFy
 MWp7OUfAVDPQtlTQC4dKNfMGKqwFSUZKzthHy1fPTEDNqUfSEOS4BRaA90NNLdfQ/XrhmsuyM+B
 ASaAevpZpZf9ZGlzjXNuHPsNCsMi4l5RfAtK/XYCk9JcWS7lLjRImUzGTt8cvQEdXBFinkfoqni
 /mTKSgvULSoQ84U2v7/21C0ug9cbmpbaTPU1TvwmV151jw4Sqb8YJf2K8v+jrJk6UJZqDOV2ORe
 JAYhqK50dJaggkxayG3EZnRV95cVV0mb/j7mboyvK20vAdwGM00NPRmWZtYYQrVwS6qtxFsOTtq
 InNx1huue5Q1oLA2mBQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c575c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-eLhfyT9y63U-S5-WDMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX6+3f+2YP0+6c
 EQ3KdbWJFxgSN7W89FzyUwIG35x+HS+LPFasmJjQ6eA5YXkQynEaBiEJuuYNqfRsMA9rnAjfW+6
 7zijBaIk73VydbUOhlrtTrnyGaM7xD8=
X-Proofpoint-ORIG-GUID: vyUhKlKoCAQtCbEvmPQrVdRcNykGnpfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

It's time to hide the access to cr1 behind a function and add typing
to the tests that used void* instead of pgdt_t*.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/mmu.h  | 7 +++++++
 lib/s390x/sie.c  | 3 ++-
 s390x/diag258.c  | 4 ++--
 s390x/edat.c     | 5 +++--
 s390x/mvpg-sie.c | 2 +-
 s390x/sie-dat.c  | 2 +-
 s390x/skey.c     | 7 +++----
 7 files changed, 19 insertions(+), 11 deletions(-)

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
index d182b49a..920dee29 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -88,7 +88,7 @@ static void setup_guest(void)
 	pgd_t *root;
 
 	setup_vm();
-	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+	root = get_primary_page_root();
 
 	snippet_setup_guest(&vm, false);
 	snippet_init(&vm, SNIPPET_NAME_START(c, mvpg_snippet),
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
2.53.0

