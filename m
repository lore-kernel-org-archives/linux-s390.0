Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605A4E66D6;
	Thu,  3 Sep 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450230; cv=none; b=ewJARehbPOFPARfvyoxRuvO5MG+maObuJvznj6WTPObM0kD9iQZ7Kj0cNTYMHh7mmZypyZzyxpjHRJ1PLQy6mPXYA7l9xYdJ+ilgFwsirAye7BZXHHsebryJf7ubbLK9XF2c8uWLggtdNaJV1Mnm7sqtRZ6pGysIGKoXwZ4azH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450230; c=relaxed/simple;
	bh=fvUIuDsf+eRAezG3LZxo95EFORPdrXdVcotZ9dhTwnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYr/LplPCaoV0dJ2biO2eo0BZ+Xi6uSOAoHWUPmA+RBjYv+LKtIFvisLc0VOo0xe6ZnbHVoCWhIFSyqzqwuFtNcvhCEmU5v+fCqDbH68nOxGnd5/7rfKdZdCg3YiLm/HhVAJEWtDNd+Cs0He6UnjFf6dNRb5i5Wzy/HQhHljadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qq24X760; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qq24X760"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DVYJ73109269;
	Thu, 3 Sep 2026 15:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DWerPAyDUDODY4bzH6HwfhgrgXW1pL
	fFq/LiqQBYcJs=; b=qq24X760XG8SoNn1gFX3oshVvnMjFEOOpcHiPJvHzMytMk
	9A1DdWNuD6WTrMor7DuMsBdoyMWRCWsAIFdY5nfUmh8LRDwQ9nxys+JBwydX44Fi
	31Y0XmohUmw7JDOre5wCb/be6CgpRNRyxkX7K/drbUnYKkWiowPOTbIIyDMpiate
	EfuuJwqIggzkhsp15O3EZn2OvxOUxvTJxCGjag/SFGyoXZDEMilrnNWCNiDFIg8G
	LsuVv9XSBU5aQRC1A2MfqzLJWKUCj0CngpB97bOooDf1JpZspwGuDj9HUrdKFGaF
	9dC+khEmvnMAKnR7RVE/O2/fLS/HvXYqYZAJB6LA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq555rf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 15:43:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683FfOT3022323;
	Thu, 3 Sep 2026 15:43:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkgakn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 15:43:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683FhK5L45285742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 15:43:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E201D20043;
	Thu,  3 Sep 2026 15:43:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D5420040;
	Thu,  3 Sep 2026 15:43:18 +0000 (GMT)
Received: from osiris (unknown [9.111.48.84])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 15:43:18 +0000 (GMT)
Date: Thu, 3 Sep 2026 17:43:17 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig
 and Makefile
Message-ID: <20260903154317.246414-A-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com>
 <20260903083857.33034-B-seiden@linux.ibm.com>
 <apmHrnxRLl9BuVhn@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmHrnxRLl9BuVhn@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX+tCRhA6sSIdG
 wH3YsOZWUu6AQ/wbZMy8/8ghxOMLr1JxUYI+F1OuGF3kGMSyFosb1yyEw0Y7SkcdnViRSIGYST3
 ZKzsuk/yTqkbV86fiBlmnquLGrE/lVjUqJoxxitxftnkHOk9tg0lf6UwUpP94HGjN1haIu/bhvZ
 vOjQqtsKKo3dH3KxPYftRTR6hCAXVZpNywqL9ZPSpumpJiusj9HVTq0eQdDyz3eQ1Y+gGxJro8l
 V2dWzLn9xp09A0JVmcSAwV5VZkpGjRK8hm3znkN8FXKMdHOmzNczDGuN9kP/yvuCNwH57VbneZM
 WEDh5Ny5+ief11kwh0eU7+kEY7iwpp9c1n+1CClsNVzgNsl+fZbs6Pd5fvFvzq6se5TMWk43mLh
 uszJimiwEQpCccZNeyi83N0rlUhjKo2WddPiM755LR8fWAqvO5pRdcfFJgQxorwDdCF16OL+1fQ
 UEO/8fVhwbjCETjz5gQ==
