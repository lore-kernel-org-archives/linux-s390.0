Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933911862;
	Wed, 26 Aug 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749390; cv=none; b=atSFg1c9n8WEsAFHBVikP3vLZ0AnsAxNM8VsCFh9LXkMbbqPQDds25kncHSWIIzoLE8ANsa0W0gkKDLQ7HDWVLVIf8g6tUTFS2BFD6T8Ls/wAfiSpz/A51Y720hWAgzYO0SjaCODlo0urLig0d2/86ptn70YWlTQcXTR9gZO4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749390; c=relaxed/simple;
	bh=cJwZnH1U2rS+CT0I4djJ2EgaS1OqgtXlEyEL5swoP1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFYBoP76nJgKTGZQgE0XbNbJ5TrF9Bdwlcs/dvYbrMQsdgT6Gfci0bwPeRSZPtajqdBV9dI5DverckBTusfWhqTs0u8vF3DEktl2Y1umstGayTZL/nblnLk2BgIE98GyOet7XIl8pzKTxPZtPuaLHGrqjrUvk3QPS7AuD83RTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XPLXQ3Cg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XPLXQ3Cg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCW01g4003177;
	Wed, 26 Aug 2026 13:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cMRKDXv7zJrMTk4ZU/ByZDo8aqYydW
	KomBzL28qTgeM=; b=XPLXQ3CgOWdmvWnPmITwczH452oLNOlcV/ad8/2k7sD6bG
	wQFjUeOvTttjdpF7RXC6nRNbYjN6wfxDiy8FDRsIX7pIrT5dKqZ2chMU2S9iRi1a
	j1wufvCYCLa1x7AG9hQF/zacfdanmxtd9PaW/F0NSFqX+jfqYfh9bBkTPtt7SijL
	VcA7tzPCTEHZ17H5yzShtFVlHQ9dCP74hEoKZIlYgvdlUYugIiPTdeN4Qqxr6J6m
	Yxj/TIbXymWQaXv6gF2UnV5+Lub/dnVuMPewtKSiSCvdMAJc72iExXADGGYCMR4k
	KhukO2VaxBFWlxeHUtxYFooKsgbpxBd0VR7Q9xsg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xrcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 13:03:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCuMSe021707;
	Wed, 26 Aug 2026 13:03:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa7q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 13:03:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QD2x3U8585572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 13:02:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D132004E;
	Wed, 26 Aug 2026 13:02:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 269EE20040;
	Wed, 26 Aug 2026 13:02:59 +0000 (GMT)
Received: from osiris (unknown [9.87.128.239])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 13:02:59 +0000 (GMT)
Date: Wed, 26 Aug 2026 15:02:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260826130257.21444B1a-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mnaS2EKAjP2YugpbjqZ_JV0viUasngna
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX7dNqLIMl3+vy
 HKPq5xcApPY6LG90f966XljN0vExanHXKnw3n2i7RjL4lXd3UKVm2CzgT6kefqPy3jnplyAtwYg
 PuOwyi1S6+Zj3LqYSZ/p4uCx3JYHzj0=
X-Proofpoint-GUID: NOqIbWVbZeH7yRovwr2leQYIUW-EgfUw
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ee408 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=WcWu7VMip6P6h1v0TZ8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX64rVuzt7PCA+
 GeD4I9v+CUdWarQxrHoDHukvxbrNmkjxfGyytEEj11RsymxRq1XYin2Vop8Kmtw41X1QiWPQnAZ
 WpYjllVGnkYrQF0WZ1F4qMupF25GU7ZJMuuVuFLjnizScLhrod8bagmtYNOPUEuXQ+eHPiGZ7uQ
 /+VPfODxKMyH/QGHNHm1wI4I+YJMMUk7Hw8M72+rdztcxhbAV+2nGJSFNSD4YyDsa6XS8+gGxu8
 B4CB5J9xP6XmZlxOVTD3o9bvc0imKEOxoOqi0wMt5dJaekQ+mPhsXiOkO6GhiVj1az6tuZpKNCO
 sLfFzQqFLyYXjjLpMy2IxQOmGCjJsreyay+yZJrUOgUiTmh3nx34PLmC9MXx1sCn2vaLwXZAHCF
 pjuTImSG1U/rzpI7BtStwVyKNSIVB9Q4KzRmsHP8JieYTjZMHySl5w+2GbrIVlgX1NWFih7Grh7
 drMddB//EfmV6Ckry9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108

