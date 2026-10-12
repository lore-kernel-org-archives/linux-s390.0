Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCC492512
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816580; cv=pass; b=cC2jXckKTFdHlGvAObLsg/x5mYChyzY8inhbAlf7pJtjpcZ2K+ZbOTSPjD5KAav0IkLREs2ZSfNhw3vY10kjBG6Qf+Vwvcs4VI2G7EDPL5mhczxvkpzYdLfUcuhW/Y4fekdZ9T+DWO9sd178MhTYfL8PKTIw6UJLxKfwY0DKoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816580; c=relaxed/simple;
	bh=sKBgSzTYU033t4LYXBsn6CmXDo5tF/aJYwgKpZ7dQpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idNx6/j7+PPbaGOIEH1vwMNr9SjW0S8pTjp9ORH0I/c/7G4LRNLBuspEXAjzPyli+JQqkOECmy+nPCOcif6AycuzVk1CQBL+bHiWPBQq/I33KKJWOz6RE+TS75oBC7vP2kaRYefBX/ToTfRuuJjw0+DEz+P2pXH8N0fMf25xq6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cao1OL54; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cao1OL54"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e5f8fe879so317050566b.3
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 07:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816577; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2nnxGQHZNCi2sJW6ShkmWEJblW7clsGk9y+iA5W0HmTbGifKYTELdE6TkNxHiin3G
         sTJzb9DPXYwduyyEP2CHH61B2UF+6QiunDdyd9qFFwB3UeX79Q/doqhMMH67Hm5FpGm/
         R1j0//4Uwr9ov+hYCl0WvdUoudVGDUujJ4PBTYzo1e7C43Y1Cqa++k7DJzo3fB02TMrQ
         FlLo12fg4Df3pS4oRg+tZGC63jC2WcxV4QXdPaeD9QhziBW3uhveT+EJ+Jb08+12jcRU
         V7fEuukr4PGvxAxBzlaHP4z8fMZRwkvXMs8kxOibIjzyyx4Mhiz73dHndltEAoKQKzKu
         c0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o6kt5sxQxEd1IeZHNY2Emi/Ix9odRnAqO5gpURKPws0=;
        fh=QeMRpBdDE1OtIyen81346MOxLF6YOtNSmfC7PBD71jw=;
        b=RXsdeUprmFJnvyYadeS3lmS/TcE67TSikzTvnwIycoWVnKoXs1yX2LKNFQLy4K+274
         MW3P7ZvFL8E75OtIx8KK8UlCAC4vP7FWARY8XzOSYJbQp9IlabOChuHP08TDO/XX4np8
         l8hpKYI70RhOCod5Cq5dQ1Bud5SQv5Ioz940LUNbJ/Nj40KRzUiR9MVWWJwvm2XDUYsy
         cgNYkzrlnGIyhkG+nRiJsbXrkQcr5ddjgBUJj72IuxYsWWvOZSZsv3LG1YUyhZTT9bhJ
         Qv7ZE4xoBN8n230EOX4LWblNF0Nkq6mhokFiRQVyNMFi7SIsUf5kJiBVgnEwN0oN3VEK
         hOVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791816577; x=1792421377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6kt5sxQxEd1IeZHNY2Emi/Ix9odRnAqO5gpURKPws0=;
        b=Cao1OL54v8BNjN57nw9Gwekmdz9CIJah/7+PG/E9GVyWtrr1aOuvh45h3FaQv6Q2qf
         jVUuzi4cUkAKR7jM0gu56yTCvyqf61MZ6qPMNHsiKoRXC5ePqTCeT21UHldkJ4Jc2+Ow
         lxepZ9kSc20lXD8dIRCTwnUMdp+4MtoZactqJLksDpIrl2l76n1jhpsK7VTVgA8BUcI5
         g0r4Oegm1IFsac8+bGBfCXIIcs8EPd7Z9CVH0biuxEXf+gfG62YIc227tZfAJyf/oQIp
         H0qvSAo6qRVCNeoVRLZG2yl446o9DjMVVaAh3jVeauzdO+eEB3FrN5y7I+VB2qS0Ij19
         Cqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816577; x=1792421377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o6kt5sxQxEd1IeZHNY2Emi/Ix9odRnAqO5gpURKPws0=;
        b=lVaulGxfEH6Ji5GWk2utZ9zlOYDpXI5d1+kWB0lcHc+Ag1iLmtqrMenz4aPTVVjkcR
         vxJIsVp5SFt0JUD2aeuKYgTyzo/ZRVdrmLTm7ze2Eaamf0JbJvOj5Xxa704/6PJojrBZ
         yZaLNcSrlTXkLnEJj/thZyr3FOYBhFh4TR6qpYA4yqxdqctO1MAgtXIEcJlLYTJWLCiG
         lO/qlXItqzwsUxY9SINPmhHMzUHIpSqRtqy614QtN2GOXhj2xJFPTMKRjBZNbZHAm6co
         LLbQXFPut1tF1wAr0DWxCAG+ZJx/N7g2uVOXffzgqRTGHFt10U6birrd6C/VWPrSFkOA
         O3Hw==
X-Forwarded-Encrypted: i=1; AKwUvBxp6FFlvmm0C9Zs3NTVqpUURADWHadVghtViJsz6PS5EMngQCcrE8cLdUdmSds3zRoG7clCPW9iXMHr@vger.kernel.org
X-Gm-Message-State: AFq9FYKTpGB2S5FCxn7DBY22HF1kr+JlMVsAwnW8H8yZ0U6F5UteBVRp
	ehMTzF00UlHzQurrLVJ4t9laoUeYbjQOf7SGxP8weQHQ8x++RbKgpPLFvqSJuAqHnf0xFjV9rQ2
	877AgnKpHQlbp+3SCvi3qDBGs+fxLfM9oiGwjUPn5lA==
