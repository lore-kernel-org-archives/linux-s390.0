Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DE47012F;
	Fri,  4 Sep 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548028; cv=none; b=hFhP8Eeqt0l/vc/lGpyWu4JC7NtRG4H56/uHKuqcKyVCCJBQY29dxrYnuC78hk/VSzTZlYTG5JBsMgcHyO2vOJMN+FachC7xQgcBUKLZg2e/VvhFx5YPwPdCMZEIGB/EXF81Lgwq+KZHHiEjbXCF2UqYYyCxIMFJ7LeqtUGAYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548028; c=relaxed/simple;
	bh=5WwT2se2C5BKcfWyQRgRRFTui6yDZ8Fy6f3eNRBaT+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQoI6+aMQMlfCfHbxp0HEvhLMGzDhclpBqp7UVxrDsJzgJ52dvUWMbOUMtjYC82dtZczzkFPjR4g4vxfkML4nS7gvThau6z2xIIjVSEN7ZJbdqDz53uqfrgbhcgcXANnBCVALwSL7keK4gfEKa/hluhuvFtwKBHHz3g+FPLypqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eZOXJo/Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eZOXJo/Q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HW8CC1236969;
	Fri, 4 Sep 2026 18:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=X1+Z8AI69TDyxVwJ/blHCjlvFDPkqi
	nfbKPZNACCHEc=; b=eZOXJo/Qz4qgOgP20grGq+eSFH9MdXlCqz7UftyGk1fkWY
	sQntgoG2M7mzZu63/YizGIgPCC4BK8WddeCXpSFuJI8aeF5KiOiqtUZRAZb4bYTx
	GoPBHUOsCLWWqjSCRlWVmAjcREljg/bHIuT7Nnai0zRQ0vHG0ao192AdJr/3gUf+
	BT00HnlFzu40/vyjD+k2ZoQV9eWtBPjVWWpRZO3h9NLjYo/cSZGnT+fc/z8Pc4g4
	MuykIOyJMGyAvnmHd9mG1kjC/tjRiqpWLZMkeWHmZ/wvPYwfb1u/qApLBYUu8vgS
	EhPpeK20AzcyC7cteNpjzW6poIBCdmOmW8qBdDuw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnuec5km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 18:53:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684IfIAX019507;
	Fri, 4 Sep 2026 18:53:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjay44s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 18:53:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684IrcqN30737140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 18:53:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5E920043;
	Fri,  4 Sep 2026 18:53:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A96220040;
	Fri,  4 Sep 2026 18:53:38 +0000 (GMT)
Received: from osiris (unknown [9.111.64.215])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 18:53:37 +0000 (GMT)
Date: Fri, 4 Sep 2026 20:53:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Message-ID: <20260904185336.35458Aff-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
 <e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com>
 <20260903172417.12158Bf0-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903172417.12158Bf0-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B8-sr14wvFmj_iXMjmFsbuZcb4vL5BuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE2OSBTYWx0ZWRfXyGzrPD2/PZ9r
 IhjIXwBrhICxqzg3Vrzh5cA0bzsb3UyqEukDVAExx9Ts+Md/pGXJ6lT+05SpyN/mMU+8IjFoJjc
 SAZgMnBwEX0mzSU2RfJNwfKMJdePxmRIxZ1h3tt1OrnbXdeOK9aGHcNFr+z29hUIeu9SPvwowpx
 K0uSp32SiVE/ACxHnmiafTa+qKz8l7hci0JOish2b+FfQhl5Az/e5XuxhS4VWWDWuzGvMgesy/y
 iOHHLyF1oYwH/vVOY/yG+HVmTbBo901aO5Ed3yNIFDeAxRvf6YNtF5nlxlVDJZ7Fuv7pltHvmmc
 PZNcntyQ7rUckTa5W4LyJsiMRKhOTxh6vLCZBDl0vJ0uzdDF9cvV//XwSH8B/6yrKf/IGj+zWHn
 Bw4dWt3IJF2oPzLk4Z84nkScteMsteRTT5pmWyndEuljyCLHs0C1eSZq9JxFe+DFTaxT+sF2E3Y
 OsZ9XLB3b95HXCe5iNQ==
