Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158184;
	b=hNzc0ysJYcVBD1aG8odtIeqBi902fccf9OcrCkieKhDjG+Xi/hJ4RemFgwCDQfa0x0/X
	 oyNR3hGwD5wkRVUAe6LT/s/J9dJvxK1QQN6HCnvqVudmYWp3aisQFA+Fcol4575ZJ/u/M
	 n/W/BXIkLJ36kC6a3YAi1oz/M075DwrY2pWeXXrpk1SXZfwBLeV8Uq2dsTUm5YgruXXXO
	 CN4Ro75D4jMtqdG26W4JKxy0FzZ+vznd5ukN66+kT1LJhL42C+8m8WOymfrZWlVbAPvBQ
	 ODIEbC7YUHEftpiMAAxybNXgi/s+WeOW43+GUoGUOnvuYlI93+moiCV+9mdx2zKDmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158184;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=afa95FYRycSTILjMsqGzLRYXv+PeRp5wBtIh6n6xeOo=;
	b=dgrhO209pgRCsbB9hSRUtZMQWy7dcVZi1zaSq0NdIO0OiU/F2KnQB43TiLcisA3+o2pK
	 p8n49V5IauvC1zX3zhFDnycq9YrWiyUhXWmlImxo4uHO/Tfstlq7fBEFX2rSLNn0oWXMJ
	 mdD6ACK5ryQIgkS73af/Q/ElQRaPyHQXMH2L1+8Vc8eyMP+XlyT23kIrutAO6zCI4Gtm8
	 wTDbcTIPc3iX/EVWmQNVvWVB4J9+NZh9z0DD1m2X9tlhWiW8rQdHCcbx4jo8RoLHRpYO/
	 WiOLxX9V3/hV6vpJ5sQ2UWv9oj5vi9iUiyi93i2LSvxtJ2pBNiyWCeoC2eDAfmL1xMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=imaK9aMz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E4606A325;
	Fri, 20 Nov 2026 07:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E1E4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=imaK9aMz
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uab61965675;
	Fri, 20 Nov 2026 07:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=afa95FYRycSTILjMsqGzLRYXv+PeRp
	5wBtIh6n6xeOo=; b=imaK9aMz6We9WdCUTzVaTg7txsXokdCrRM0xgJq/DmbmUX
	CXm/mN7NYuQLdyd6iHdiF0MtOh5rzYuaGlWmm1HAxZPxaEwHQNEgTWBlAaxwrd5k
	fsZ3J8cl1NEeFTTp2XUa2TOZ9sasCtUxUIAydid42mjZgn0n9+jixFEmoH5p3ZpI
	NV5IEUZdFWj4W40YGSpV+OKPhwp+Og1D1Dq6nrp61Urw/m7Ll3buMxtZDK4GqanK
	N3e2D7OXjE8M+TrrGO59+Br/VWY3dYzg47DOy4yu4spFAYCxHRlJk8z6KiGpqiA4
	w9lr3HufL4G/lQUbs1pJjVAJunfRWQfiVjgNut4Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x6cqa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:02:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK6xKEQ600883;
	Fri, 20 Nov 2026 07:02:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5jpsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:02:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK72qqZ46924182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:02:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16492004E;
	Fri, 20 Nov 2026 07:02:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B98620049;
	Fri, 20 Nov 2026 07:02:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.24.221])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Nov 2026 07:02:51 +0000 (GMT)
Date: Fri, 20 Nov 2026 08:02:50 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] s390/char: replace page allocator calls with
 k[mz]alloc()
