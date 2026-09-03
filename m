Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9024A387D;
	Thu,  3 Sep 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438527; cv=none; b=mYDl1PIeZwYu9XH+p6HVSw7yqrpBGdhUJIWWSSd2C+Su+WrhF22svJU28oF+CejnMHCGu/lEie9BBfqfvwyq/xspcV7+xbToMmEE0QjWgkZamasFV0VfYKzzli2bnYR2ziA1jZeAg83qZZeh2UvbwGCwlJngYqB/S5STf+u/ItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438527; c=relaxed/simple;
	bh=mxpFQ7Fku0XjRddYxhF3O5BmE/oiXOEJ35+NZFjBMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdqQ8NTuvnZnnA0xGji0YpcfvvCohsTC7JAOH0384D2ScDdemqPtv/Er67UcY68hUYDQXQKfVcd+1UgJsLiTCeSfwn1QQkw2yo2ZVeiIV88ZFWKC+szMMApV3L1CAvDVGnYm4rN/oXVlYsCWx0QHYmoyuWaUNp0pi4kxUSzjylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L0pPpjQ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L0pPpjQ+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVeEn2788680;
	Thu, 3 Sep 2026 12:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Tjig2EjrkegzTZQAgoCAYy9TfX09W8
	IbBPO777lKb3g=; b=L0pPpjQ+kvQeW1aWAf9xaiYx89nCCKA7LyjjZHQAWOB2AP
	NddjGHtVjZ8wyEKpjR/t9Fqmjqh8ZzuswjZCv5S5cKaSB72O1sLAblW0Um24Rwu7
	cvQVUWMQ76UHEaztICB1ViYRi/jrHcBP9Ut1KagSwhR2qwnD6guBQMzmqQ4OJesx
	LqtwmjNboM8tn2K/q5xJbFrMH7v938a8gUBrUo0AhTI8Iogf2NV2QinrlNp6Q1WF
	ChqijvZ7EfUw0KmyZI7wY9WwApHxSF7w4Z8N6nzg2yRgjCRXU8oRSr38D9n6RdAe
	zp09C0bz+L3dglLrRNaM56hFi/nQj2peHL2AgTyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tm6dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:28:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CQFr0004042;
	Thu, 3 Sep 2026 12:28:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygqem9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:28:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683CSb4c44171702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 12:28:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A5E2004D;
	Thu,  3 Sep 2026 12:28:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB76220043;
	Thu,  3 Sep 2026 12:28:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.85.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 12:28:36 +0000 (GMT)
Date: Thu, 3 Sep 2026 14:28:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Message-ID: <e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720085834.898025-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9967fa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=i5A-BJ900ua4diBeuZoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfXwT8BfzoTpEKQ
 HNtuYPfwMeHPwDuEV2VIneP+z4AoFhh3Io/H0MCI7/kzvsHq/ZahqfHqTOPbKw5itI3BJL1mK6Y
 v49zaii6nAOUlAH+xShblKtY/o6LQs8=
X-Proofpoint-ORIG-GUID: zIQ7rN4JDY_oicJfZhIn0p4srajAxBHh
X-Proofpoint-GUID: zIQ7rN4JDY_oicJfZhIn0p4srajAxBHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfXyqlO7cSwo/Gg
 P+nXJIA4Rewz7uijPOdxFfQxRIPP9KcNgwmvk3I6dvCXxupcT39sn7KtsVpQ8IZHdsjRQC9mE8p
 Ts6eBE3+pK9kezw8IHHUodWtYaLGGU3d7QDnWoF+i0mzCtlusG1I/lEEMWUZF6lnfWq94GpQKD8
 vRji2dGStAgJZHEf9KHdjvCaFk8YX6qEYKlT3JilRmIk9fD3XXVWRv/Y4mHrPuZ8PrmMsKm6aS8
 x3650SSzg73OdsFzukyaX4eCZyue9u4Dcyxo4hc6WAUI//KtHL5o8aTL7esVF5uSNOX3nSlrTLy
 RpBoFhkqLJh8zcStEPzuCqhNyJbR/HyUzMVkcjqewJGeiOAnhlUXyRV82LYuN16iR/nwmgYn4BX
 puJpqpONhz+Wjyv0ZYzxctaYli+M+ajvVULuhZ5Xc6jlUPI/qy3wT4vrpScRAswcNErrjBsaYJp
 DDUKkznhT0ImXZK4meQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030104

On Mon, Jul 20, 2026 at 10:58:27AM +0200, Heiko Carstens wrote:
...
> This assumes that s390 will gain full support for lazy_mmu_mode_enable()
> and lazy_mmu_mode_disable() in the future, since as of now the used
> ptep_get_and_clear() in vunmap_pte_range() does indeed invalidate and
> flush every single pte entry, but only for s390.
...
> +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct page *page;
> +	pte_t pte;
> +
> +	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