X-Proofpoint-ORIG-GUID: 6z-LCHu0Gt_XtkyXQSEc2p12x2-m7GXw
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99959d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Jmw6T6Sfydnll6L029oA:9
 a=_V_nbmSO25lDuQpK:21 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 06nC8yppQ2lADCC-CvXlhYKMn3c0SHeb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfXwZdhsr6ocdVw
 ZR7eud7oQqfLtMVdQYGpum3xVFBPSPw1xK66LdD+ib0PYULKbLIrhBbbCd9swU012WkLAvvNJ10
 yXfvzYmcZAkKdMmaJwVBzlHe/P2gUkw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030135

On Thu, Sep 03, 2026 at 07:43:58AM -0700, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Steffen Eiden wrote:
> > On Wed, Sep 02, 2026 at 09:20:23AM -0700, Sean Christopherson wrote:
> > > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > > diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> > > > index 8d3ee17a1bcb..9c69ea16031e 100644
> > > > --- a/arch/s390/kvm/Kconfig
> > > > +++ b/arch/s390/kvm/Kconfig
> > > > @@ -53,4 +53,33 @@ config KVM_S390_UCONTROL
> > > >  
> > > >  	  If unsure, say N.
> > > >  
> > > > +config KVM_S390_ARM64
> > > > +	def_tristate y
> > > > +	prompt "KVM support for hardware accelerated arm64 guests"
> > > > +	depends on HAS_IOMEM
> > > > +	depends on KVM
> > > 
> > > Is this actually necessary?  I.e. does kvm.ko need to be *loaded* in order for
> > > kvm-arm64.ko to be loaded?
> > > 
> > > If kvm-arm64.ko does indeed have a hard dependency on kvm.ko, then I think it
> > > makes sense to not have redundant "select" statements below.  As an outsider,
> > > it's super confusing because the KVM_S390_ARM64 are incomplete, e.g. are lacking
> > > things like VIRT_XFER_TO_GUEST_WORK (at least, I assume those are lacking), and
> > > makes it hard to see what is actually unique to kvm-arm64.ko.
> > > 
> > > If kvm-arm64.ko doesn't have a dependency on kvm.ko, e.g. to initialize hardware
> > > or something, then this "depends on" should go away.
> > 
> > 
> > It is a bit more complicated unfortunately. KVM_S390_ARM64 depends on
> > KVM as there is code around in the kernel & drivers (arch and common)
> > which depends on CONFIG_KVM we need as well. I did not want to leak arch
> > local configs to common code if I can avoid that.
> > I could change it to select KVM ? Do you have another idea on how to
> > solve this issue?
> 
> I would do something similar to what KVM x86 does.
> 
> > The two modules are completely independent at compile and runtime. So
> > kvm does not have to be loaded for kvm-arm64 to work.
> > 
> > VIRT_XFER_TO_GUEST_WORK is only lacking for now. I will add it later.
> > Currently the kvm-arm64 module is incomplete anyways but I did not want
> > to send a 60+patches series and rather stage the introduction over
> > multiple series.
> > 
> > I will remove the duplicated config selections. Thanks for pointing it
> > out. In previous series I had an explicit KVM_S390 config. Both KVM_S390
> > and KVM_ARM64 selected KVM. But this created too much churn around the
> > whole tech-stack 
> 
> LOL, what exactly are you expecting to happen?  You're trying to squeeze support
> in for a completely different architecture, of course there's going to be churn.
> 
> This absolutely needs to be as precisely and correct as possible, otherwise it'll
> be painfully difficult to maintain,  And to some extent, just for others to review.
> E.g. as is, it's at all not clear to me which of the IS_ENABLED(CONFIG_KVM) checks
> in arch/s390 apply to both flavors of virtualization, versus which are specific to
> "native" s390 virtualization.
> 
> I realize this is outside of my immediate scope, but getting this "right" isn't
> just an s390 thing, because these details bleed into common KVM, and even affect
> other architectures, e.g. when trying to make "treewide" KVM changes.

I want to find the 'right' way as well - any ideas are welcome.

