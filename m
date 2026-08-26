Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA32D94BA;
	Wed, 26 Aug 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754877; cv=none; b=bh2wzUlA/YgZzTYm2GKnXZqcvTTAHPY1W/qOfFh9tIbtS5rUDVXgMabdLGbIVxAGBqgu4rxd9PseBKiHCb0DktfCWhnT81w/2z4rXwmaVwwt4Q8AgMpPHiQLMqnvUnqTI/4Cy3xNxGiDNCZoBcb1GmHttcFtzS5ertiJ3sj8XJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754877; c=relaxed/simple;
	bh=gz+Hy7py4G6i+BjnVLhoWdAJAkXvlOV2a2SeuO1tl2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6g6MiTTBBSarRoEN4Gom6xTBbopJB/9oR7YsGRKN3xYS6lUqQ1P7liyYdPGxJTwNOYStysI5ElAwFTMg9DBJ0aJdXRwuT+8lD2ieiDA0HeBCgO6Dqv0jD4jCDrilhj+Ema9nyYb8zPxmdKLjBnmeL+i+afuS8S1PtHX9JdiR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qdrLHCsW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qdrLHCsW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1fbN4099742;
	Wed, 26 Aug 2026 14:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NCQEfP03PfJyPuRoO/iAqztIvak9OZ
	7A+2JPlREf114=; b=qdrLHCsWghVqJz0MzEk+TWhTMkJWdrRSLHvBr7FH8g2UWe
	sBMrrSN8sQrxtQggzYXgB474vU/8zOgEmpY/TArD6LsgeQkJeppj+pZ8QDu0CSXd
	nb/mTWDM133xVaDzl0co89KVYOD8jMXTSpukHCSRRWeYa8EEXFk0jjOitBLKve5e
	8pZ4kSKb+2FVmQ93HjQPBgWlpqkU41wpMHXWYR5oClPjgVZE6Ga/hhrpodq7NV8j
	HUxDCtBEFD1mFR1YbLKy+XPjiYymBkvhby14b3l40QOw3hVi+L2q5kyFAPG6Azpm
	qadoMH5dCvrReLDrS7u78rFT564Oy8gM22kOG7DQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyc08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:34:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEQHbp026273;
	Wed, 26 Aug 2026 14:34:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsya6gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:34:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QEYQnm47382976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 14:34:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37422004B;
	Wed, 26 Aug 2026 14:34:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7F220040;
	Wed, 26 Aug 2026 14:34:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 14:34:26 +0000 (GMT)
Date: Wed, 26 Aug 2026 16:34:25 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <87a3147f-e993-4629-b0dd-a54aefbf20b1-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
 <20260826130257.21444B1a-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826130257.21444B1a-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX9d0D4fznnW9a
 dTrhFYqWYFysmfgSZ1txZuW6iXZDoIJarDIoVq86gmVpjGrAbjDS0To3u+4gTkEAy/M1WshVaH6
 c39yTFfj+xq+++UAA5ZNRMYpXkO+cC8=
X-Proofpoint-GUID: wYHuOR7MKgKkRlRWI8pHiU2wMZ88MTiq
X-Proofpoint-ORIG-GUID: _aZxFR0LsBp_ue5V73CXJzLqrAptb0CQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX1R4p72y7Hl9c
 Y7etrjktOF7GCy01TJgymVg7ANPeWwQ14gvKJKrseK6x43+BPLSzUIJ8x4wPRp2Eymw8ON1bTan
 BJ+WVecuVX2dJP5ug58w2lphe8lZuV3hbyb0PWQ8S/JVsY4abgYQe9js+XWVkaveUzDWKHKkgr8
 Wh05TXsvfJmupwo2m5/wlRRcVFe1p12841x3cUprI9uSNkr2x3u5a7RTXfW8ub8vZKgv2uWOtsJ
 dGriXF6B+escX/NB9g5hxr16BWjsKhOjhYb/VEzTtFxzo2el8lkm0nIlCL5H94ZVa4eOszCnar8
 v0su8oZTg7ZnYErwZFazo3oQe6O7PZ46JAsJU3lgYAtY5cnCtIRTP6kEtEjw8OJT1k0gDXck4//
 HCYAeABUS1h3Tno8Q8dH1n4fr2c0DRpJYYBd914aXlULa991qy7UdeXCeUMFWXKMQm7Jv0pTraX
 +IH7Nv2GgcNQbZPbbhg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ef977 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SZl-skA7I6m2z5b9x0oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260121