In lazy mode this callback is called with preemption disabled, so it leads to:

    [  138.709287] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:322
    [  138.709535] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6092, name: qemu-kvm
    [  138.709540] preempt_count: 1, expected: 0
    [  138.709545] RCU nest depth: 0, expected: 0
    [  138.709549] locks held by qemu-kvm/6092: 1, last CPU#1:
    [  138.709554]  #0: 00000162368b8ba8 (&kvm->lock){+.+.}-{3:3}, at: kvm_s390_handle_pv+0x7c/0xf70 [kvm]
    [  138.709612] Preemption disabled at:
    [  138.709614] [<000002690b609a76>] enter_ipte_range.part.0+0x36/0xb0
    [  138.709627] CPU: 1 UID: 107 PID: 6092 Comm: qemu-kvm Not tainted 7.3.0-20260901.rc1.git22.7cbe5e7f09fc.300.mm.fc44.s390x+debug #1 PREEMPT
    [  138.709629] Hardware name: IBM 3931 A01 701 (LPAR)
    [  138.709630] Call Trace:
    [  138.709631]  [<000002690b5d0d4e>] dump_stack_lvl+0xae/0x108
    [  138.709634]  [<000002690b67bbde>] __might_resched+0x1de/0x2f0
    [  138.709637]  [<000002690ba1d23a>] prepare_alloc_pages+0x1ba/0x220
    [  138.709641]  [<000002690ba1f936>] __alloc_frozen_pages_noprof+0xc6/0x390
    [  138.709643]  [<000002690ba6e9d6>] alloc_pages_mpol+0xe6/0x220
    [  138.709647]  [<000002690ba6f1dc>] alloc_frozen_pages_noprof+0x5c/0x80
    [  138.709649]  [<000002690ba6f222>] alloc_pages_noprof+0x22/0x80
    [  138.709652]  [<000002690b5ef6a0>] uv_alloc_range_cb+0x30/0x300
    [  138.709655]  [<000002690b9d22fa>] apply_to_pte_range+0x11a/0x3b0
    [  138.709656]  [<000002690b9dbf5a>] apply_to_pmd_range+0x13a/0x250
    [  138.709658]  [<000002690b9dcef2>] __apply_to_page_range+0x232/0x4d0
    [  138.709660]  [<000002690b9dd1b8>] apply_to_page_range+0x28/0x40
    [  138.709662]  [<000002690b5eebfe>] uv_alloc_stor_var+0x5e/0x90
    [  138.709664]  [<000002688b73ffe8>] kvm_s390_pv_alloc_vm+0x118/0x1e0 [kvm]
    [  138.709685]  [<000002688b741274>] kvm_s390_pv_init_vm+0x84/0x2e0 [kvm]
    [  138.709705]  [<000002688b71cf92>] kvm_s390_handle_pv+0x502/0xf70 [kvm]
    [  138.709726]  [<000002688b71fd44>] kvm_arch_vm_ioctl+0x234/0xdd0 [kvm]
    [  138.709747]  [<000002688b7070fa>] kvm_vm_ioctl+0x33a/0x890 [kvm]
    [  138.709765]  [<000002690bb046ca>] __s390x_sys_ioctl+0xfa/0x130
    [  138.709767]  [<000002690c78cffc>] __do_syscall+0x1fc/0x700
    [  138.709772]  [<000002690c7a21e2>] system_call+0x72/0x90
    [  138.709774] locks held by qemu-kvm/6092: 1, last CPU#1:
    [  138.709775]  #0: 00000162368b8ba8 (&kvm->lock){+.+.}-{3:3}, at: kvm_s390_handle_pv+0x7c/0xf70 [kvm]

This could be solved using the below fixup:

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 8ea9dd7704ff..9af0358aa7f2 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -247,7 +247,9 @@ static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
 	struct page *page;
 	pte_t pte;
 
+	lazy_mmu_mode_pause();
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	lazy_mmu_mode_resume();
 	if (!page)
 		return -ENOMEM;
 	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));

The downside is lazy_mmu_mode_resume() does not really re-enable
the caching and the performance will stay the same even when the
lazy mode is supported on s390.

This is the same pattern as kasan_populate_vmalloc_pte() - which
was the only occurrence so far.

Alternatively, the page could be allocated atomically, but I think
that is less preferrable.

> +	if (!page)
> +		return -ENOMEM;
> +	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
> +	set_pte(ptep, pte);
> +	return 0;
> +}
> +
> +void *uv_alloc_stor_var(unsigned long size)
> +{
> +	struct vm_struct *area;
> +	unsigned long addr;
> +
> +	size = PAGE_ALIGN(size);
> +	area = get_vm_area(size, VM_SPARSE);
> +	if (!area)
> +		return NULL;
> +	addr = (unsigned long)area->addr;
> +	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))

lazy_mmu_mode_enable_with_ptes() called from apply_to_pte_range()
disables preemption.

> +		goto out;
> +	return area->addr;
> +out:
> +	uv_free_stor_var(area->addr);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(uv_alloc_stor_var, "kvm");

Thanks!