On Wed, Aug 26, 2026 at 02:00:35PM +0200, Alexander Gordeev wrote:
> On Mon, Aug 24, 2026 at 12:40:48PM +0200, Heiko Carstens wrote:
> > On Mon, Aug 17, 2026 at 01:33:00PM +0200, Alexander Gordeev wrote:
> > > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > > index 3b3ecc647993..dba236664da9 100644
> > > --- a/arch/s390/include/asm/lowcore.h
> > > +++ b/arch/s390/include/asm/lowcore.h
> > > @@ -163,7 +163,7 @@ struct lowcore {
> > >  	__s32	preempt_count;			/* 0x03a8 */
> > >  	__u32	spinlock_lockval;		/* 0x03ac */
> > >  	__u32	spinlock_index;			/* 0x03b0 */
> > > -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> > > +	__s32	lazy_mmu_count;			/* 0x03b4 */
> > 
> > Why is this signed? Can it get negative?
> 
> For the same reason preempt_count is signed, I guess.

Check again, preempt_count is now unsigned and 64 bit ;)

> No, it can not get negative and it is very handy to observe
> a disbalance in a crash (I did hit it indeed while debugging).
> 
> > > +static __always_inline bool is_lazy_mmu_active(void)
> > > +{
> > > +	if (__is_defined(__DECOMPRESSOR))
> > > +		return false;
> > > +	if (!get_lowcore()->lazy_mmu_count)
> > > +		return false;
> > 
> > I guess there is opportunity to generate better code here using an
> > alternative and using a flag output constraint too.
> 
> Will try.

Guess that will be quite ugly code. Just let me know if I should
provide that code, since I coded up such a mess already several times.
> > >  void __init arch_cpu_finalize_init(void)
> > >  {
> > > +	lazy_mmu_online_boot_cpu();
> > >  	sclp_init();
> > >  }
> > 
> > What makes this code so special that an explicit call from
> > arch_cpu_finalize_init() is required? This is really the last resort if
> > everything else fails. To me it looks like the code can be changed to use a
> > new static key, and add a generic early (pre-smp) initcall to allocate
> > memory for cpu 0, and if that succeeds enable the static key.
> 
> I had exactly similar variant, but failed to resolve a race when a secondary
> CPU callback was called before the CPU0's one. Probably, used a wrong event.
> Will look into it again.

early_initcall() should do the trick.

> > > +	local_bh_disable();
> > > +
> > > +	lockdep_assert_preemption_disabled();
> > > +	range = this_cpu_read(ipte_range);
> > 
> > Why is it required to disable bottom halves? A comment would be helpful.
> > Or a hint in the commit message - this is not obvious.
> 
> When an interrupt arrives in the middle of enter|leave_ipte_range()
> the chain pcpu_addr_to_page() -> vmalloc_to_page() -> ptep_get()
> decides ptep_get() is called in lazy mode, while the per-cpu state
> not yet (de-)initialized (AKA inconsistent). That led to crashes:

So, I don't know what exactly lead to the crash, but I guess the
problem is an only partially initialized ipte_range struct, while the
lazy_mmu_count has been incremented already? Isn't it possible to
solve that problem without disabling bottom halves by reordering
sequences in enter_ipte_range() and leave_ipte_range()?

Would be nice if we could avoid the not so obvious local_bh_disable()
and local_bh_enable() pairs.