> 
> And FWIW, while it might seem daunting, from my perspective it's not actually that
> much churn to do things "right".  Provide KVM_S390_NATIVE, and then have KVM reflect
> the "weakest" of S390_NATIVE vs. S390_ARCH.  I.e. make KVM=m if either of the "real"
> KVMs will be a module.  That requires some creative shenanigans, but it's not hard,
> just weird.

FYI the first versions of this series had a 3 configs approach very
similar to yours. 

IIRC it was not so much the churn we have in (upstream) kernel code but
more on the distro side and to everyone building the kernel in their
favourite architecture (s390 :))
Suddenly the KVM config changed its behaviour (effectively becoming a noop)

I am starting to think that having no separate config option for arm on
s390 might be the easisest way. Just KVM and guard both modules behind
it. It reduces the config space bloat and I do not see a reason why somoeone
should only compile one KVM module but not the other. kvm-arm64 won't
load if you do not have the hardware anyways.

But I am not opposed to the x86 approach. Just thinking loud.

Anyways, I am off for vacation expect a reduced reply frequency from my
side :) 

	Steffen
> 
> > (default config change, s390 is the odd one out for the KVM config meaning, ...).
> 
> Nah, x86 is the odd one, where CONFIG_KVM=m doesn't even guarantee kvm.ko gets
> built :-)
> 
> E.g. something like this, which probably doesn't compile and isn't the desired
> end state, as several of the Kconfig selections need to be reworked into #defines
> provided by header files, but AFAICT it does what I want/intend.
> 
> config KVM
> 	def_tristate m if (KVM_S390_NATIVE = m || KVM_S390_ARM64 = m)
> 	select HAVE_KVM_CPU_RELAX_INTERCEPT
> 	select KVM_COMMON
> 	select HAVE_KVM_IRQCHIP
> 	select HAVE_KVM_IRQ_ROUTING
> 	select KVM_VFIO
> 	select VIRT_XFER_TO_GUEST_WORK
> 
> config KVM_S390_NATIVE
> 	def_tristate y
> 	prompt "Kernel-based Virtual Machine (KVM) support"
> 	select KVM if (y && KVM_S390_ARM64 != m)
> 	select KVM_ASYNC_PF
> 	select KVM_ASYNC_PF_SYNC
> 	select HAVE_KVM_NO_POLL
> 	select KVM_MMU_LOCKLESS_AGING
> 	select KVM_GENERIC_PRE_FAULT_MEMORY
> 	select HAVE_KVM_INVALID_WAKEUPS
> 	help
> 	  Support hosting paravirtualized guest machines using the SIE
> 	  virtualization capability on the mainframe. This should work
> 	  on any 64bit machine.
> 
> 	  This module provides access to the hardware capabilities through
> 	  a character device node named /dev/kvm.
> 
> 	  To compile this as a module, choose M here: the module
> 	  will be called kvm.
> 
> 	  If unsure, say N.
> 
> config KVM_S390_UCONTROL
> 	bool "Userspace controlled virtual machines"
> 	depends on KVM
> 	help
> 	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
> 	  controlled by userspace.
> 
> 	  If unsure, say N.
> 
> config KVM_S390_ARM64
> 	def_tristate y
> 	prompt "KVM support for hardware accelerated arm64 guests"
> 	depends on HAS_IOMEM
> 	select KVM if (y && KVM_S390_NATIVE != m)
> 	select GUEST_PERF_EVENTS if PERF_EVENTS
> 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
> 	select HAVE_KVM_IRQ_BYPASS
> 	select KVM_MMIO
> 	select SCHED_INFO
> 	select XARRAY_MULTI
> 	help
> 	  Enable support for hosting virtualized, hardware-accelerated arm64
> 	  virtual machines on s390 systems using the Start ARM Execution (SAE)
> 	  instruction. This requires hardware models that support the Arm
> 	  execution facility (AEF).
> 
> 	  The module provides a character device named /dev/kvm-arm64 to expose
> 	  the hardware capabilities.
> 
> 	  To compile this driver as a module, choose M here. The module will
> 	  be called kvm-arm64.
> 
> 	  If unsure, say N.
