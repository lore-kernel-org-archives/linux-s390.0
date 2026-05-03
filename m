Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41441FC7;
	Sun,  3 May 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777791093; cv=none; b=g74xY3QHWli+rn2NEupveyqLISU/qbR8ejG4ZjvATlc5dvAAxA9MwpZKbJQ/Lnb7c98gHSeJ/WZR7Qz6uXFx7Tgd9gZARNKDkret1pVcLRysLnUQ54yNfl595+MNt7MeON0ySE/r/+89yAA+wspxzv01LkG1Qbe/ZUik8FQoHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777791093; c=relaxed/simple;
	bh=zCwppk8LLKAO5ScgeSiyx93hYwewbcjpClEc0mGx+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfOywKmpcLT7VBqj7mc8KGiA418wP2aT4nZw9N7eAnSg/gPV8glPFzIJ+5Lw+9LcMCOEHtey8af+/pyZrMKt9wfw7qUXrn71YatQpTD9EOkwa8uIUmyHFdJV25qYfXDTSr0sogMcd+mLC47DPYXyxzvDg4Qf+d6MnAfnCrTRwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gBFJgvD5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gBFJgvD5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6433u47c1098879;
	Sun, 3 May 2026 06:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fXwWgXqyZ+hoaQDqUx/6gwNEmSEaAC
	SbXLw7DNH93Gw=; b=gBFJgvD5pigGfrcpBxTLvOXil+cxJge/OMcmCHx06L2dg/
	nNbdtRiSaGDEjv+LZ5R13R9s1UZNddrIIudaIxvnV85xEP/dGFBEhOP6H+cD3Ju9
	AH8NjiLkIu9IFKOKlkubR68XxG6UAd+DazvJMgye2ibo6m6PNvjRdxa/6byaJg4y
	Sz0I3c+7kwFSMkgeSm49UFhKGQQGJkEyvrlXmilYk+KzOYbh0Qx6IYW8cAZ6CmmA
	2TRAT3Tc+wWkifHjwyIOqB/tNH0l0zge7SASypNzLPF9WuIK/+mQ7pdWJ4/mhnu2
	Z2KGKhNPkrQwEhdIZ91lwZShsGrJ4Zxy03k0/K5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w62ybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 May 2026 06:51:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6436dclx020312;
	Sun, 3 May 2026 06:51:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3grmmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 May 2026 06:51:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6436pEgc52101500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 May 2026 06:51:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AF520043;
	Sun,  3 May 2026 06:51:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 855B520040;
	Sun,  3 May 2026 06:51:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  3 May 2026 06:51:14 +0000 (GMT)
Date: Sun, 3 May 2026 08:51:13 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
Message-ID: <20260503065113.3385165A37-agordeev@linux.ibm.com>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
 <69c4c12c-7cdc-4a17-9eb7-6fb1a61f9834@kernel.org>
 <f3140daa-9a7d-440e-a448-35aa8797357a-agordeev@linux.ibm.com>
 <109bc59e-1308-4505-b8c6-3376aed74585@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109bc59e-1308-4505-b8c6-3376aed74585@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f6f067 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Wqft4X0g1SF3gye0YpIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jQDulZv1GwanchveUZUQVPUVG9uSnSzo
X-Proofpoint-GUID: jQDulZv1GwanchveUZUQVPUVG9uSnSzo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDA3MCBTYWx0ZWRfX/MdQgzmUSQNj
 5lQBFPWXLG0FaNLDfjR3Y9UhUQ5uLzpVExE8uuoQKbC0EDC9QURgJLwZZr41IYxkheOglCbH8as
 8lO1q8dkdQ7wmBJrIgBedc2fm8vHohVbOSYRz8WDrnUHxXWwaP5yjFmQPFRNqp1xdHxKdHwtvDL
 aGurkQ7G17konoQWTPbkaSzh4BXBTw6F7Q4J/OZjZxG9z/0phckc2GfvkDHx+DAWpZ1SG6RNTZM
 7VHRB2ILQBTGYkqI6XuBtDxJhGEUy5LrnO9MGEn/PCSRZQ7X9XrCjikLKCyCpjBCdC/Ak3yp2kP
 Jz5gYCaT3LgwJrcRlHA8J57w0z0o1uNW+ylT7PyXshD2Ih1lRop2bKqzduNUUwITtKfzFhKvPOV
 fAF6Y2+mHX7LE21bqTINxzRrYkqhuzhE+GstW/wYvxMmYFbU1fBy2soj4bMYbg0A4CNhShcEW9I
 APC6aTEuldFI8I6KUlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605030070

On Fri, May 01, 2026 at 09:01:09PM +0200, David Hildenbrand (Arm) wrote:
> On 4/29/26 15:47, Alexander Gordeev wrote:
> > On Mon, Apr 27, 2026 at 11:02:50AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/27/26 07:20, Alexander Gordeev wrote:
> >>> Convert pgtable direct entry dereferences to the corresponding
> >>> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
> >>> reads when no lock is taken.
> >>>
> >>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> >>> ---
> >>>  mm/page_vma_mapped.c | 12 ++++++------
> >>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >>> index b38a1d00c971..a4520bb10d2a 100644
> >>> --- a/mm/page_vma_mapped.c
> >>> +++ b/mm/page_vma_mapped.c
> >>> @@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> >>>  	if (!pvmw->pte)
> >>>  		return false;
> >>>  
> >>> -	ptent = ptep_get(pvmw->pte);
> >>> +	ptent = ptep_get_lockless(pvmw->pte);
> > 
> > (*)
> > 
> >>>  	if (pte_none(ptent)) {
> >>>  		return false;
> >>> @@ -219,17 +219,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >>>  restart:
> >>>  	do {
> >>>  		pgd = pgd_offset(mm, pvmw->address);
> >>> -		if (!pgd_present(*pgd)) {
> >>> +		if (!pgd_present(pgdp_get(pgd))) {
> >>>  			step_forward(pvmw, PGDIR_SIZE);
> >>>  			continue;
> >>>  		}
> >>>  		p4d = p4d_offset(pgd, pvmw->address);
> >>> -		if (!p4d_present(*p4d)) {
> >>> +		if (!p4d_present(p4dp_get(p4d))) {
> >>>  			step_forward(pvmw, P4D_SIZE);
> >>>  			continue;
> >>>  		}
> >>>  		pud = pud_offset(p4d, pvmw->address);
> >>> -		if (!pud_present(*pud)) {
> >>> +		if (!pud_present(pudp_get(pud))) {
> >>>  			step_forward(pvmw, PUD_SIZE);
> >>>  			continue;
> >>
> >> Wasn't there a problem with folded page tables, where we would no longer be able
> >> to optimize out the folded page table accesses?
> > 
> > Ok, that is a different topic. I actually tried to resolve the lockless
> > issue(s) in (*) while the direct dereferences just seemed to be relevant
> > to go along (similarly to the GUP patch).
> > 
> > But I would rather resend ptep_get() => ptep_get_lockless() fixes for
> > this patch.
> > 
> > Would it work?
> 
> You mean only sending {*) ?

Only this:

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..6559e17f11c2 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 	if (!pvmw->pte)
 		return false;
 
-	ptent = ptep_get(pvmw->pte);
+	ptent = ptep_get_lockless(pvmw->pte);
 
 	if (pte_none(ptent)) {
 		return false;
@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-		} while (pte_none(ptep_get(pvmw->pte)));
+		} while (pte_none(ptep_get_lockless(pvmw->pte)));
 
 		if (!pvmw->ptl) {
 			spin_lock(ptl);

> -- 
> Cheers,
> 
> David