X-Proofpoint-ORIG-GUID: B8-sr14wvFmj_iXMjmFsbuZcb4vL5BuM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE2OSBTYWx0ZWRfX4qp6e3oviYdb
 eN9aMiZhnLdq63eCw2Vup0cRtJirQpRX9nE60W5W+s5k1HXYLIMBZsI8cq+Hd9qlp36JT4iqk15
 c6ihRBf6RQUPIKenI+YOdI7NRB+vbsQ=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9b13b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VhaxTpYug_F9V7xzWmYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040169

On Thu, Sep 03, 2026 at 07:24:17PM +0200, Heiko Carstens wrote:
> On Thu, Sep 03, 2026 at 02:28:35PM +0200, Alexander Gordeev wrote:
> > On Mon, Jul 20, 2026 at 10:58:27AM +0200, Heiko Carstens wrote:
> > This could be solved using the below fixup:
> > 
> > @@ -247,7 +247,9 @@ static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> >  	struct page *page;
> >  	pte_t pte;
> >  
> > +	lazy_mmu_mode_pause();
> >  	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> > +	lazy_mmu_mode_resume();
> >  	if (!page)
> >  		return -ENOMEM;
> >  	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
> > 
> > The downside is lazy_mmu_mode_resume() does not really re-enable
> > the caching and the performance will stay the same even when the
> > lazy mode is supported on s390.
> > 
> > This is the same pattern as kasan_populate_vmalloc_pte() - which
> > was the only occurrence so far.
> > 
> > Alternatively, the page could be allocated atomically, but I think
> > that is less preferrable.
> 
> I guess the real fix is to pre-allocate all pages, keep the pointers
> to the struct pages in an array, and populate with a different
> mechanism. Similar like the vmalloc code is doing.
> I wanted to keep this code as simple as possible, but...

Actually addressing this makes the code even simpler.
Something like the below should do (untested).

---
 arch/s390/kernel/uv.c | 59 ++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 8ea9dd7704ff..8dea30a1166b 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -14,8 +14,8 @@
 #include <linux/memblock.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/pagewalk.h>
 #include <linux/backing-dev.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
@@ -210,62 +210,51 @@ int uv_convert_from_secure_pte(pte_t pte)
 	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
 }
 
-static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
-{
-	pte_t pte = ptep_get(ptep);
-
-	if (!pte_present(pte))
-		return 0;
-	/*
-	 * Note: do not update the pte here, since there is no code which
-	 * accesses the memory range, besides bugs. The invalidation of ptes
-	 * and TLB flushing is deferred like for regular vfree() calls.
-	 */
-	__free_page(pte_page(pte));
-	return 0;
-}
-
 void uv_free_stor_var(void *stor_var)
 {
-	unsigned long addr, size;
 	struct vm_struct *area;
+	unsigned long i;
 
 	if (!stor_var)
 		return;
 	area = find_vm_area(stor_var);
 	if (WARN_ON_ONCE(!area || !(area->flags & VM_SPARSE)))
 		return;
-	size = get_vm_area_size(area);
-	addr = (unsigned long)area->addr;
-	apply_to_existing_page_range(&init_mm, addr, size, uv_free_range_cb, NULL);
+	/*
+	 * Do not update PTEs. There is no code which accesses the memory
+	 * range, besides bugs. The invalidation of PTEs and TLB flushing
+	 * is deferred like for regular vfree() calls.
+	 */
+	for (i = 0; i < area->nr_pages; i++)
+		__free_page(area->pages[i]);
+	kvfree(area->pages);
+	area->pages = NULL;
 	free_vm_area(area);
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
 
 	size = PAGE_ALIGN(size);
+	nr_pages = size >> PAGE_SHIFT;
 	area = get_vm_area(size, VM_SPARSE);
 	if (!area)
 		return NULL;
 	addr = (unsigned long)area->addr;
-	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
+	area->pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!area->pages)
+		goto out;
+	for (i = 0; i < nr_pages; i++) {
+		area->nr_pages = i;
+		area->pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!area->pages[i])
+			goto out;
+	}
+	area->nr_pages = nr_pages;
+	if (vm_area_map_pages(area, addr, addr + size, area->pages))
 		goto out;
 	return area->addr;
 out:
-- 
2.53.0

