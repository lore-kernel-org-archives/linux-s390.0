Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761A3AF656;
	Mon, 27 Apr 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280847; cv=none; b=pFMTcREug+j/g/wJb1KeuqqjRI621NDfrJ9v+SyuwJ5Bz0pqOduE8KrGeZ5bq7moomh4EGZqCsmMRUXsV1E4sRJxztyfmM2kI6MGaS/VXERZn/SbKai/7FfG4masrMaBg/aBra79We2OmSpR/Bn8YDi8L/LQz5STAJ5HK6nxiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280847; c=relaxed/simple;
	bh=BDM2vJqXOAsdHzCoeOnZRyUJ27679ziEaz6Wo009okA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM5WUPUyIQ9zuvftJykIzwa0BYWwzHiw44ihv3sfAjj+DeEeLZgTKZuaaQA7s+g8AmXLZ8vQfAZXapZC7jGzaLnx9+UYqfTfOFpBhinoSVIDryecmkJaNTgcZaLqACX0Cu4i7D293TjqDfkusfAH3ahY7vOYnPfOSuhlbhsjbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WrPET/1p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WrPET/1p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QI8ifU3450963;
	Mon, 27 Apr 2026 09:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hSYztgf+1Sg2PXQ9FugD3AeLyfAc08
	d5FTb+s36utLg=; b=WrPET/1p4mO9OD37s5qUsQs8FsiiQfNzZTEorc6r/SvRFP
	DDOVzyxeHzTJlZI0frBb3X84u8bMqll3kgpvqb88x1ewhnrva5qxbymvLnxp2D6t
	AueHZWAVA6ZygVPaKsF8Ernuyc9ztzo6u7jvLnwWlBqSssxJgDL0PKesmTzsT8Yk
	zZVwD4sPtQ57GlWpLpmDVvL+h2WYzhEmIBJhaQWEmnDBEcSljE5lFWX7qwwA3Dly
	9L4Ux6dipqxvG5xouOL1nDMjBkJApr97q28v/ELVxVmFoZOHTJ1TZifDe6jTT2jk
	RuTZdvx85RM15GBUFVitAFCf5TZd0Tst9Y5wVFnw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb4yjgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:07:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R8rmtt001956;
	Mon, 27 Apr 2026 09:07:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g49tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:07:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R97A6n27591408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 09:07:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C8B12005A;
	Mon, 27 Apr 2026 09:07:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A032004E;
	Mon, 27 Apr 2026 09:07:10 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Apr 2026 09:07:10 +0000 (GMT)
Date: Mon, 27 Apr 2026 11:07:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260427090708.9079Cfc-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
 <20260423122824.10371E07-hca@linux.ibm.com>
 <104cde89-2a33-4b54-aa2a-86b58bd713d7-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104cde89-2a33-4b54-aa2a-86b58bd713d7-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69ef2743 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=dWqnQgn1XxySkrmxHuMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5MyBTYWx0ZWRfX3wZz11GqLvHG
 i+ulyjC4wRctioO705fekLZbHzowI2uOK6o7siZpuGBpUjdxmOSCtQgbd4LNs3mbKa1niFG+q4X
 iEC3miKIdvbmjd0nJTLoW9AzMOpM2ZYeTZKMxET0Ijm56lirajDWkC/CY8o9Bxj57Q8ApapWpVn
 TC0f7aa+9haQQwncXPCqcM0JGE1uE/7zNHjU2DxoIBrFUawcQN2kVMf25+fJhfhurDQwr8KABse
 dyhYJD07rShBDZ7accNEAoem0HkwwvbvfS7IXt6b4PgeFqGM2S8MnSjnVbaxKdwzl3acBCmmkh7
 FVN9CllwPUh4YMd4Rlm11CVuRRGw57czAoayqUXLOplCsmI448dz9dkttIMDWjjQN/O4xG5wfbN
 AAFfUWjB54gnU9qcIFrcXWGpENYZHoU5ip+QZFQN0h9olHk39XQ0nJ1gMKcO9Xr99/fhCeuV5Am
 9FF/Xzjlr9Eb4YEOpmw==
X-Proofpoint-GUID: vf61Zu4UnRUSWyAUjJn7c4fW2Tn0MMzt
X-Proofpoint-ORIG-GUID: vf61Zu4UnRUSWyAUjJn7c4fW2Tn0MMzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270093

On Fri, Apr 24, 2026 at 03:10:42PM +0200, Alexander Gordeev wrote:
> On Thu, Apr 23, 2026 at 02:28:24PM +0200, Heiko Carstens wrote:
> > > +static inline void set_pte(pte_t *ptep, pte_t pte)
> > > +{
> > > +	if (!ipte_batch_set_pte(ptep, pte))
> > > +		__set_pte(ptep, pte);
> > > +}
> > 
> > Not sure if you analyzed it, but it looks like this might be the reason why
> > you see the fork() slowdown: every page table operation now comes with a
> > function call, even if is not needed.
> > 
> > I guess it would be helpful to add an early exit to the ipte_batch() inlines.
> > E.g. going back to the example above:
> > 
> > static inline
> > bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> > 					  unsigned long addr, pte_t *ptep,
> > 					  int *res)
> > {
> > 	if (__is_defined(__DECOMPRESSOR))
> > 		return false;
> > --->	if (unlikely(!ipte_batch_active()))
> > --->		return false;
> > 	return __ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, res);
> > }
> > 
> > Where ipte_batch_active() would be an inline function which simply tests a bit
> > in lowcore.
> 
> The bit check alone would not be enough - it should be done with the
> preemption disabled. Then it would be something like lazy_mmu_mode(),
> but with one or more values in the lowcore instead of percpu variable
> (at least ::base_pte to check whether ptep falls into the active range).

What I meant: you need a one bit check in the inlined function, so you can
decide if it is even necessary to do the function call. More checking could be
done. However all the overhead of function calls will go away with single bit
check.

Or in other words: enter_ipte_batch() should set a bit in lowcore which can be
easily tested. This bit _also_ indicates that preemption is disabled. So all
the extra preempt disable / enable pairs within the page table primitives are
not needed, after this bit is present und used.

> > Just a general comment about the naming conventions: imho ipte_batch is not a
> > nice choice, since the name of the facility is "ipte range". However I would
> > abstract even more, since nobody knows if there will be a different
> > instruction or facility to achieve all of this in a better way.
> > 
> > Anyway... maybe rename the file simply to mmu.c or tlb.c and change the
> > function prefixes accordingly so we end up with shorter function names?
> 
> I would in turn suggest lazy_mmu_ prefix and lazy_mmu.c source name
> to emphasize it implements the generic lazy mmu mode.

Ok.

> At the same time
> keep ipte_batch (or ipte_range rather) in the implementation itself.

That still doesn't look to good to me, but can be solved at a later time.
