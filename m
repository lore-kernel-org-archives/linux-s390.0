Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604304D6C44;
	Mon, 28 Sep 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612208; cv=none; b=ki4BZ7px0T4vsYP4uXAPMloSi7wUx78rIyOsSIyyaUVLrbn9npAt3ksMCkFgfAji9/9TjrCRnKDpKO6MpXiiQWG6SbklQkmdOhBuQmvwZdRpDPL/FYPCV/REDuTw6wEDpspAE5baxvl6MqAu9PRd0rECv1HyKY/qfF6BNsNmJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612208; c=relaxed/simple;
	bh=DtdCHxnUaXbzaIkavnA16JdKEeULygl5SHR+qf3JWHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENLzPN6e9pQoSjaZIk7hqZ8fRGGpWuCFecRHx6rbUCftDNj/GIKqmbIaocntO30xcxtTojWXCGSkYsHczgAJtXxrfV8XznOgiepdTwUJ/JopROUtG7UzGUl/+DxVX6LO1aKssIlEOjVUSqx+T1kE9FATb5nWFh6Chud1pU+CqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k99btnrm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k99btnrm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5UR5216848;
	Mon, 28 Sep 2026 16:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tqCY0tWphzhWyHFpdwjWwuig9ZhPkf
	5YqjbeUt1I6uA=; b=k99btnrmIQbXQhiNFlOlpqOSkqX6x4ivkIceiZAgkVkPmp
	90Wr5xTzDine7WgmavgI1Ytag/Br2PCOhmSwR20Nl+6F5P4xz6spfuXVXTByiO3z
	HVtzEHFV048q9X290W8Scx/NHbEyEAMwHNjUlLkXItUv+0fiQ1LfP//RJIJU7Msd
	zPo3tZKilcjaWb3MCLHmPaY8fpQJ9DiYsZRwTGSw6tJvLVkV0yZDlIcjNja/H8MT
	nP+PPpJJs81hmjGcOTPGPOBqQBtq3QU29ZsDMmNa4TyA+8dZpcBrRhwqh50IJZaq
	g5Oefq9WkK2P7TYpVGjBHp9T4BHb7sCbd3AqiByQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe27nq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:15:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SElVgA251961;
	Mon, 28 Sep 2026 16:15:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck61mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:15:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SGFnOn54460908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 16:15:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FBC920043;
	Mon, 28 Sep 2026 16:15:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F8C620040;
	Mon, 28 Sep 2026 16:15:48 +0000 (GMT)
Received: from osiris (unknown [9.87.129.112])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 16:15:48 +0000 (GMT)
Date: Mon, 28 Sep 2026 18:15:46 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 20/29] s390: Introduce Start Arm Execution instruction
Message-ID: <20260928161546.428362-B-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-21-seiden@linux.ibm.com>
 <1e3b65b3-0c21-466f-ae09-8426eeacb97d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3b65b3-0c21-466f-ae09-8426eeacb97d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba92bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=e3H7mCSiy_dY2-7_aUoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3FSm3poY32ru
 XNpcZw6G5JilofWjVWIAL3oP4Ur3C8GgIIfLeX1MeJGeUvA+tByS9z0RHBt9xL4zxRF9vJaef8f
 NIGNJmu/RKV8WlV/FMOZH0MbVUwyyTg=
X-Proofpoint-ORIG-GUID: u7gi_9HJKgoAJZK9_WrkyB0fwXIjcwUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX6DJMgiDneped
 QSRu5a4Y/OkaqXFWEb5fmEwOY/3QV3AbBPgXGGv5B9jhsW5sdO51LB/lWwvdQOuMIX8xx8pHfq4
 bEPo7AIYAOxJzo4vgZ+CRTxb8Y5bOVl6Xj1S1suhouAJjFIst8GSNDYQj1otUv9o4eeeqF04Ind
 2CIREBrvbcTKBikSaD1MivFC/xg6YfsOEvxK1AS8lTTBuDThSDdJxNZr9lUOmkV9g68YxvZl7tb
 anrOkjnQMnN6fjMAT035LPxzGd8IAFZ4PDVYNzMWao59alb/XDdFJa141lC7Ux2Vko4KCJEP0t7
 InhU1EMnFF9RZBBZGG5NdOUDNVEJHWmaS4b7k/YsA0YpRgk571Ms7AbnAW4IQl2bYyIV5zEP2Tn
 y9z8eVpGMf0DmsQ8oNmbgk4BhnXNBR+X1WsDJfbgl+HmZCyLDrv8O1Wqv+mRlszk98FPt26E0/0
 mYYFsmG+FgH/gT5vd9A==
