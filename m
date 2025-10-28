Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30385343D66;
	Tue, 28 Oct 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668085; cv=none; b=kJfCqWIcLHDCHLt8wgXOMv39vxA3zXfWpULWFFV2uATQjx908jBL9pAjnxZNsk1d9CAQ0AQ9jl8w1BaMcoFE8q6+r4DyhagCmeSwB+wPGV/4sjrcuP3a+REM8JZIywVWg1OsL1FNCy8pXFyWyI5cxERS50GTIyNvN300u0P7rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668085; c=relaxed/simple;
	bh=EvXnUzrApgC1PbT3TllVmj7sxe7sj38v5SFaQb88Kvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awgFrGBnA5SdPxd8NuN8g4w9cLLMPv7sEaogNjwZJldnOAV9cSXez+GVp22BABhu+b/9flnNDXIbACrHa6+kmVLg1GC441VJc9rTcbY9ka/hyTm8TUA+RKsiKtg9f62JTdjGc0IUfe6UsZcY9K56AmGsLIhtU0B4erUJpJ0DpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLTbcXzc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLTbcXzc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SD9pGB021233;
	Tue, 28 Oct 2025 16:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3XIzNoQ5RCEgQQp0zWyk+dkyklSOKQ
	/ufsdyjhxnvVY=; b=aLTbcXzcBLgz15HZYNZbGhutYYE7YyTQ8tfo1i3DmCZVS5
	g8zqZ2ZLbRXJfYIDxJ1qPPUZbbOVOYwfgckplK0ZD50svB28tHsAPD/fntRlNk6i
	o7Tufm/OKo41uCYSXdVJaump+KAaAncvpjDYfMdd2GrZXadpaWJ4vtbYcUjdZP9U
	67UGnREt5eg5nD0vwiW9HGX6mYRWdN+EIHRzEnFc0jU7LUtE3xTvmP29IBwZ/zlm
	vwiKUyC6A3jCGhoacKJf6tC6PQBaFgPycHBllgLJwbs5AhKqpF75KZA7ck+LZy3a
	fIKgRkUB4yRI7xov1WHvVZVT16CugKwv2QNvH1lw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81wetu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 16:14:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SFefYn009411;
	Tue, 28 Oct 2025 16:14:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j3nb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 16:14:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SGESqD57475398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 16:14:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 277D520043;
	Tue, 28 Oct 2025 16:14:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92FB20040;
	Tue, 28 Oct 2025 16:14:27 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 16:14:27 +0000 (GMT)
Date: Tue, 28 Oct 2025 17:14:26 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, osalvador@suse.de,
        akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org,
        borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
Message-ID: <20251028161426.35377Af6-hca@linux.ibm.com>
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=6900ebe6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cXYDuvELUoMafkmudakA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: t1jWPofHSTzi3Zc35SfGVCvcTD7gq-84
X-Proofpoint-GUID: t1jWPofHSTzi3Zc35SfGVCvcTD7gq-84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX8UTXR0KaqSdI
 79JMtu0fTtaWbYbUXLBgLHFX/fb81KT9lAFgjU/gMYe3RqpmLVpX5b0kumFEd0FMumefdjP5h7S
 xOOerJJs4DhZ9V6UTTGHFhWtRSuqIx7RjjhwMYJpKGByz1YFd0FIWUazj1/PectAPNgJ3FG/DA6
 e4EQQ7QoluBVzkNS1LRZb801Mn9r7VEvUWsf1CYGOGlVMyhv9GRT2ZKPaMLRoWzFkCzox/x3gV/
 R4GPoYUwECeEZuoicl8GNBtiIdx7hbqBONvsM+gua12HcIDHsF5UIMQdxVBsazdFIhb+rg0MFpB
 +OSNQOtbr2rRHXH2Eu4EL8Nlw+YtceY1blrxYdQ/RJKr4vs/1yI77AJE6/6h1ybYp1YS2iwFGKf
 XMPV9y4uVpxOPnMaCQEfANnSzJuxtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On Tue, Oct 28, 2025 at 04:05:45PM +0000, Joao Martins wrote:
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index ba0fb1b6a5a8..5819a3088850 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -48,6 +48,15 @@ struct vmemmap_remap_walk {
> >  	unsigned long		flags;
> >  };
> >  
> > +static inline void vmemmap_flush_tlb_all(void)
> > +{
> > +#ifdef CONFIG_S390
> > +	__tlb_flush_kernel();
> > +#else
> > +	flush_tlb_all();
> > +#endif
> > +}
> > +
> 
> Wouldn't a better fix be to implement flush_tlb_all() in
> s390/include/asm/tlbflush.h since that aliases to __tlb_flush_kernel()?

The question is rather what is flush_tlb_all() supposed to flush? Is
it supposed to flush only tlb entries corresponding to the kernel
address space, or should it flush just everything?

Within this context it looks like only tlb flushing for the kernel
address space is required(?)
