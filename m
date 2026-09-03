Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D05377AA7;
	Thu,  3 Sep 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456268; cv=none; b=Cgkz668umvRh0vWzTXOF2WCxhh3rXbUMbv/haATDHDFn67Nf0f+4OlVjo/IHEFq3SSa7mh9tHznOx0WcT+Kj28nHZC0kb4T9oFEWVU2taZGE8s4B48Xujel5ZzgKF/NasJUjbTT+bisFoJ1oUwrPm91mSu873H77yHXcs/Pk6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456268; c=relaxed/simple;
	bh=bUWo3Ln1yQQwc4kuTS4Fy6LaJyFVsXeAYcWf/2KMuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPHcy667915R0OEjDMMzlmcHUdjkFvqgLZ6RkY6WzR/rSMgUmpwr2Me/SCiXzrygTcMXk8AFR79kTBT8V8JiBEQGgP1x8RHKoWIa4DCwp583RfAiNS33nrb5iO8aOLP9DmiIrE7pfAbKMY8kPTPQxO1FXMcFn6utBHOVyAnguB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tk0w+1ML; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tk0w+1ML"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G2rPP2292349;
	Thu, 3 Sep 2026 17:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=c8TO/7OmvWGnMMLtgzx+QJ5ne/qqbr
	RqrQI/qIvKOcY=; b=tk0w+1ML1WzdAiMfCAeYriFWIVLZ77ViBxJCSohQ/igM7/
	TndfhwZ0gfXTbzKiElVuR3mGNcDARpxUjzbU3BULh/+iBCtisedKz/RNRJZRpr5D
	wwhq6cfQcKlkYrimI4102g356kN/JFqudtRTAuwrQ/PGrm1JnJ2P8LgOv+xw43Bs
	iNzXdpbuFmcu2hSvs3Emdzu3ROf4Bwu0q7pYYkUpPxzMu4LLHVKQdD58b71g4KjC
	7uK3rfY9WQofhSDC0pcNvVfyPPr4l2BrhOCRTa206KUsFrQ11SyFU2//mY3JZjzC
	Ez6X2VsXbeeDYbXLr/d++JMkEVFMcPfcFXdPM9kw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5qy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 17:24:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683HBM3d027423;
	Thu, 3 Sep 2026 17:24:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygrhjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 17:24:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683HOJYP49021252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 17:24:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99E7720040;
	Thu,  3 Sep 2026 17:24:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E81420043;
	Thu,  3 Sep 2026 17:24:19 +0000 (GMT)
Received: from osiris (unknown [9.87.144.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 17:24:19 +0000 (GMT)
Date: Thu, 3 Sep 2026 19:24:17 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Message-ID: <20260903172417.12158Bf0-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
 <e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lQ87t9wGFaNarBH5O1a7QAehJ9p8v979
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfX+aHlm7/7Ulja
 sKxgI46hpg0f+mLQmGtgUkqUK0i50Yfjz91D4cQrayKNXj5gXKviMLX0CKyBMPW0np/DZk0XaUl
 xhzkvtOifBDbQdKelV1C/D4mCWuzlFz0Za76D+3mJpno9BuH6l37FmV46/H74haH7w0ccIASGpG
 7SIjr3KFBgoHlRI4YSSG0dpgTAgMEyJFX0/8+10yJ9sbcHy500Pez8iZtIUsJWJivYUAzyXSC0Q
 sQc1z+0mjZHe6ClHBcWvA+nnDDw5f/HvEp0ZgzYU70Iy0DXoveM0PXy7FOixyCSvjb//roK0O62
 TiRXU8GGS5a3sOR3yihvnGvlTbOJA9KRDQg0X3RbtuZim1CMShvCQdWOX2pm4jLW78M7h1PjTKR
 1OhjGK1tmvelk76RaKv77eqMWziZaxtfFFotULF6UMbNRc+HKMuEK0fV+9Eh6tqASWpnzDv6oef
 JGPjZGxKWy9Y+Bw9vqQ==
X-Proofpoint-ORIG-GUID: lQ87t9wGFaNarBH5O1a7QAehJ9p8v979
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfX5Runrt85YE4E
 YmHEMmZGOTNoemowEE7qxp+pZZOxEsQRX5Xc6IeWiqnTFnMKNdE3e1qMqKwWuodfgcm2S7AHs3L
 FdFMAJYv5y4rAVGbd/9fmDielhiOODo=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99ad48 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=G1NG3s6dxYr6cGAu9j0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030148

On Thu, Sep 03, 2026 at 02:28:35PM +0200, Alexander Gordeev wrote:
> On Mon, Jul 20, 2026 at 10:58:27AM +0200, Heiko Carstens wrote:
> ...
> > This assumes that s390 will gain full support for lazy_mmu_mode_enable()
> > and lazy_mmu_mode_disable() in the future, since as of now the used
> > ptep_get_and_clear() in vunmap_pte_range() does indeed invalidate and
> > flush every single pte entry, but only for s390.
> ...
> > +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> > +{
> > +	struct page *page;
> > +	pte_t pte;
> > +
> > +	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> 
> In lazy mode this callback is called with preemption disabled, so it leads to:
> 
>     [  138.709287] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:322
>     [  138.709535] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6092, name: qemu-kvm

...

Any chance you missed to provide an important detail: this can only
happen with your not-yet upstream series, but as of now there is no
upstream problem?

Is this correct?

> This could be solved using the below fixup:
> 
> @@ -247,7 +247,9 @@ static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
>  	struct page *page;
>  	pte_t pte;
>  
> +	lazy_mmu_mode_pause();
>  	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	lazy_mmu_mode_resume();
>  	if (!page)
>  		return -ENOMEM;
>  	pte = __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
> 
> The downside is lazy_mmu_mode_resume() does not really re-enable
> the caching and the performance will stay the same even when the
> lazy mode is supported on s390.
> 
> This is the same pattern as kasan_populate_vmalloc_pte() - which
> was the only occurrence so far.
> 
> Alternatively, the page could be allocated atomically, but I think
> that is less preferrable.

I guess the real fix is to pre-allocate all pages, keep the pointers
to the struct pages in an array, and populate with a different
mechanism. Similar like the vmalloc code is doing.
I wanted to keep this code as simple as possible, but...

> > +	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
> 
> lazy_mmu_mode_enable_with_ptes() called from apply_to_pte_range()
> disables preemption.

There is no lazy_mmu_mode_enable_with_ptes() upstream, nor does s390
select ARCH_HAS_LAZY_MMU_MODE until now. Therefore my question above.

I guess my assumption above is correct and there is real urgency to
fix this.