X-Proofpoint-GUID: P2tX3rfu3_XjSxABuwj_-1RkrjrsE3wJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064

On Mon, Sep 28, 2026 at 05:53:33PM +0200, Ilya Leoshkevich wrote:
> 
> 
> On 9/18/26 15:30, Steffen Eiden wrote:
> > The Start Arm Execution (SAE) instruction is the centerpiece for
> > executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
> > enable accelerated execution of arm64 virtual machines. SAE expects the
> > physical address of a control block as the only argument.
> > 
> > The host is responsible to save & restore
> >   - GPRs 0-13
> >   - access register 0-15
>              ^^^^^^^^
>              registers>   - breaking event register (BEAR)
> >   - vector/floating point registers
> > between SAE executions to guarantee host consistency.
> > 
> > GPRs and BEAR are save and restores in the asm functions. The other
>                     ^^^^^^^^^^^^^^^^^
>                     saved and restored
> 
> > register are handled in within C code. Access registers are handled in a
>   ^^^^^^^^             ^^
>   registers            not needed probably?
> 
> > later patch and SVEs will be handled when they are introduced in a
> > future series. Most arm64 registers are handled by a satellite block
> > called save_area. Some registers, frequently used by hypervisors, are
> > placed into the SAE control block itself.
> > 
> > Enlighten asm/kvm_host_types.h for the new header variant. The new
> > header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
> > is defined.
> > 
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/asm-prototypes.h       |   1 +
> >   arch/s390/include/asm/kvm_host_arm64_types.h | 124 +++++++++++++++++++
> >   arch/s390/include/asm/kvm_host_types.h       |   4 +
> >   arch/s390/include/asm/sae.h                  |  58 +++++++++
> >   arch/s390/include/asm/stacktrace.h           |   5 +
> >   arch/s390/kernel/asm-offsets.c               |   1 +
> >   arch/s390/kernel/entry.S                     |  22 ++++
> >   arch/s390/tools/opcodes.txt                  |   3 +
> >   8 files changed, 218 insertions(+)
> >   create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
> >   create mode 100644 arch/s390/include/asm/sae.h
> 
> [...]
>    > +#if IS_ENABLED(CONFIG_KVM)
> > +/*
> > + * __sae64a calling convention:
> > + * %r2 pointer to sae control block physical address
>           ^^^^^^^^^^ I guess it's just a physical address and not a
>                      pointer to it?
> 
yes. Fixing.


>                      ^^^ sometimes it's called "sae", sometimes "SAE" -
>                          it would be nice to have some consistency> + */
Thanks, I will convert everything to SAE


> > +SYM_FUNC_START(__sae64a)
> > +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
> 
> Strictly speaking we don't need to save %r14, but I guess you do this
> for unwinding?
yes. Also, some later (unsent) patch needs this and before I forget this, let's
do it now. 

> 
> > +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
> > +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> > +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register
> > +	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> > +	xgr	%r0,%r0				# clear guest registers to
> > +	xgr	%r1,%r1				# prevent speculative use
> > +	xgr	%r2,%r2
> > +	xgr	%r3,%r3
> > +	xgr	%r4,%r4
> > +	xgr	%r5,%r5
> > +	BR_EX	%r14
> > +SYM_FUNC_END(__sae64a)
> > +EXPORT_SYMBOL(__sae64a)
> > +#endif
> [...]