Message-ID: <fe72024b-da3d-44ba-ad41-79dd5da7fac2-agordeev@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Qgos3NoeD80laCUZJqkS_1Bn37hEhS4
X-Proofpoint-GUID: _Qgos3NoeD80laCUZJqkS_1Bn37hEhS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyNyBTYWx0ZWRfX1RXMLaCa/04M
 aOYxs5DvyYE09AE2LUAJHqxmF5pRsVK/0iA69ltyJ1WFiwHmZG1Z0WIi19JXkzwH8Wj3pNUHQ7C
 i2/4XUoH/zBxUN2HnXd1/WtQrlRPfs8D+reuF4AJ1nCOuNpZfUHoftK+ac1VaMsrXV3TBGm+xVp
 Q4VdoBPPH2KJf1vmiHamehbe1FxxGi+AIOfelUffUCtLfI9+XNt7yKzJZc1qZPuE3FlaTb+1BcL
 gw5vhc9f0tE5f8zDd9Mm2kHL+iWwvwhVjq6+WS8imU7dlsO2Ub9v8WUWZaib+SIua3j6oadyBfC
 No7Wp/Zn9/DDIv4C/w07jac/NGp6Jg10U+JFNKQ6kbr5cRVlLA3XV+i+cVGxCqN6I+j8u92fct1
 GcrYuZ6I4UUigdmovTIECHWgubKpUmQRIs4divExlQ+OCA/UPUfxCRNrUrU7OSMftD1JiYvkeG9
 k9pvPKPlVaQPnYcN27g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyNyBTYWx0ZWRfXxJEDkFN3YIbF
 XIlkKdwXpookl1+MSBo3hkM8LNHRBVxbFVpd6sLoa/15c+FAdlIv7xody3pmScoq5FjW+NhpD0P
 +ixyYCwvYW7Sgce59CvWtrfe6qqg4i4=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afff0a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=bKjcd7YqMW8_FUSzF1wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200027

On Sun, Nov 08, 2026 at 10:48:57AM +0200, Mike Rapoport (Microsoft) wrote:
> This the next episode of conversion of page allocator calls to kmalloc
> family :)
> 
> This series covers s390 character drivers other than SCLP.
> 
> = tl;dr cover letter copied from the previous posts:
> 
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> kmalloc() guarantees alignment, physical contiguity and working
> virt_to_phys() and beside nicer API that returns void * on alloc and
> doesn't require to know the allocation size on free, kmalloc() provides
> better debugging capabilities than page allocator.
> 
> Another thing is that touching these allocation sites gives the reviewers
> opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> another size is appropriate.
> 
> For larger allocations that don't need physically contiguous memory
> kvmalloc() can be a better option that __get_free_pages() because under
> memory pressure it's is easier to allocate several order-0 pages than a
> physically contiguous chunk with the same number of pages.
> 
> And last, but not least, removing needless calls to page allocator should
> help with memdesc (aka project folio) conversion. There will be way less
> places to audit to see if the user was actually using struct page.
> 
> The patches are deliberately kept small, so that every conversion can be
> reviewed, and if needed reverted, on its own.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-char
> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/
> 
> ---
> Mike Rapoport (Microsoft) (5):
>       s390/zcore: Replace __get_free_page() with kmalloc()
>       s390/vmur: Replace __get_free_page() with kmalloc()
>       s390/vmlogrdr: Replace get_zeroed_page() with kzalloc()
>       s390/uvdevice: Replace get_zeroed_page() with kzalloc()
>       s390/hmcdrv: Replace page allocator calls with k[mz]alloc()
> 
>  drivers/s390/char/diag_ftp.c     |  5 +++--
>  drivers/s390/char/hmcdrv_cache.c | 18 +++++++++---------
>  drivers/s390/char/hmcdrv_ftp.c   | 14 +++++++-------
>  drivers/s390/char/uvdevice.c     |  4 ++--
>  drivers/s390/char/vmlogrdr.c     |  4 ++--
>  drivers/s390/char/vmur.c         |  8 ++++----
>  drivers/s390/char/zcore.c        |  8 ++++----
>  7 files changed, 31 insertions(+), 30 deletions(-)

> Sincerely yours,
> Mike.

Applied, thanks!
