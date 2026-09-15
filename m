Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A5472F82;
	Tue, 15 Sep 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483402; cv=none; b=HPu45a8L3PPJxp156nlJO9UG4riHVkgEO7bpjXVz6SD7gTNN671uCtNRvjkhcM3vIW5qzzMwx/NvgaChifjB81c65ianxen0Vpb4Nz2IXa3g4tkFOlLzNEwExY1FH/0fB7WuvKoADSKyT4t4Z7/TV6HA1kC7jncGWtqh4YIJ+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483402; c=relaxed/simple;
	bh=01i9NyRL0wxg4jwjON7/nB9/x9bB+BcJKvkuubev2FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlXuFrg2ojO+HSL8kCCfnQ30YC4POEG10lb19ARt8VjpCJFBYUE2xSqfzoluglKl9L+6wd7kePdc9wvSlrUV7oGE7RclQDuhZVepq69mHpa4YMVToxoP8Cl6TEbR0DFSkyLSs5g4x1PvckQM2hFFdF3R2ARwZlr4V+MGizap2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olgcRH4p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olgcRH4p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1g4q3198540;
	Tue, 15 Sep 2026 14:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XGH/dfOu/zOl1pdx05euQPY4B/vZSuwXfxRzTZhkV
	y4=; b=olgcRH4pjuX/eb6fkxYQQOOZ2giNCmpxNR+3BJHHihYWX3ZuPb1L0abG7
	f8M5kqG6s82El2UAXveXlhK6jj76uafTvG3jghInhlHFGC+Mmbzl84dvpqmkw85q
	ZeMpXGerq5m2qMGJpHoqM2Tms944JgXtNxLYsMp/JRzQmAM6vLiSp5O6QtSvfk/+
	w/o/BIq/gvD8fMQhibp9Rf6NC9Av1EgZsBoFcIgN/hnpT1ezpwzx9vs4hGj2TC5c
	XBb6cnWDleAzBekYcIKIy47ch6VLJ1H6iQbAP87g0NmoFLAXGudUa8f6sTijDiaB
	FkFCG5/bf8xs33aSrNnpqRa0Te66w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq7kpv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 14:43:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD56AS3994895;
	Tue, 15 Sep 2026 14:43:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bsswm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 14:43:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FEh8M547251816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 14:43:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CBE2004D;
	Tue, 15 Sep 2026 14:43:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AAFF20043;
	Tue, 15 Sep 2026 14:43:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 14:43:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/uv: Rework page allocation for guest variable storage area
Date: Tue, 15 Sep 2026 16:43:07 +0200
Message-ID: <20260915144307.2367089-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxMiBTYWx0ZWRfXzWs64YC4UIW9
 22fRDHYZINLzhlrB4u6sIdUGB0UKSYycRj39mkRdjFA7lDSVzz+er1GlfvRg1W3yHyXSAkes95s
 VWwEQrTqjnPbnmbqIt1qyYx7AB8WojuiI+Z4+SqI8J+o2yvRxTob+WNza3ctXz+FgncEd3HfQkf
 L3YPfLJCO2aY4yE9WtRzacRyhH7W7ptSXLx0QC5mwWzT8XrOKmkDTIWSktmaYPQq1BJHbDbBPgQ
 m/4W7a6alUccnTGBMqO0Su+G0gqPwrANZRGpdDseotIcJhIp+MqY+ofDw4q54p6Dfrur4X7Bo94
 pSDdPAT7YqN5fHCdrbF7uRB03223tmLBFeXvYBSTHAJaZLHVZuMVe3zAVpf/bP8WK+xVlOgn3md
 PpmeXQxyZexOLjeH2JwE38aLkLtEoVgFjW2LDDU2RtZfb59vT5DEPUu7S8JCzLjviVBD/ZlFKIu
 yMLOdpCQINyO4dPgu2Q==
