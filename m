Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C31E633C;
	Tue, 21 Apr 2026 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747459; cv=none; b=Y7RRIrNZ1N94mQKP1qgzAZfrhEBMJ2t9ABAIY3jgXTG7497ntKo2T4/nzsqq2Aczpfnk92xW3OUmZIEuhDCKRpXshe+4R9dqsQAkMhGgw8z/g3IWqSTs9Hp1FHfZNM94Y1PrYcrJMxAtyzVPjuuF7J1Y1Tm4P40+Z9X3HPkIZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747459; c=relaxed/simple;
	bh=devEK98+GQJRpjV0VzSWtZfyZvWP4z0Xnj8P2YF7koQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU2UumohnDzrZ8iwbtjFDP0bd96QKpJ/4B4EBZFhui8je40pL5q0mqGBEMAPS/ecgPHUtDZS4GBCvJfgZ0unZ+f9GTxD3yFIqaiXjuVecIP/Rxyfy6x4LGT5G+WAYMxV5vSwO5pEGvfHAgOgtDw2zReRQOjGE4DFwRxP7ow0b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YTJMGyeB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTJMGyeB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgZMl1926167;
	Tue, 21 Apr 2026 04:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5pMSO8+wAaLz3I3JtlaJxOu6EbbRzP
	Lwltj4Fp2D3hw=; b=YTJMGyeBFItjEEQ0ROFcwgB8P3yAqbDRcGtk++pxZIW5p9
	SxZ3qSRq4sElIgc/Pubk8QWL8o/UJrmQXciqLuhaYom9USjnKS3LGBsld/hY5Q/2
	aFUQoKKX9f3b/vdTjU6Omzy17FLh5TFsHZu+kQx0de/b3Y46isnwX0cTNUiuWf0Y
	j8VwaQThp17el9j5p/MjoT9MQNB8bhS/frxqa6fEof1DI0AHAxSfdAL2sHoDOubn
	de5k7/JywHxE7LQvyjgwKO2MJPvYwY9LJiuINGflf4WPqPq0uFzlqHwTZlq2zR+8
	cE6jYBZGF28YEHcjoxWIq+pL7QElDTwxz5Rc2EWw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf2qen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 04:57:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63L4Zbm1016105;
	Tue, 21 Apr 2026 04:57:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvqfwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 04:57:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63L4vNvP55640394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 04:57:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FF2920049;
	Tue, 21 Apr 2026 04:57:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFB4F20040;
	Tue, 21 Apr 2026 04:57:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.156.187])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Apr 2026 04:57:22 +0000 (GMT)
Date: Tue, 21 Apr 2026 06:57:21 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm: Make lazy MMU mode context-aware
Message-ID: <0dd3a5bf-a98b-4181-a88a-ec9c0203f90a-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <8809412aaed8a515fe2e149c822543d640060936.1776264097.git.agordeev@linux.ibm.com>
 <4dc47078-0f8b-4388-9715-744c18590a00@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc47078-0f8b-4388-9715-744c18590a00@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ygna7uQ4-zA1MVdmgRCK6lp-SgwftUTL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA0NCBTYWx0ZWRfX1WkmMHM346wU
 LyA13MuTFImlzXMwnyGwZsIHiqJNX4uEK1BlwixjpGham29kANpLEHu+VIHXsWvRUDI3iKCB+cr
 aSCScNZMW7B37iQ1keqv66QFX8m77ogimXeT5JuvmJM1rgGG9ouNbGUYK7OrQl/f8TI6lhx+D40
 UeZDpC2TeOQWKO7ici/XAPmGxbStXDz8rFge+imFexJK7lOHbJNwGmflBMxri1+E4WfHbOe62FH
 gKBMd4boG7QrebeyMBUV3wdqw5d/wB43YvIU+ymD/cRB5+SmmZSvaOH1QOkTjVsOuiXyHOMykGt
 f27Vr8I6SbX5rg/VjajE+qW5O/7RAtTQX5URs9WjBVQQ5npWGdyJjRawVX2pZ4XczFaGAHVEEFw
 XPS/bgiwjqV5p0A3gwLHiuEakcr7bb+YA18yf05UkgxeEjjhDy7xRZDldtju3eqLVJiAbPD6onP
 M857t53+TCqFtxMPCSw==
X-Proofpoint-GUID: ygna7uQ4-zA1MVdmgRCK6lp-SgwftUTL
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e703b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7CQSdrXTAAAA:8
 a=cFI7nvt5PXbHyqa3DzEA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210044

On Mon, Apr 20, 2026 at 10:45:22AM +0200, Kevin Brodsky wrote:
> On 15/04/2026 17:01, Alexander Gordeev wrote:
> > +/**
> > + * lazy_mmu_mode_enable_for_pte_range() - Enable the lazy MMU mode with a speedup hint.
> > + * @mm: Address space the pages are mapped into.
> > + * @addr: Start address of the range.
> > + * @end: End address of the range.
> > + * @ptep: Page table pointer for the first entry.
> > + *
> > + * Enters a new lazy MMU mode section; if the mode was not already enabled,
> > + * enables it and calls arch_enter_lazy_mmu_mode_for_pte_range().
> > + *
> > + * PTEs that fall within the specified range might observe update speedups.
> > + * The PTE range must belong to the specified memory space and not cross
> > + * a page table boundary.
> 
> Does that mean that all PTEs mapping [addr, end) must belong to the same
> PTE page? I think the wording should be more specific.

I tried to state that end of the range must not exceed pmd_addr_end(addr, end).
Any of these sounds better?

The PTE range must belong to the specified memory space and ...
a) the address range must not cross the parent PMD address range boundary
b) the PTEs must belong to the same parent PMD

> LGTM otherwise:
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

Thanks!
