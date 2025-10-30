Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F42417E6;
	Thu, 30 Oct 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835108; cv=none; b=MRXtrw5Lt1nn0IY5O1YzBoa6xCvJc1pUYlerudRI0yut+ko6iXKierWDkHClF2staPsmxMgQJC4Q+WNTIX7fhZBC2lmfl7/RKzi+VYET+Nd5/2iXpF/eAYh+Ee8cz3A78xqQmxlC+Wy82/NpjLLvcJWBFTTZw1z0ezH4k4L95mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835108; c=relaxed/simple;
	bh=K52ErklFjBj4qbC4hiI/KoUnnVcqEJ916KNtIbTUSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA3PbQRkfUd6P8FIyR/MVpvtM9PiFGI8E0J9WlfaZEhQ0J3b9gHYMierdLBa8ET/b4YGoD2UbvWTJ+zu0YKSG4HT681kqVSTlwd23WxntlrkxbnEd5VD1dn6XXsCRoFN5a0WKmbiML7EK78b8sDLliAnMX2Gxj7JVDp6Szg2QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XDF97jDZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XDF97jDZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UD7Q7u019602;
	Thu, 30 Oct 2025 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X3wOm+
	XTaMSSFq9MM5FtbFGRRF1GOZhVG/2eB+BlBK8=; b=XDF97jDZqAs0jU5ZPp2VFb
	4wCpLp3dk830RGUD7kRk4p0FAmaadOWY7yJNuzbwSiDLqwBlWDn6HJb1hnvhghVR
	h83RU33yi7UWrhDk1eOFr09C6PeYscI4GH7vWe3o0rzP1+PslqMVzXtiYFO5EK25
	7ZBsiev4TFwmOyr67G864OQwEW/ZQZid5b0UsdreuDlcltyWN4VtbjJ+k0LWhfhJ
	CzUYuAaZs7sz2qE0qZKCsARFlk3/HXw/uTdMR4fvGUX6GwMDmo7O9sgWka82bQrq
	AN7JWVBGDp42Sgjj0LRLbuoy2wFEqGeUHaNVSrmlKNvCSb99Qc6VEAuBjl8x56Ow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agrpqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:38:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDJ4iX027428;
	Thu, 30 Oct 2025 14:38:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2s5rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:38:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UEc8gX59769240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:38:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D88632004B;
	Thu, 30 Oct 2025 14:38:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1ECC20043;
	Thu, 30 Oct 2025 14:38:08 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.238])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 14:38:08 +0000 (GMT)
Date: Thu, 30 Oct 2025 15:38:07 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
        Luiz Capitulino
 <luizcap@redhat.com>, borntraeger@linux.ibm.com,
        joao.m.martins@oracle.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-ID: <20251030153807.0a835fee@thinkpad-T15>
In-Reply-To: <20251029124953.8393Cc7-hca@linux.ibm.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
	<6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
	<20251029104457.8393B96-hca@linux.ibm.com>
	<9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
	<20251029124953.8393Cc7-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=69037855 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=7V4s7PEeRJvMkV0XkP4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QuWdHNzaLPBwAGTt0znk4k51e_rz3lle
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX8bMHmkGR/4De
 HYE1Z9xyBUD1Oj5iuMbBMNf4z5tHxtlTJgnaIzfPvHsa5JdD0dih2UUsIdBQBzC/2SMsTnAvQhg
 6wEGVcjU9RRAQ044mvBwjir1bRub+rqfExF39fj4/LGt2bKX1a2i1BdxIJjR0BDVYiXT1/qdwps
 sEmf0mQZ4Ub9Z+BJNJOPwy5LLxN2jOrPniXGmLPPt50qBRe+2PFgtuG0Wyy9XX0mvYo6JLzCU/X
 uMi9fdc0PBQnDYrDf3/Ds7viihOOpm+SPBiX3j4FG4PU2ZzzOF3Bz0t0Hnmjlq0n5+Im8t+Hc1V
 5NrSDR0m2KXgWcJ9UhOWdoCyEsSr7QXtcOzsctqol5ReplG+qCjcBedOGuXc/y6S+GOz+xA3orZ
 b1OFaHEQVkYs5Mlo+X5mu3vVxD0sag==
X-Proofpoint-GUID: QuWdHNzaLPBwAGTt0znk4k51e_rz3lle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Wed, 29 Oct 2025 13:49:53 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Wed, Oct 29, 2025 at 01:15:44PM +0100, David Hildenbrand wrote:
> > BTW, I'm staring at s390x's flush_tlb() function and wonder why that one is
> > defined. I'm sure there is a good reason ;)
> 
> Yes, I stumbled across that yesterday evening as well. I think its only
> purpose is that it wants to be deleted :). I just didn't do it yet since I
> don't want to see a merge conflict with this patch.
> 
> I also need to check if the only usage of flush_tlb_page(), which is also a
> no-op for s390, in mm/memory.c is not indicating a problem too.
> 
> > > Changing active entries without the detour over an invalid entry or using
> > > proper instructions like crdte or cspg is not allowed on s390. This was solved
> > > for other parts that change active entries of the kernel mapping in an
> > > architecture compliant way for s390 (see arch/s390/mm/pageattr.c).
> > 
> > Good point. I recall ARM64 has similar break-before-make requirements
> > because they cannot tolerate two different TLB entries (small vs. large) for
> > the same virtual address.
> > 
> > And if I rememebr correctly, that's the reason why arm64 does not enable
> > ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.
> 
> Ok, let's wait for Gerald. Maybe there is a non-obvious reason why this works
> anyway.

No, using pmd_populate_kernel() on an active/valid PMD in vmemmap_split_pmd()
should violate the architecture, as you described. So this would not work
with current code, and also should not have worked when I did the change,
or only by chance.

Therefore, we should disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, for
now. Doing it right would most likely require common code changes and
CRDTE / CSPG usage on s390. Not sure if this feature is really worth the
hassle, reading all the drawbacks that I mentioned in my commit 00a34d5a99c0
("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP").
