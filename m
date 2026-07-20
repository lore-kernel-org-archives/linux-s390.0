Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E233D3309;
	Mon, 20 Jul 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537931; cv=none; b=gW1rgn65CbFrQ8sl4EuAXOb6Cs/6m2YeOcMcpS4Y3Lry6MfuCJdyUYmh2zP/uPG1QNyQU+wljefrL9sxxF+ckktE5nlTjm2WM09E2Cg+XoHl4UQkhwSwvpr053nK11MM7UukdOPC+BNNjJiB08dKvrdZDeIn7WlEpAZlzXEoNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537931; c=relaxed/simple;
	bh=x8LRonAOeThlNJvvK2i/qfi2Ll5J9XL/z/7Sty4mpuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0i5a6LT10LzuLphU3nPcU1xeF42t3uTfql105iDGM4IkSgBfoHwem5dE3HnUvy2huylErsoWmIvcUIR/vwzANld1RZSqO5n7WHD9rdqEZo+le13gGteSHKn2uTM9VUaYZ7pLaxzhqbaYYs1x4/xh6B2EsLqkaRuW4Re8WNLZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ptgvocD7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ptgvocD7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fq2S1381624;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uJziLZN99LngpXCT7
	oNphGPip9PC0fXobZ3zOHqrZlc=; b=ptgvocD7nhn4HdLue1l53tkTo5O4eHrx1
	20W8APCqU+/vK8Q8f14dR6DTLMl7ft4G/ipCzbiFHuytF7NTSMbxkO6eFlgJBfmg
	0Fm4Wdt6Y9nxbKVNBeCjy6O7b3W1e9thZA5G7EF2UdGGKbu5H2RF97HGh0n9dO8/
	O+uvQDU0mTscMSelCzFm9crveNg4kBXqncrlWgNMNdXhuvbS00FLXuXpfv1hzBid
	KKkL0hixtbA6nYdkEU6+Odbs1MosPHy6WFngz2BrsPtLu4v/0RSICFOdIs/rUqO5
	yl1BAg7rIcDEkcXguzntwtNiLO31dTYjqJCUOhRl5aUECyGrE8OaQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jxd02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8YfdL030001;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpw0h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZY053018958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B63420040;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 087A92004E;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
Date: Mon, 20 Jul 2026 10:58:27 +0200
Message-ID: <20260720085834.898025-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CGB7rVRhuG4dzmKA8wAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4tl8s//KLyTd
 PS+5wnZ+Y+xcxn3f5V6cuLzSfSFRwYaSNS/egQte3Ajx4jFeiqraFVrr2QiIGJnEZU8oBxyrpPB
 y8ep/mczl2LXqSVxSNBdAYZ72xi157IBExlelZ92fmZnNA+AE5cq+tpoy8y5Xn8HT4RVfquDI/K
 oATNTA0bufTBYM9ECf9uyDK/hGNjfND1MNHUB2zG18BBwHtWZRZGicSdN6qqzMEHu53RXWAtScc
 cherIHG+X+3fRmBn5+YMrlXxgCq3UYKF8tdHzpn06yyweR9os/KlEzlhdZnksbguIh5wvh0oswS
 dYsm5TDFa1xRkzlmCUnwR3qW8qo3Wx7pBUi5Kg07KaFUOZX9KzDYAsHfcHeCC+t6dU0GANAzvf3
 4nA9ZFmFEG5CZ867XPxDxeJX7Hj9N2qiZ2DJ5+xV43egqy3lkAqSlZNt21T4ZI8GyEGRyrdJN31
 7s/eZx+rBnWnBxf8rvw==
X-Proofpoint-ORIG-GUID: -S37DKE_Uy8BRsi6Nmb8Y9W-HajXkfnP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX+Thkimt62m4k
 9heT6rTy+5VB1UhsWMCkwXQr4AforcqR0iqbx36VKc5/qSW1aanAXk2o+Unei/N+8NMs2AJj1bQ
 8aFvFH4Q9jbnoyC0GVP+Vte/5skoCDI=
X-Proofpoint-GUID: -S37DKE_Uy8BRsi6Nmb8Y9W-HajXkfnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096

The guest variable storage area is allocated with vmalloc and then
donated to the ultravisor. Any kernel access to that area will result
in a secure storage access exception (aka fault).

This is a problem if such a memory area is read via /proc/kcore. This
causes an exception via vread_iter() and results in an unexpected short
read. Avoid this by allocating a custom VM_SPARSE area. If such an area
is read, vread_iter() returns zeroes for the entire area.

