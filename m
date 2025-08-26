Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323986342;
	Tue, 26 Aug 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187443; cv=none; b=ZiLFMXjDRmUCglzTig46/fNxuKw54FruuyULM1nKEzIi5cV5dFDUo7mW0Ehz9EQbStFqIuHMvl8qx7Plzdsm3AjfA69kRoG+kFO7JxzZPiZeeFWv2MyIbQLaJCIngP1mGzF/QZ5mStmJsQh5creqmGwPsP/ofnDIlvL/oyUxDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187443; c=relaxed/simple;
	bh=jVV+oiJM0cYWxoE5qzXOwM2cqZugv66qN003jNJGkJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmtQNN+7PldtBaApNPyh+4Ec58y5O1FWcuhuBWF/cHR6no8zeych6k/sEKulNl68B6H01gKPaG6P3HwGIxM6jEXY2PCRkCJrf+OJHHfdj47CHFhlxL5N0p4CYOH3ftC+Y60dVgSRFDGVnkcyUpCE7Exj0bXiIxFtDv53fB5OKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9wqD4n9Lz9sSb;
	Tue, 26 Aug 2025 07:15:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rpB2O40BvjbE; Tue, 26 Aug 2025 07:15:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9wqD3f1Fz9sSZ;
	Tue, 26 Aug 2025 07:15:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FE698B764;
	Tue, 26 Aug 2025 07:15:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QeAqRAElDkH6; Tue, 26 Aug 2025 07:15:52 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 70BC98B763;
	Tue, 26 Aug 2025 07:15:50 +0200 (CEST)
Message-ID: <29c26faf-98da-42fa-9408-0e0d2932bb13@csgroup.eu>
Date: Tue, 26 Aug 2025 07:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] sched/topology: Unify tl_mc_mask() across core and
 all arch
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
 <20250826041319.1284-8-kprateek.nayak@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826041319.1284-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> Unify the tl_mc_mask() wrapper around cpu_coregroup_mask() used by core,
> x86, powerpc, and s390.
> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/powerpc/kernel/smp.c      | 7 +------
>   arch/s390/kernel/topology.c    | 7 +------
>   arch/x86/kernel/smpboot.c      | 7 -------
>   include/linux/sched/topology.h | 8 +++++++-
>   kernel/sched/topology.c        | 7 -------
>   5 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index c58ddf84fe63..40719679385b 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1062,11 +1062,6 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>   
>   	return cpu_node_mask(cpu);
>   }
> -
> -static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_corgrp_mask(cpu);
> -}
>   #endif
>   
>   static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> @@ -1729,7 +1724,7 @@ static void __init build_sched_topology(void)
>   #ifdef CONFIG_SCHED_MC
>   	if (has_coregroup_support()) {
>   		powerpc_topology[i++] =
> -			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
> +			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
>   	}
>   #endif
>   
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index c88eda847309..8dbf32f362e1 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -514,11 +514,6 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>   	return &cpu_topology[cpu].core_mask;
>   }
>   
> -static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return &cpu_topology[cpu].core_mask;
> -}
> -
>   static const struct cpumask *cpu_book_mask(struct sched_domain_topology_level *tl, int cpu)
>   {
>   	return &cpu_topology[cpu].book_mask;
> @@ -536,7 +531,7 @@ static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl
>   
>   static struct sched_domain_topology_level s390_topology[] = {
>   	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
> -	SDTL_INIT(cpu_mc_mask, cpu_core_flags, MC),
> +	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
>   	SDTL_INIT(cpu_book_mask, NULL, BOOK),
>   	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
>   	SDTL_INIT(cpu_pkg_mask, NULL, PKG),
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 81a40d777d65..bfbcac9a73d1 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -472,13 +472,6 @@ static int x86_cluster_flags(void)
>   }
>   #endif
>   
> -#ifdef CONFIG_SCHED_MC
> -static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_coregroup_mask(cpu);
> -}
> -#endif
> -
>   static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
>   {
>   	return cpu_node_mask(cpu);
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index e54501cc8e47..075d1f063668 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -63,7 +63,13 @@ static inline int cpu_core_flags(void)
>   {
>   	return SD_SHARE_LLC;
>   }
> -#endif
> +
> +static const __maybe_unused

Same as the two previous patches, __maybe_unused shouldn't be required.

> +struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_coregroup_mask(cpu);
> +}
> +#endif /* CONFIG_SCHED_MC */
>   
>   #ifdef CONFIG_NUMA
>   static inline int cpu_numa_flags(void)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4530cbad41e1..77d14430c5e1 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1724,13 +1724,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   	return sd;
>   }
>   
> -#ifdef CONFIG_SCHED_MC
> -static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_coregroup_mask(cpu);
> -}
> -#endif
> -
>   static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
>   {
>   	return cpu_node_mask(cpu);