On Wed, Aug 26, 2026 at 03:02:57PM +0200, Heiko Carstens wrote:
> On Wed, Aug 26, 2026 at 02:00:35PM +0200, Alexander Gordeev wrote:
> > On Mon, Aug 24, 2026 at 12:40:48PM +0200, Heiko Carstens wrote:
> > > On Mon, Aug 17, 2026 at 01:33:00PM +0200, Alexander Gordeev wrote:
> > > > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > > > index 3b3ecc647993..dba236664da9 100644
> > > > --- a/arch/s390/include/asm/lowcore.h
> > > > +++ b/arch/s390/include/asm/lowcore.h
> > > > @@ -163,7 +163,7 @@ struct lowcore {
> > > >  	__s32	preempt_count;			/* 0x03a8 */
> > > >  	__u32	spinlock_lockval;		/* 0x03ac */
> > > >  	__u32	spinlock_index;			/* 0x03b0 */
> > > > -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> > > > +	__s32	lazy_mmu_count;			/* 0x03b4 */
> > > 
> > > Why is this signed? Can it get negative?
> > 
> > For the same reason preempt_count is signed, I guess.
> 
> Check again, preempt_count is now unsigned and 64 bit ;)

D'oh :)

...

> > > >  void __init arch_cpu_finalize_init(void)
> > > >  {
> > > > +	lazy_mmu_online_boot_cpu();
> > > >  	sclp_init();
> > > >  }
> > > 
> > > What makes this code so special that an explicit call from
> > > arch_cpu_finalize_init() is required? This is really the last resort if
> > > everything else fails. To me it looks like the code can be changed to use a
> > > new static key, and add a generic early (pre-smp) initcall to allocate
> > > memory for cpu 0, and if that succeeds enable the static key.
> > 
> > I had exactly similar variant, but failed to resolve a race when a secondary
> > CPU callback was called before the CPU0's one. Probably, used a wrong event.
> > Will look into it again.
> 
> early_initcall() should do the trick.

Yep, early_initcall() + CPUHP_BP_PREPARE_DYN seems to be flying ;)

> > > > +	local_bh_disable();
> > > > +
> > > > +	lockdep_assert_preemption_disabled();
> > > > +	range = this_cpu_read(ipte_range);
> > > 
> > > Why is it required to disable bottom halves? A comment would be helpful.
> > > Or a hint in the commit message - this is not obvious.
> > 
> > When an interrupt arrives in the middle of enter|leave_ipte_range()
> > the chain pcpu_addr_to_page() -> vmalloc_to_page() -> ptep_get()
> > decides ptep_get() is called in lazy mode, while the per-cpu state
> > not yet (de-)initialized (AKA inconsistent). That led to crashes:
> 
> So, I don't know what exactly lead to the crash, but I guess the
> problem is an only partially initialized ipte_range struct, while the
> lazy_mmu_count has been incremented already? Isn't it possible to

Exactly.

> solve that problem without disabling bottom halves by reordering
> sequences in enter_ipte_range() and leave_ipte_range()?

I guess you mean setting|unsetting the lazy mmu flag after|before the
state is initialized? I will think about it, though I keep the door
open for a possible lazy_mmu_mode_pause()|resume() implementation,
which I am unable to predict how such rework would fit: lazy_mmu_count
would have to stay non-zero in such a case.

> Would be nice if we could avoid the not so obvious local_bh_disable()
> and local_bh_enable() pairs.

Calling ptep_get() from BH context was certainly unexpected, but the way
local_bh_enable|disable() pairs are used is actually straightforward.
This is a slow path anyway, so I would think the simplicity prevails in
this case.

But again, I will try to avoid that.

Thanks!