X-Proofpoint-GUID: LDqERbknEr98WpgudRfzRgxDf3EuklJQ
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa95981 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=a2nUC81R4oW2uoHz82gA:9
X-Proofpoint-ORIG-GUID: LDqERbknEr98WpgudRfzRgxDf3EuklJQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxMiBTYWx0ZWRfX5PRnlRAm3ug0
 JBEd2iY3SJIv2EBot1PYYmgXJ3EI+oBnQiPFk5yafH1Hl9f3ANY9hL+mcQUWhdKv0K5CDMt/i/m
 3wjuVMy/HF7baiveNRd2cbLpYjHtg/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150212

Alexander Gordeev reported that the allocation of pages of the
guest variable storage area via the uv_alloc_range_cb() callback
of apply_to_page_range() will cause problems as soon as s390 fully
supports lazy mmu mode.

Problem is that uv_alloc_range_cb() allocates pages with GFP_KERNEL while
preemption would be disabled. This would result in reports like this:

 BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:322
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6092, name: qemu-kvm
 preempt_count: 1, expected: 0
...
 Call Trace:
  dump_stack_lvl+0xae/0x108
  __might_resched+0x1de/0x2f0
  prepare_alloc_pages+0x1ba/0x220
  __alloc_frozen_pages_noprof+0xc6/0x390
  alloc_pages_mpol+0xe6/0x220
  alloc_frozen_pages_noprof+0x5c/0x80
  alloc_pages_noprof+0x22/0x80
  uv_alloc_range_cb+0x30/0x300
  apply_to_pte_range+0x11a/0x3b0
  apply_to_pmd_range+0x13a/0x250
  __apply_to_page_range+0x232/0x4d0
  apply_to_page_range+0x28/0x40
  uv_alloc_stor_var+0x5e/0x90
  kvm_s390_pv_alloc_vm+0x118/0x1e0 [kvm]
  kvm_s390_pv_init_vm+0x84/0x2e0 [kvm]
  kvm_s390_handle_pv+0x502/0xf70 [kvm]
  kvm_arch_vm_ioctl+0x234/0xdd0 [kvm]
  kvm_vm_ioctl+0x33a/0x890 [kvm]
  __s390x_sys_ioctl+0xfa/0x130
  __do_syscall+0x1fc/0x700
  system_call+0x72/0x90

Preallocate the pages and make use of vm_area_map_pages() to address this
potential future bug.

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Closes: https://lore.kernel.org/all/e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---

Notes:
    This is untested, and only based on the report from Alexander.

 arch/s390/kernel/uv.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index dc14ebc0105b..3a01fc69cc3a 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -16,6 +16,7 @@
 #include <linux/swap.h>
 #include <linux/pagewalk.h>
 #include <linux/backing-dev.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
@@ -242,34 +243,38 @@ void uv_free_stor_var(void *stor_var)
 }
 EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
 
-static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
-{
-	struct page *page;
-	pte_t pte;
-
-	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!page)
-		return -ENOMEM;
-	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
-	set_pte(ptep, pte);
-	return 0;
-}
-
 void *uv_alloc_stor_var(unsigned long size)
 {
+	unsigned long i, nr_pages, addr;
 	struct vm_struct *area;
-	unsigned long addr;
+	struct page **pages;
 
 	size = PAGE_ALIGN(size);
+	nr_pages = size >> PAGE_SHIFT;
 	area = get_vm_area(size, VM_SPARSE);
 	if (!area)
 		return NULL;
+	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		goto free_area;
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!pages[i])
+			goto free_pages;
+	}
 	addr = (unsigned long)area->addr;
-	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
-		goto out;
+	if (vm_area_map_pages(area, addr, addr + size, pages))
+		goto free_pages;
+	kvfree(pages);
 	return area->addr;
-out:
-	uv_free_stor_var(area->addr);
+free_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kvfree(pages);
+free_area:
+	free_vm_area(area);
 	return NULL;
 }
 EXPORT_SYMBOL_FOR_MODULES(uv_alloc_stor_var, "kvm");
-- 
2.53.0

