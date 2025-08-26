Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71F2EAD0D;
	Tue, 26 Aug 2025 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185641; cv=none; b=D4UyZGqHlDDqKUsihoyCasx+yPt4L+gXdwy+mTsK20A5rD/hYaMzLkfgxPEMQOw3D0MzJbkrmF6HUW/XcmRmvt1Y9RCvA2TKXmTOl4FFto2A9IDOSt3Zuf60cG2RGOSi74PWdTJ+kUrDCRHJf5EKiyuuU6gZNG7omVp3V7XMTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185641; c=relaxed/simple;
	bh=QoNtvafQXAB75SR7IP1iwLZhZ4FNhhB8vGd1/nJWwUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzZ4axTY+ZCbu33pm9tA4J33ubNAAJ6tIghsX+1O9Cv7TtZcyPtMdI5fR8vdH10v26ujLJSq3WK9LqHQf+RHndhS3v1mJMyuupgn/p/p2YkGaILS8751rZ21krvymf8ikp501hrlhIqOCZ11U3VIlB5jQZEwJVc5Qu1y0MbXIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9wm35hHkz9sSW;
	Tue, 26 Aug 2025 07:13:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3zqoWmt2kyq; Tue, 26 Aug 2025 07:13:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9wm34Kgtz9sSV;
	Tue, 26 Aug 2025 07:13:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 755518B764;
	Tue, 26 Aug 2025 07:13:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id db8ZhuQxPbOU; Tue, 26 Aug 2025 07:13:07 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 760E08B763;
	Tue, 26 Aug 2025 07:13:05 +0200 (CEST)
Message-ID: <d2ccc708-ab0e-4d25-8fc9-f989cdd0ae55@csgroup.eu>
Date: Tue, 26 Aug 2025 07:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] sched/topology: Unify tl_smt_mask() across core
 and all arch
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
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
 Andrea Righi <arighi@nvidia.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-6-kprateek.nayak@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826041319.1284-6-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> Unify the tl_smt_mask() wrapper around cpu_smt_mask() across core, x86,
> ppc, and s390.
> 
> On s390, include/linux/topology.c defines an explicit cpu_smt_mask()
> wrapper around topology_sibling_cpumask() when cpu_smt_mask() is not
> defined by the arch/ bits and topology_sibling_cpumask() on s390 returns
> &cpu_topology[cpu].thread_mask.
> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/powerpc/kernel/smp.c      | 5 -----
>   arch/s390/kernel/topology.c    | 8 +-------
>   arch/x86/kernel/smpboot.c      | 5 -----
>   include/linux/sched/topology.h | 8 +++++++-
>   kernel/sched/topology.c        | 7 -------
>   5 files changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 7f79b853b221..c58ddf84fe63 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1038,11 +1038,6 @@ static const struct cpumask *smallcore_smt_mask(struct sched_domain_topology_lev
>   {
>   	return cpu_smallcore_mask(cpu);
>   }
> -
> -static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_smt_mask(cpu);
> -}
>   #endif
>   
>   static struct cpumask *cpu_corgrp_mask(int cpu)
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 5129e3ffa7f5..c88eda847309 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -509,12 +509,6 @@ int topology_cpu_init(struct cpu *cpu)
>   	return rc;
>   }
>   
> -static const struct cpumask *cpu_thread_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return &cpu_topology[cpu].thread_mask;
> -}
> -
> -
>   const struct cpumask *cpu_coregroup_mask(int cpu)
>   {
>   	return &cpu_topology[cpu].core_mask;
> @@ -541,7 +535,7 @@ static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl
>   }
>   
>   static struct sched_domain_topology_level s390_topology[] = {
> -	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
> +	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
>   	SDTL_INIT(cpu_mc_mask, cpu_core_flags, MC),
>   	SDTL_INIT(cpu_book_mask, NULL, BOOK),
>   	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 4cd3d69741cf..03ff6270966a 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -463,11 +463,6 @@ static int x86_core_flags(void)
>   {
>   	return cpu_core_flags() | x86_sched_itmt_flags();
>   }
> -
> -static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_smt_mask(cpu);
> -}
>   #endif
>   
>   #ifdef CONFIG_SCHED_CLUSTER
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 602508130c8a..d75fbb7d9667 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -37,7 +37,13 @@ static inline int cpu_smt_flags(void)
>   {
>   	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>   }
> -#endif
> +
> +static const __maybe_unused
> +struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)

__maybe_unused hides the dust under the carpet.

Leave the function in kernel/sched/topology.c and make it non-static 
with a prototype in linux/sched/topology.h

> +{
> +	return cpu_smt_mask(cpu);
> +}
> +#endif /* CONFIG_SCHED_SMT */
>   
>   #ifdef CONFIG_SCHED_CLUSTER
>   static inline int cpu_cluster_flags(void)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index dfc754e0668c..92165fe56a2d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1724,13 +1724,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   	return sd;
>   }
>   
> -#ifdef CONFIG_SCHED_SMT
> -static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_smt_mask(cpu);
> -}
> -#endif
> -
>   #ifdef CONFIG_SCHED_CLUSTER
>   static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
>   {

