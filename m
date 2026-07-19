Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AC11CBA;
	Sun, 19 Jul 2026 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466228; cv=none; b=Y/meGC9fSutKz7DowX6jm3Y4KyBtrcSykeoUXym58xBHYBBxa6yIMp/LjxVd4wnOT3GZQgnI4Nlp6YDzfs0TsI9T24kGDyNHQ/36EQDkW9hmDYAPuoIPZh4YhyfKczUbmboET9U0UsCWKwi3BWjekPhZQwDoY18t2So31j+4TNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466228; c=relaxed/simple;
	bh=IuvNPhz/qs9bKIOzWkFfEKumIM149XuxFtB5N3oRRLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EypcKDfElmXh8olW8SYyywhIozRaBH3LC3CIptU2eFpaeLclMTiCYALYRb852XFtzuK68EuCF1tukxl4k3DnWiRqJltjt8hxNvcQu5Eu4cuqTtjR2uEk6SJ1t+AEIkgtO74cEJqaXsdtukAZVmxirl3n0CrCqkg94YZAJdSNyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5eZ2vt6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5eZ2vt6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBChCl3352920;
	Sun, 19 Jul 2026 13:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=trwG6Z2mln5d7fkk2b+593flmrbwvv
	jvX6Ut/8gYq7w=; b=g5eZ2vt6w92OGJm+kNsy9LA38wwBAKPovdSWGZ+uWImmFI
	M+A/U8lK2NSXOqn/+QmL2VOBDnEN8Sui1w9BES0hL2M1rXaDFRznnzeXeFL/FqrO
	xYHYITW6HdFhhF7RoAE4YBNCeIAxBSB4L2rVMI+AIS7LxFmmGiOjwm7BliUHv5XC
	iYnk6+aXUr/nUrXetGuDVkZO+UCniVl2rUZwVZHzx5lc34J0/736gDkTePHFFS61
	rQRlqu5+ojm0C7AWzSlZvLSxc5s544v95TJYE6FW74365Ok+H8xXXOlc0Z8QNVXa
	sgr9m8Vc41qSGggz55nqEbKQNcTQIJS0YQzQZpgA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab3g0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCniO0001552;
	Sun, 19 Jul 2026 13:03:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vsshr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD3fdp39911892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:03:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7873F20043;
	Sun, 19 Jul 2026 13:03:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3759120040;
	Sun, 19 Jul 2026 13:03:41 +0000 (GMT)
Received: from osiris (unknown [9.87.153.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 19 Jul 2026 13:03:41 +0000 (GMT)
Date: Sun, 19 Jul 2026 15:03:39 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: s390: pv: Use VM_SPARSE area for guest variable
 storage area
Message-ID: <20260719130339.22878A6e-hca@linux.ibm.com>
References: <20260716141436.2125703-1-hca@linux.ibm.com>
 <20260716141436.2125703-2-hca@linux.ibm.com>
 <20260716143333.20B891F00A3A@smtp.kernel.org>
 <778ba45f-bd2e-46e0-8b08-fcd209dd174d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778ba45f-bd2e-46e0-8b08-fcd209dd174d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX+Ug5FSmkny1x
 yj39YhXZOX7SGQsXUgJ316pEUcInDdGc/mEU6tID1PnrFXmZUV4atDhMldPS2rHKc+3YvmTNvkT
 fecpbQ4e5/qm5EChuptDbz9flHYHKoAx1knUTZ925xJHBKi4H7/nJVXEAnaeOwfd8kqW7529Y+U
 W317acv72E1M95wK2ZIV3iQGc1cGybBsc0cFqcoMkbfML0QVrg1dgRjbkbjwOA2YXxOphWq1lVV
 SO1bkm9hKnGQhpk7riza5rdCYiFXepHWcXQEZiUBRJD089SAphk5VV46aP+Xr7bC8DkORlfNwWd
 ts4ujNUYthpy9skv8t/SpJmZbjYV/gQVQF4QOdAkUUMSUZ2kHeyW/qW/mzfQApvQP67Ql5D4V4P
 BAcsD0dM6mI4x9jOtdiKvDklsJa271giqYr2N7s/VIxSKbM6QGw7TdRHpASTaVkFQUqp8iFmcQe
 1ADFwNOcpFjf/KWfpbw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5ccb32 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=xuUelXlGgw66GkdJ-MUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: --knOerf1ZMHvZH9p9Z-x9qLGJcCk06h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX9VKY//NZo/yE
 EPjki8NfGUd/q2c7O8i9k2Q0G0jJ+oSVuKbhNo8xkQ3YSJoBpgtfjTw7pIUOPCmqpqvGvjretQD
 uKV6jIEXLCCTyPpKSOt+sS8Muvsawa0=
X-Proofpoint-GUID: --knOerf1ZMHvZH9p9Z-x9qLGJcCk06h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

On Fri, Jul 17, 2026 at 11:12:09AM +0200, Christian Borntraeger wrote:
> Am 16.07.26 um 16:33 schrieb sashiko-bot@kernel.org:
> [...]
> > [Severity: High]
> > Does this create a Use-After-Free window during VM teardown?
> > 
> > In uv_free_stor_var(), we call apply_to_existing_page_range() which invokes
> > uv_free_range_cb() for each page. The callback frees the physical page
> > directly to the buddy allocator via __free_page() while the PTE remains
> > fully present and writable in the init_mm page tables.
> > 
> > After all pages are freed, free_vm_area() is called to clear the PTEs and
> > flush the TLB. If a freed page is immediately reallocated to another
> > subsystem, can concurrent accesses via the stale vmalloc alias read or
> > overwrite the newly reallocated page before free_vm_area() completes?
> 
> I guess this is a very very theoretical problem. Not sure if we really want
> to address this. The necessary allocation in a freeing function might be
> worse than temporary access via the kernel mapping.

I added a comment why this won't be addressed. The existing vmalloc
code already implements lazy TLB flushing (even though it is not
active on only s390 because of our special ptep_get_and_clear()
implementation).

> > > +void *uv_alloc_stor_var(unsigned long size)
> > > +{
> > > +	struct vm_struct *area;
> > > +	unsigned long addr;
> > > +
> > > +	area = get_vm_area(size, VM_SPARSE);
> > > +	if (!area)
> > > +		return NULL;
> > > +	addr = (unsigned long)area->addr;
> > > +	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
> > 
> > [Severity: High]
> > If an unaligned size is passed to uv_alloc_stor_var(), could this cause an
> > infinite loop in the page table walker?
> > 
> > The size parameter is passed directly to apply_to_page_range(). The internal
> > page table walker loop relies on the end boundary being exactly page-aligned
> > to terminate:
> 
> This is one of those things that wont happen in reality as the returned sized
> will be aligned, but as the interface for base variable storage returns bytes
> and in theory _COULD_ be unaligned
> maybe change belows hunk to
> 
> @@ -369,7 +369,7 @@ static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
>  	/* Allocate variable storage */
>  	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
> ---->	vlen += uv_info.guest_virt_base_stor_len;   <--- also add ALIGN here
> -	kvm->arch.pv.stor_var = vzalloc(vlen);
> +	kvm->arch.pv.stor_var = uv_alloc_stor_var(vlen);
>  	if (!kvm->arch.pv.stor_var)
>  		goto out_err;
>  	return 0;
> 
> Could also be a separate patch if we want to.

I added the alignment handling uv_alloc_stor_var(), so that it doesn't
matter what callers pass.