X-Gm-Gg: AYBFou3gIe/aaL4Us8r7aT5ZECJTx2hj80Ukcl8sBdNitReV0SMZ7JybyPGyNPwdoFI
	igU3vl1djsSb1S9HU+UEHgmtkNt5zpC+kDhvhFnWpfeJXud3g7ezXHHNsgiROAaeOkFf5Z7Dc7o
	uYhpC6M0f3trq1B0SQ60zR6/QNHt+ho2NwUTntHwlsaC+aKdiLttcVUd0xqhkR5EnPpp0gUyhHA
	J1qyIJH+nsHFV0900XSjwAeLbTsi14AEAPOLAS5PaWhSdDABIjiu9+7JFZGJONd8L+cCyrsIy7t
	GoDGd/gESS9nf5Vp5UR4Zi0GFAO7vInBVx1sAKEtlbT0R0fxM/mNbEdhqeWu1nHjwbMhj/1Oem2
	yK5Y5nJHHigg=
X-Received: by 2002:a17:907:2da9:b0:c20:af9d:4533 with SMTP id
 a640c23a62f3a-c31aa022dd3mr979980166b.19.1791816575661; Mon, 12 Oct 2026
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com> <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
 <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
In-Reply-To: <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Oct 2026 16:49:23 +0200
X-Gm-Features: AclHuK--DkxB95BT203G4DHhuJ4NrrL_B5_NJsMlLldXjfXFADXDQ_ENLFySR4A
Message-ID: <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Mete Durlu <meted@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Chen Yu <yu.c.chen@intel.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 13:04, Mete Durlu <meted@linux.ibm.com> wrote:
>
> On 09/10/2026 17:32, Vincent Guittot wrote:
> > On Thu, 8 Oct 2026 at 17:25, Mete Durlu <meted@linux.ibm.com> wrote:
> >>
> >> On 08/10/2026 16:58, Shrikanth Hegde wrote:
> >>> Hi Meter/Andrea.
> >>>
> >>> On 10/8/26 5:40 PM, Andrea Righi wrote:
> >>>> Hi Mete,
> >>>>
> >>>> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
> >>>>> Summary
> >>>>> ===========================================================================
> >>>>> On systems with asymmetric CPU capacities, the scheduler prefers
> >>>>> fully idle
> >>>>> cores over idle SMT siblings of busy cores. This works generally well
> >>>>> but
> >>>>> virtualized platforms where low capacity cores should be avoided are not
> >>>>> considered. Introduce a new config option and arch hook to prioritize
> >>>>> SMT utilization.
> >>>
> >>> That's true only under physical CPU contention right? or is it always?
> >>
> >> Right, because of that s390 treats all CPUs as equal and starts to
> >> assign lower capacities to CPUs with low entitlement once a certain
> >> steal time threshold is crossed (aka physical CPU contention).
>
> Hi,
> Sorry for causing a misunderstanding. I should have been more patient
> and detailed while writing my reply.
>
> > I'm not sure to get what your topology is because "if s390 treats all
> > CPUs as equal"  then you should never use select_idle_capacity()
> > because  their capacity should be fixed and equal and
> > SD_ASYM_CPUCAPACITY_FULL never set.
>
> On s390 the entitlement of the vCPUs are signified by an arch specific
> value we call polarization. We can tell which vCPUs are assigned high
> and low entitlement. This entitlement value tells us which vCPUs are
> prone to experience steal time first. Without any contention all
> vCPUs behave and perform *almost* the same(of course, we want
> some priority for CPUs with high entitlement).
>
> Prior to experiencing steal time(it's what we use to determine
> contention) to get the most out of the system we assign all vCPUs
> the same capacities, making the system symmetric like you say.
> While there is no contention s390's vCPUs also perform better if
> fully idle cores are selected for task placement.
>
> > If your hypervisor lowers the capacity once a certain threshold is
> > crossed, we already account for the steal time in the scheduler with
> > irq and remove it from the capacity available for tasks but the
> > original capacity doesn't change.
> s390's linux implementation has a mechanism called hiperdispatch,
> that checks topology changes along with system steal time (and soon
> the total free capacity of the pyhsical machine) periodically and
> makes vCPU capacity adjustments accordingly.
>
> After steal time starts ramping up and cross a certain threshold,
> we start assigning lower capacities to vCPUs with low entitlement to
> hint the scheduler that they should be avoided.

If all your vCPUs starts with the same capacity, you should not use
asym_capacity or enabled it . What you describe above is system
pressure (steal time or other) on your vCPU that change over time but
not a capacity change. The value returned by arch_scale_cpu_capacity
is not supposed to change at runtime or you need to rebuild the
sched_domain topology. As an example, max_allowed_capacity does assume
capacity fixed otherwise the misfit detection will sometimes fails.

What you describe really fit into the prefered core that Shrikanth
Hegde has developped

> In this asymmetric configuration, utilizing low capacity but fully idle
> cores hurt performance. Instead packing the tasks first to SMT siblings
> of high capacity cores would give s390 a lot of benefit.
>
> I hope that clears some of the fog that I unintentionally created.
>
> [..snip..]
>
