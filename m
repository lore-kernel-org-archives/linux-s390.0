Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F9471D03;
	Wed,  2 Sep 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347188; cv=none; b=ZjLw9HVtdoGnMTdNsJ4qujrE1sOuEA7sRImYQpCQDswMr+qoMq60WmReN2XVgvxzJCXngbkAgiMUZ5TXVljnhJ1W3252+RABWDoy5umFciV9ulUDyyHt8mzrNUSDEBFoGd8eBD4w6AakeFqmgOHCj3u+/72LYifCxJ5v88HaBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347188; c=relaxed/simple;
	bh=WKkY6BKxiTHVCLKbhSQU/zNqQKiml6d8dKaoW/DxFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMi6NktAD8elJHO90TGjYZA5uFFqp+3eodi6Q7QZnOXnymvC2La/BBaST7gxGtI8Zh+DGDUnOS1cZ5ZmRtF9jnQj3D49nPQt7MvU+70r448sQcLdOTIaRgl0Bof/CzPpFNdhlV7hA87ZRLWE7RD5n2KisGv8FBxduI3Hnii1CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VR//f6O1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VR//f6O1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829VcK83863341;
	Wed, 2 Sep 2026 11:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SP487l
	8p0RNVYWf0E+aX17SPWgYCAsQ4ykW+uXS9y+o=; b=VR//f6O1e/GVmuQIBNXl3E
	c++N03JIkbhuVWH9qKQSMQi/bEKotomrTUy5VyMzBfMl30yyN6S+K5/yM7QlwTrM
	Cx5k4ybKH+HVFewBamikpBURMJEEeSioOWmJVX6iaHAR6NcLelh4H46SPDVQH6sg
	Ogi36I7978tQGik4HbnZkfFKodEv+lokNWpF+S3iH/jsNQt9JlIEeidmB/pgvPDA
	wt+/ZfssHkoP2aVhZDOiE6+tEwChUO801kvOqAUVBvZ7JWrbP9kj13JG0oIO9kfQ
	gqC3Z/0xXriiug/yu9Ym6TCgKmnqpcnOgtmmglQGuINj6f7Qoch8c2FIEvU4SyzQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tdgge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:06:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682AuHba004640;
	Wed, 2 Sep 2026 11:06:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqhec2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:06:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682B6F1Q49938900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 11:06:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FA620043;
	Wed,  2 Sep 2026 11:06:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD84B20040;
	Wed,  2 Sep 2026 11:06:14 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  2 Sep 2026 11:06:14 +0000 (GMT)
Date: Wed, 2 Sep 2026 13:06:12 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <20260902130612.41500808@p-imbrenda>
In-Reply-To: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a98032b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=6CR_TtZz_3G4KGvfp1IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5NyBTYWx0ZWRfX3JIQGWZ+BiTx
 PI7QVwG3MiyvlF/riHFgvOTTyZodVpD7CnnmNw56QgtU9MpTJuqOoztfRFbpZs4KB0vsNBrXQBF
 sDO8oJpqu2kZbLXtL8VpCkNzMv87i5Y=
X-Proofpoint-ORIG-GUID: G1lOcnlkib5IgZAxH6VWkuIS-r2eEiR3
X-Proofpoint-GUID: G1lOcnlkib5IgZAxH6VWkuIS-r2eEiR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5NyBTYWx0ZWRfXx/iGQocqTOd5
 KWek+xEBzOZtqzqIy5xMwg+dK7FAXl9LR3Z43Z2ccrUKyPK2iMGjre9VaaRgMiIrInmjM1l+yra
 bgymo5gk8MzjUMw5aoAYKS65x5rNt99R16yNDcRQaze757SAGm3yCc1BH1/mRwc0CdAOHj3wIpm
 A1O2tXsaS5GadU+Qvr8/tMwkF+IHYEHIw6yXUpX4Hz+GMmJ9gR7TvjnraJAiiK+T8H15gxsw6Yi
 fflIlMHe8Ge4hWEkxbMvNPhJdYk0iUyZIzhvCM/ifOir0bP2l/vtBB7QqqNtZV3/673SkjmISVh
 /BwKDG1Ez0XIQh79eVSGlIwzQIOrDfCmklUme445pHqPqQpurJ4Sra3vNFKD7a7AFfW6sTfPw/B
 JvDLUxWboqHIvjAt7cUV/QkRsQZC74KRKT1seh11R3kdTPEbIOcOpRTHB9xRj4W1VGKSqbD+oAY
 8C9ICWO+4hsPotafAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020097

On Wed, 02 Sep 2026 09:15:12 +0300
"Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

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

I have some objections to this series, but not because of what you are
trying to do (which is actually nice).

I understand that you probably wanted to touch as little code as
possible, but now since you're rewriting the allocations to use
kmalloc.... I'd like them to be converted to use the __free(kvmalloc)
system. It will make the code smaller, easier to read and understand,
less prone to future errors, etc.

In some places the whole code flow can be simplified a lot.
 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-kvm
> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/
> 
> ---
> Mike Rapoport (Microsoft) (4):
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA
> 
>  arch/s390/kvm/s390/intercept.c |  9 +++++----
>  arch/s390/kvm/s390/interrupt.c |  8 ++++----
>  arch/s390/kvm/s390/priv.c      | 19 ++++++++++---------
>  arch/s390/kvm/s390/s390.c      | 12 ++++++------
>  4 files changed, 25 insertions(+), 23 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260828-s390-kvm-2015b0d777dc
> 
> --
> Sincerely yours,
> Mike.
> 

