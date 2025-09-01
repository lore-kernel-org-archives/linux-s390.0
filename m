Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068242FFDDC;
	Mon,  1 Sep 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717130; cv=none; b=iBnZ8xpaSGDiT9RH7j/1LCUYPoQdBDfGPHcX0zV3o1gFvVSuAKzr0HfBVcGFPKDmnOLON3wGwZ/8WYOMh/GYiMXCYcH6M/eorWzE96629fc9d8hw3t8Pl469f2ETl/VvTXshvGh0Mggk5sZaYOdMAKpAySMbGoUOU3smdnPJ23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717130; c=relaxed/simple;
	bh=InXgBzKhkx7pDLC/UHg7AOWfDsfg22kfeusZjuMAjAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmzLmRx/8blzmIEVJfZyeIkBpta3+LTeBF2WCHko9hWHrIzoAQds5dRXiRAGxv5fZjzGUMR6U180tpJEaP49+PUJh77YO3penIBa2RhbySmcR1d7MXsutF6GNprdNrvl5s2wPxyL7vZDS1UyVBIv2AVdj7nWiKUG0Z9xKnj88xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UT+w+3il; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UT+w+3il"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ELXcS4kuUmNY0mNJAeIrv8bpfUT+7O0FMeM9giGQ16Q=; b=UT+w+3ilhmZ+76H+urMqJ6Hsrd
	/xfgAuPhxfKGbWSVeTe/Aw9uUNWYzqaoq3v5yiHoutCJeSARcDUyYKAxGZM4CRG8zJwDS2Wqv01F/
	qWaQ6BipmwycC3OwpGnuVBMr3BlroIg1lki85OuJs1mgzdpi1lZrKQmrY9dgBy/L3fPySfABazIos
	1sbx5FtHVpXgG9gw7SXaUFg2XsFkqC3u1a9fHIuCXfyV2lqLj5zlj/d5eZkBXsuJBqBdNm9sO0XXX
	TKdrhTHXgKSbliK9avGEYM8DKpLOK6oAX/G7p9a0UwLXE0CsIcmvPDSpicBl/64VfEYH8GCc6Xy/J
	xHhUM9YQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut0Mi-00000003gYr-0NpU;
	Mon, 01 Sep 2025 08:58:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 96847300342; Mon, 01 Sep 2025 10:58:15 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:58:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>,
	Bibo Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andrea Righi <arighi@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 0/8] sched/fair: Get rid of sched_domains_curr_level
 hack for tl->cpumask()
Message-ID: <20250901085815.GE4067720@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <b64c820d-084a-40d9-bb4e-82986b9e6482@linux.ibm.com>
 <20250826101328.GV4067720@noisy.programming.kicks-ass.net>
 <xhsmh7bymlg2f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <5ec9ca8a-9ba9-4600-a7a2-f7bd790fca83@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec9ca8a-9ba9-4600-a7a2-f7bd790fca83@linux.ibm.com>

On Fri, Aug 29, 2025 at 02:23:06PM +0530, Shrikanth Hegde wrote:

> I was looking at: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core
> 
> Current code doesn't allow one to enable/disable SCHED_MC on ppc since it is set always in kconfig.
> Used the below patch:
> 
> I think since the config is there, it would be good to provide a option to disable. no?

So current PPC code has this MC thing unconditional. I've been
preserving that behaviour. If PPC maintainers feel they want this
selectable, I'm happy to include something like the below, but as a
separate patch with a separate changelog that states this explicit
choice.

> ---
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index fc0d1c19f5a1..da5b2f8d3686 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -170,9 +170,8 @@ config PPC
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
> -	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
>  	select ARCH_SUPPORTS_SCHED_MC		if PPC64 && SMP
> -	select SCHED_MC				if ARCH_SUPPORTS_SCHED_MC
> +	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
>  	select ARCH_USE_MEMTEST
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 68edb66c2964..458ec5bd859e 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1706,10 +1706,12 @@ static void __init build_sched_topology(void)
>  			SDTL_INIT(tl_cache_mask, powerpc_shared_cache_flags, CACHE);
>  	}
> +#ifdef CONFIG_SCHED_MC
>  	if (has_coregroup_support()) {
>  		powerpc_topology[i++] =
>  			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
>  	}
> +#endif
>  	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
> 
