Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665B33A6EB;
	Sat, 11 Apr 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899878; cv=none; b=t7YimxHJUKj+EsBtz0kL9oGvkXyqJ1I2MtMWhW4aTBgaJFjOAhAyA5x25OQom9xPvJ4PsXBAAjJRq43IzssKKPbL/6cQVJVDDWDO63GzK+qI+JBcaeT6gnA5DSxAKdd1Yq3gtUg5GLIeJe9rxdNri/ulnf1wlRWwHLP2j/m7RWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899878; c=relaxed/simple;
	bh=bXfudugdjf3KeIfRrrpUIBpszkHi1xLRW24gQhiN+go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa4BEAIsldFUoA0d7y2WRpZbGSUig5tjNbM+JXpsnbHKrEtkEMvZHy8AeJjW69eNE4cwwomK9hHwoTC5bjNUnHW+NXJJ9xOjH/BHbwSrk6g0+eN+OqClSsnkJMJjdAGWyiZ96+djokaSKbzYMU/UU/S+4bsHsFA5+wLAdxMKUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kGS7zkSa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kGS7zkSa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B0O5Hg2272213;
	Sat, 11 Apr 2026 09:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9G+pDRpTep5hohlw1RQ3G2oELAA0/t
	Yq61fSBJHTJzs=; b=kGS7zkSacYLmsLvFUysSFGicCBlyAlKL6HMymldPK6w75G
	VcCjRmM4uewiyfHKAMNmPCEazXh5fTUiYwrQdSDYg+TwNoCNr09NsMyD0AM2DUQ4
	LOgiHaUFTxSRrZoqpggKzqxS/r9zKNgCKaSWQJNY32x6WH2MPc/G+qJdH3lIvkE2
	JfcUe8KLLE85S0C9Ek0Ho7m7/klN2k0UTSVUegwqxvvCmqKbT27YeqbzugYsXQkx
	WKAjcOetA6NmYn62/rSOnMAOynieiS6rBqD+GMn16N5nXQOgVyBsh7gzN5R4KoB5
	L0NYtX9MpaMOUZg0RmS4y1eZmjSVsmbMRobYWvgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqk90h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 09:31:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B6XKvY014352;
	Sat, 11 Apr 2026 09:31:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg54069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 09:31:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63B9V25q7471396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 09:31:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 692F720043;
	Sat, 11 Apr 2026 09:31:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDF742004B;
	Sat, 11 Apr 2026 09:31:01 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.145.235])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 11 Apr 2026 09:31:01 +0000 (GMT)
Date: Sat, 11 Apr 2026 11:31:00 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <630ce949-2f9c-43ce-9641-b9a4dc729323-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <c27cad07-bba4-472d-8853-fc6fc55e951f@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27cad07-bba4-472d-8853-fc6fc55e951f@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69da14db cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yduxpkpoCOskwDA0OgQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: IpQDT1z9kXrFLsUX7rBCljXm228ZAGrk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA3MyBTYWx0ZWRfXxR1CxwqzwPcr
 aZDOICop81ytS8lVHRni5D3pfDTevXM07MQHpoT0etrTHGeNCpVvGOAori/j9bWeExaGIjmvVjj
 +byeKj3m97zAAHwHPR7oAyp0kc8VotW+aNEn/aaMrsnZSNJIOxjNYoPuEs30TjDxW5jvfvSo4y/
 JRaTa6D3jeeUBrLlAefULj/lYoAu+kbprJe5YJBKhnUaPz+L3ZVTe7mX+7Am1bVw4WDBkh5kdXD
 UDmTyO2AgZ7A91iiwqDhY9JbkGzmSRIBMfBY2sH5UtFojid4awog5X5Gi5vcYe6o4FfSx0WgyBf
 q8dYcMl1YZyxYrrkPaN3oklKx1j3fqOOfNrFSWydF52GhHe2i5Y4wS+CVnfcWwy4Mzz3CwLPQb5
 p8GFfPvoc3xrV+BMKWRdKxY9jtdcb6fi0CvO3/XDVePQDvKSA9osZ9UtSDe4UuVN75yT4BeZO9R
 UMxMp2vwMmOGDexwMHg==
X-Proofpoint-ORIG-GUID: IpQDT1z9kXrFLsUX7rBCljXm228ZAGrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110073

On Tue, Mar 31, 2026 at 04:15:23PM +0200, Kevin Brodsky wrote:
> On 25/03/2026 17:20, Alexander Gordeev wrote:
> > On Wed, Mar 25, 2026 at 10:55:23AM +0100, David Hildenbrand (Arm) wrote:
> >
> > Hi David,
> >
> >>> +/**
> >>> + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
> >> You have to be a lot clearer about implications. For example, what
> >> happens if we would bail out and not process all ptes? What are the
> >> exact semantics.
> > The only implication is "only this address/PTE range could be updated
> > and that range may span one page table at most".
> >
> > Whether all or portion of PTEs were actually updated is not defined,
> > just like in case of lazy_mmu_mode_enable_pte().
> >
> > Makes sense?
> 
> I also feel that the comment needs to be much more specific. From a
> brief glance at patch 2, it seems that __ipte_batch_set_pte() assumes
> that all PTEs processed after this function is called are contiguous.

No, this is actually not the case. __ipte_batch_set_pte() just sets
ceilings for later processing. The PTEs within the range could be
updated in any order and not necessarily all of them.

> This should be documented.

Will do.

> > I will also change arch_enter_lazy_mmu_mode_pte() to
> > arch_enter_lazy_mmu_mode_for_pte_range() then.
> 
> Makes sense. The interface looks reasonable to me with this new name.
> 
> One more comment though: in previous discussions you mentioned the need
> for arch_{pause,resume} hooks, is that no longer necessary simply
> because {pause,resume} are not used on the paths where you make use of
> the new enable function?

Yes. I did implement arch_pause|resume_lazy_mmu_mode() for a custom
KASAN sanitizer to catch direct PTE dereferences - ones that bypass
ptep_get()/set_pte() in lazy mode.

But that code is not upstreamed and therefore there is no need to
introduce the hooks just right now.

> - Kevin

Thanks for the review, Kevin!
