Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84F3B42FC;
	Thu, 16 Jul 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211286; cv=none; b=XJ9Sj1umPEh7XoUx+rf9ZbixIY6pVt22ocZXolBXLkyWt2Lq5etn8IX3S4tcMQ1tZjt3BnqdUndymED5j1JcCL6Cgvh3hPe9v7yatxSTeGDR9gh5A4Oldx8AjrYSHyVpjQbf6aWwHQ5KxZQxLVOj+bFfXyePomop3bwd6Kid5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211286; c=relaxed/simple;
	bh=oZMmz6gpZvD2VSU0b6SYwJ+ts7SFwTQpeBpXWTNWIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIu7W5pBQdqYH44MaMgEJPwp7MJRQw8UoKo9Rgm3kceiPOYJyeRfhugD6LYymN+GSmzA2MFzosh1jyj1EiepXgWc18v3iFjHYxt9elmJJkH0x5jfz685Q1R6PuJRAj2arLbjxRogSaKFoNvQkNuFYUqjq2aHPh6xDS4TDjmXpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YpqjkTHs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YpqjkTHs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfq6h3348558;
	Thu, 16 Jul 2026 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9+BXuSx1nCdpphzaQ
	166WI2QTJ1wpTqyqqQIzTUH6B8=; b=YpqjkTHstiXi+aHD9KRnIjV9O+Ftx7ZR5
	Zsau0gRJtO0GuUFPPPyRopkdeXSGWrwDIzqZ+bEW0uk/Pbr92Btz8VdokkDWh2QZ
	sQSlyOrbFm/xjFqMjeaXqFS7LvQGfekDaCWmubUP9vgfDg5d91qL2+xhOxvaVpX6
	NfBObeADuV6CM5OY8vYY+8N28qwu+bxYZV0q6t3Vgbdo0VdbMaWtwqikXiC5aqGU
	ezjgn8u97hUJOaThk0l9Twd5sgimzD0ozT0WAnL4JF0PYvNtvh5yNLlzjSHSqMmj
	sEgT0nkdNanfHNNui5GCuOVKI3WBgdRm8bjwmYB4mtkgHoXvMzfLQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc0hkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GE4YUb017874;
	Thu, 16 Jul 2026 14:14:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdhv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GEEbjI49414630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 14:14:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B97B20043;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22FB12004D;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
Date: Thu, 16 Jul 2026 16:14:33 +0200
Message-ID: <20260716141436.2125703-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716141436.2125703-1-hca@linux.ibm.com>
References: <20260716141436.2125703-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58e751 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=P87cTALPzO2HOiDMc2MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX9bZTvNgVTG8q
 7RZjA0Fydb6fJ1GSMrPP/gVijynmweacI1Y0q+y6JIaQh7D6dWQqf0slX61cVX0KuPx+rBVFW7p
 qukGwAXBrJtvpsWGt0vn8H7hx/uCtIeXd1J0qawHrsfQKlMwiycHiUsp9RNcs0aOmHIddZ+XYM3
 RL/HFuJXGEheyfCyM1mQWKuOiGsrhS3WeG+pwSIlLFXZuUJ4FPOhMztPsXFm4+YHXRwnrmBbC6I
 mW0/2rBYx5yXEzsJRzN4/pWQRzLQ47pqtF/irwuUli8791IgL1tr8DfxasD6o9Rp7dUF3ofPJj2
 FdE2MMY9+jNmOu/IQ7ptUUrqrgq3G5jDD/eTLjSERJYqG9rx37cYcVSWq0ODmdjrN8rDBfdOGfR
 BNShbNSzAwvhr1+tYX0Dg46sK9MI+PktdYrji82yLmXuv+9tKc28gxiEXO69GOyOWnLgplq+AHF
 939WMt68QcmqyUfBfvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfXyEAZKbta7sOI
 aJF9YEI4wOZtOCoVRkNdImEqTj6kI8Q0+Aq1P0Dq/3azcQ1babOQzko11rQA+Z4V6o+rCZqrZai
 TmKgkTVayZ7dSvfWrL3PCIlnOjKUFDo=
X-Proofpoint-GUID: oUjZppr6snkjGMylRf9G11OhUKEVsNTm
X-Proofpoint-ORIG-GUID: oUjZppr6snkjGMylRf9G11OhUKEVsNTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160146

The guest variable storage area is allocated with vmalloc and then
donated to the ultravisor. Any kernel access to that area will result
in a secure storage access exception (aka fault).

This is a problem if such a memory area is read via /proc/kcore. This
causes an exception via vread_iter() and results in an unexpected short
read. Avoid this by allocating a custom VM_SPARSE area. If such an area
is read, vread_iter() returns zeroes for the entire area.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  2 ++
 arch/s390/kernel/uv.c      | 59 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/pv.c         |  6 ++--
 3 files changed, 64 insertions(+), 3 deletions(-)

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
index a284f98d9716..98a7f988fc69 100644
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
@@ -209,6 +210,64 @@ int uv_convert_from_secure_pte(pte_t pte)
 	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
 }
 
+static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
+{
+	pte_t pte = ptep_get(ptep);
+
+	if (!pte_present(pte))
+		return 0;
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