Note that the function which frees the area does not update ptes. This
is intentional to allow for deferred / lazy pte updates and TLB flushing
like the generic vfree() code is doing that. See vunmap_pte_range().

This assumes that s390 will gain full support for lazy_mmu_mode_enable()
and lazy_mmu_mode_disable() in the future, since as of now the used
ptep_get_and_clear() in vunmap_pte_range() does indeed invalidate and
flush every single pte entry, but only for s390.

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  2 ++
 arch/s390/kernel/uv.c      | 65 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/pv.c         |  6 ++--
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index d919e69662f5..153fed63adda 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -635,6 +635,8 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio);
 int __make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb);
 int uv_convert_from_secure(unsigned long paddr);
 int uv_convert_from_secure_folio(struct folio *folio);
+void *uv_alloc_stor_var(unsigned long size);
+void uv_free_stor_var(void *stor_var);
 
 void setup_uv(void);
 
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a284f98d9716..d1cdc5ae5e27 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -16,6 +16,7 @@
 #include <linux/swap.h>
 #include <linux/pagewalk.h>
 #include <linux/backing-dev.h>
+#include <linux/vmalloc.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
 #include <asm/uv.h>
@@ -209,6 +210,70 @@ int uv_convert_from_secure_pte(pte_t pte)
 	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
 }
 
+static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
+{
+	pte_t pte = ptep_get(ptep);
+
+	if (!pte_present(pte))
+		return 0;
+	/*
+	 * Note: do not update the pte here, since there is no code which
+	 * accesses the memory range, besides bugs. The invalidation of ptes
+	 * and TLB flushing is deferred like for regular vfree() calls.
+	 */
+	__free_page(pte_page(pte));
+	return 0;
+}
+
+void uv_free_stor_var(void *stor_var)
+{
+	unsigned long addr, size;
+	struct vm_struct *area;
+
+	if (!stor_var)
+		return;
+	area = find_vm_area(stor_var);
+	if (WARN_ON_ONCE(!area || !(area->flags & VM_SPARSE)))
+		return;
+	size = get_vm_area_size(area);
+	addr = (unsigned long)area->addr;
+	apply_to_existing_page_range(&init_mm, addr, size, uv_free_range_cb, NULL);
+	free_vm_area(area);
+}
+EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
+
+static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
+{
+	struct page *page;
+	pte_t pte;
+
+	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
+	set_pte(ptep, pte);
+	return 0;
+}
+
+void *uv_alloc_stor_var(unsigned long size)
+{
+	struct vm_struct *area;
+	unsigned long addr;
+
+	size = PAGE_ALIGN(size);
+	area = get_vm_area(size, VM_SPARSE);
+	if (!area)
+		return NULL;
+	addr = (unsigned long)area->addr;
+	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
+		goto out;
+	return area->addr;
+out:
+	uv_free_stor_var(area->addr);
+	return NULL;
+}
+EXPORT_SYMBOL_FOR_MODULES(uv_alloc_stor_var, "kvm");
+
 /*
  * Calculate the expected ref_count for a folio that would otherwise have no
  * further pins. This was cribbed from similar functions in other places in
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc5ac29b4c31 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -337,7 +337,7 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 /* only free resources when the destroy was successful */
 static void kvm_s390_pv_dealloc_vm(struct kvm *kvm)
 {
-	vfree(kvm->arch.pv.stor_var);
+	uv_free_stor_var(kvm->arch.pv.stor_var);
 	free_pages(kvm->arch.pv.stor_base,
 		   get_order(uv_info.guest_base_stor_len));
 	kvm_s390_clear_pv_state(kvm);
@@ -369,7 +369,7 @@ static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
 	/* Allocate variable storage */
 	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
 	vlen += uv_info.guest_virt_base_stor_len;
-	kvm->arch.pv.stor_var = vzalloc(vlen);
+	kvm->arch.pv.stor_var = uv_alloc_stor_var(vlen);
 	if (!kvm->arch.pv.stor_var)
 		goto out_err;
 	return 0;
@@ -414,7 +414,7 @@ static int kvm_s390_pv_dispose_one_leftover(struct kvm *kvm,
 	 */
 	free_pages(leftover->stor_base, get_order(uv_info.guest_base_stor_len));
 	free_pages(leftover->old_gmap_table, CRST_ALLOC_ORDER);
-	vfree(leftover->stor_var);
+	uv_free_stor_var(leftover->stor_var);
 done_fast:
 	atomic_dec(&kvm->mm->context.protected_count);
 	return 0;
-- 
2.53.0

