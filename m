Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED863EF650;
	Wed, 25 Mar 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455633; cv=none; b=txm2BNewhzM8qF7o6yCLsBNo3JDOxpRJnwU3ALlfdKZhHVRzAFlvEVF8BCJe82rRXDQHjHcOY6hPZA7DIwhYHGTIeGl4hka63FtL1xG3FlJ6HOut18y5JB7tIsYWFOOVaIZXI2So96ktKclyo8OdrH0buIIBGZhxErGAx9BLEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455633; c=relaxed/simple;
	bh=/Nl7ilmGuJDcNzMHWLNnleaSc10K3Ruuk9FbrSfxiUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7+LIfdGx94199wFbx9uCdnuvqQU0zeRX2+HVc5pMBWTdXNTrIuF6mGi7xlmFBhKvvZkLelA00nsDOHVeuYyjZEK/4hPF5TurNJ/SLuXqfYbFunO8HdeYCDNcL4pdEP/Mo0WHi71xx0xcTOGc54h2Vq2p84q0xHnthGU0Rr8uTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZZDIXt7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kZZDIXt7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3O4Td3189918;
	Wed, 25 Mar 2026 16:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UKAdTMpd2psr2ZVs6jscsxEONjlFsU
	jOIx1eQLvo0Qo=; b=kZZDIXt7cHCuMOVJ5Tnzo7drzXEGX8T3gKWeO0sHNCrlAV
	5Aom1awBSMrGmQXDOWDI7j4drjKNdYMMM5I6HvtR9jiEqizg4z8JlYLnh+eR6dVw
	EDb/OvbIzhgXesFl2tqOsbyK3j9xRJZ8L1fDA1BzGoQkbqh+bND9A7FTabOwijDW
	GIu+y2KaTRczF9ZEvxSrpLUjht3QJN3elNgodi4BFqophfk5rnYgXWlqn73O4vJL
	7sY30K3PXoZjGnOaYUPBdAkqAVV067YI96YtSgswiV+hjhTnsiiXsV9ZUxzL0szJ
	PrUAw+YtRUgt17xwTMEV8h4UUkT1RNYVJMUUvs4w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa1b7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:20:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFIJAJ008732;
	Wed, 25 Mar 2026 16:20:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnq94a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:20:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PGK11h51970504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 16:20:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767D020043;
	Wed, 25 Mar 2026 16:20:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9DE2004B;
	Wed, 25 Mar 2026 16:20:01 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Mar 2026 16:20:01 +0000 (GMT)
Date: Wed, 25 Mar 2026 17:20:00 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yL58iBxIX8XO1NVeYsxW9NJdtgDshetF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExNCBTYWx0ZWRfX+V4Qloa/gD73
 8QOTBINLCysTn37RJK+r1HJinZJCZDCY2V6eGnQ/9nakaijuobBPzo3EvAeLR8D0+R7lZ1v+1mr
 CKcccZ0bp4oSACchVpUty4hdVtqxEVkoO3pjAOf/TyvhzPPsd19/+IOhnmhwyvwsRlalxtlBOL0
 L+e0lrj6AeUaU8M6/+WZbcwvZGGaRn7WTILGi+d3NSxBeqAP5BioMZrafcT1FqK3o5gAHbpNPEG
 n67VaZyp/EhqC+5M/+eQ3qWG751zuN37ZAXNRs4kLSsO5x9sNv1OqHCvlSu2r+DB8BNSHR8OtgK
 4aOXhYJFu5BokNFkCgx3pBvetwRTxPRQcFQN8+Lr7kQYiz47rhkb35JAJCXRYp/6E5bYRvO1GLk
 qDfqDWJgbrKdRA/Sml0cA1wZTOPx6CIEjxFDqrxMXqeWt5hGnQKhgQ3H3+iZxClsl4JWJDQU7bs
 d3el5u81Yl7BAFtc1OQ==
X-Proofpoint-GUID: yL58iBxIX8XO1NVeYsxW9NJdtgDshetF
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c40b37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VemTcPfm9ugi35iZvo4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250114

On Wed, Mar 25, 2026 at 10:55:23AM +0100, David Hildenbrand (Arm) wrote:

Hi David,

> > +/**
> > + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
> 
> You have to be a lot clearer about implications. For example, what
> happens if we would bail out and not process all ptes? What are the
> exact semantics.

The only implication is "only this address/PTE range could be updated
and that range may span one page table at most".

Whether all or portion of PTEs were actually updated is not defined,
just like in case of lazy_mmu_mode_enable_pte().

Makes sense?

> > + * Enters a new lazy MMU mode section; if the mode was not already enabled,
> > + * enables it and calls arch_enter_lazy_mmu_mode_pte().
> > + *
> > + * Must be paired with a call to lazy_mmu_mode_disable().
> > + *
> > + * Has no effect if called:
> > + * - While paused - see lazy_mmu_mode_pause()
> > + * - In interrupt context
> > + */
> > +static inline void lazy_mmu_mode_enable_pte(struct mm_struct *mm,
> > +					    unsigned long addr,
> > +					    unsigned long end,
> > +					    pte_t *ptep)
> 
> It can be multiple ptes, so should this be some kind of "pte_range"/
> 
> lazy_mmu_mode_enable_for_pte_range()
> 
> A bit mouthful but clearer.
> 
> > +{
> > +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
> > +
> > +	if (in_interrupt() || state->pause_count > 0)
> > +		return;
> > +
> > +	VM_WARN_ON_ONCE(state->enable_count == U8_MAX);
> > +
> > +	if (state->enable_count++ == 0)
> > +		arch_enter_lazy_mmu_mode_pte(mm, addr, end, ptep);

I will also change arch_enter_lazy_mmu_mode_pte() to
arch_enter_lazy_mmu_mode_for_pte_range() then.

> > +}
> 
> I'm wondering whether that could instead be some optional interface that
> we trigger after the lazy_mmu_mode_enable. But looking at

To me just two separate and (as you put it) mouthful names appeal better
than an optional follow-up interface.

> lazy_mmu_mode_enable() users, there don't seem to be cases where we
> would process multiple different ranges under a single enable() call, right?

Multiple different ranges still could be processed, but then one should
continue using arch_enter_lazy_mmu_mode(). E.g. these were less obvious
than traditional walkers and left them intact:

	mm/migrate_device.c
	mm/tests/lazy_mmu_mode_kunit.c
	mm/userfaultfd.c
	mm/vmscan.c

> -- 
> Cheers,
> 
> David

Thanks for the quick review!

