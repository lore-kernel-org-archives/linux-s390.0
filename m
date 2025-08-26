Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DA1DB95E;
	Tue, 26 Aug 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185910; cv=none; b=dnCtGO72tT/pwdVn6heGC2rfHEKHQsA5hl67NklzPYz2dT9pGXZpg/OzZFQvmhCeMS8wKFLtwM+59hbkuXLEjFojSBDpghug5hTZr4VUKMaqzXId2b/xm6gjwImnhnIeV7lBWDySTpmvIYcYsRU89wAJJ7FiOQmgTz6kT9YuZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185910; c=relaxed/simple;
	bh=ecf59KpVXnVU4LJKy9jLmYErrPVQTbsTnjCrcxVuU84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF4GVgF9ZK0y562YAFQzyLUUASVazGY93Z27xYgh/v12oEGCuIboobnXG99h1sxALCTCjwfqXEgV+2Hsg+yP78TXmgkRq9L4ZKF+qfDat52fch9xQ3IOtargROQ2B4doBFJyGhIvGVU4W4JA1Mp1MMtSnS1hTNWkoTzhT0T8668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9wXB51PCz9sSS;
	Tue, 26 Aug 2025 07:02:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OAnSCdrgSj6y; Tue, 26 Aug 2025 07:02:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9wXB3qBmz9sSN;
	Tue, 26 Aug 2025 07:02:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 60C3D8B764;
	Tue, 26 Aug 2025 07:02:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aPCU04BVP-5t; Tue, 26 Aug 2025 07:02:50 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C6B38B763;
	Tue, 26 Aug 2025 07:02:48 +0200 (CEST)
Message-ID: <6e197065-a782-4e24-bf38-5e423d0509ff@csgroup.eu>
Date: Tue, 26 Aug 2025 07:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] powerpc/smp: Rename cpu_corgroup_* to cpu_corgrp_*
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
 <20250826041319.1284-3-kprateek.nayak@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826041319.1284-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> Rename cpu_corgroup_{map,mask} to cpu_corgrp_{map,mask} to free up the
> cpu_corgroup_* namespace. cpu_corgroup_mask() will be added back in the
> subsequent commit for CONFIG_SCHED_MC enablement.

This renaming seems odd and uncomplete. For instance 
update_coregroup_mask() should probably be renamed as well shoudln't it ?

When you say cpu_corgroup_mask() will be added back, you mean the same 
function or a completely different function but with the same name ?

What's really the difference between corgrp and coregroup ?

Shouldn't also has_coregroup_support() now be renamed has_corgrp_support() ?

Christophe

> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/powerpc/kernel/smp.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 862f50c09539..4f48262658cc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -87,7 +87,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
>   DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
>   DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
>   DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
> -static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
> +static DEFINE_PER_CPU(cpumask_var_t, cpu_corgrp_map);
>   
>   EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
>   EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
> @@ -1045,9 +1045,9 @@ static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl,
>   }
>   #endif
>   
> -static struct cpumask *cpu_coregroup_mask(int cpu)
> +static struct cpumask *cpu_corgrp_mask(int cpu)
>   {
> -	return per_cpu(cpu_coregroup_map, cpu);
> +	return per_cpu(cpu_corgrp_map, cpu);
>   }
>   
>   static bool has_coregroup_support(void)
> @@ -1061,7 +1061,7 @@ static bool has_coregroup_support(void)
>   
>   static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
>   {
> -	return cpu_coregroup_mask(cpu);
> +	return cpu_corgrp_mask(cpu);
>   }
>   
>   static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> @@ -1124,7 +1124,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
>   					GFP_KERNEL, cpu_to_node(cpu));
>   		if (has_coregroup_support())
> -			zalloc_cpumask_var_node(&per_cpu(cpu_coregroup_map, cpu),
> +			zalloc_cpumask_var_node(&per_cpu(cpu_corgrp_map, cpu),
>   						GFP_KERNEL, cpu_to_node(cpu));
>   
>   #ifdef CONFIG_NUMA
> @@ -1145,7 +1145,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
>   
>   	if (has_coregroup_support())
> -		cpumask_set_cpu(boot_cpuid, cpu_coregroup_mask(boot_cpuid));
> +		cpumask_set_cpu(boot_cpuid, cpu_corgrp_mask(boot_cpuid));
>   
>   	init_big_cores();
>   	if (has_big_cores) {
> @@ -1510,8 +1510,8 @@ static void remove_cpu_from_masks(int cpu)
>   		set_cpus_unrelated(cpu, i, cpu_core_mask);
>   
>   	if (has_coregroup_support()) {
> -		for_each_cpu(i, cpu_coregroup_mask(cpu))
> -			set_cpus_unrelated(cpu, i, cpu_coregroup_mask);
> +		for_each_cpu(i, cpu_corgrp_mask(cpu))
> +			set_cpus_unrelated(cpu, i, cpu_corgrp_mask);
>   	}
>   }
>   #endif
> @@ -1543,7 +1543,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
>   	if (!*mask) {
>   		/* Assume only siblings are part of this CPU's coregroup */
>   		for_each_cpu(i, submask_fn(cpu))
> -			set_cpus_related(cpu, i, cpu_coregroup_mask);
> +			set_cpus_related(cpu, i, cpu_corgrp_mask);
>   
>   		return;
>   	}
> @@ -1551,18 +1551,18 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
>   	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
>   
>   	/* Update coregroup mask with all the CPUs that are part of submask */
> -	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
> +	or_cpumasks_related(cpu, cpu, submask_fn, cpu_corgrp_mask);
>   
>   	/* Skip all CPUs already part of coregroup mask */
> -	cpumask_andnot(*mask, *mask, cpu_coregroup_mask(cpu));
> +	cpumask_andnot(*mask, *mask, cpu_corgrp_mask(cpu));
>   
>   	for_each_cpu(i, *mask) {
>   		/* Skip all CPUs not part of this coregroup */
>   		if (coregroup_id == cpu_to_coregroup_id(i)) {
> -			or_cpumasks_related(cpu, i, submask_fn, cpu_coregroup_mask);
> +			or_cpumasks_related(cpu, i, submask_fn, cpu_corgrp_mask);
>   			cpumask_andnot(*mask, *mask, submask_fn(i));
>   		} else {
> -			cpumask_andnot(*mask, *mask, cpu_coregroup_mask(i));
> +			cpumask_andnot(*mask, *mask, cpu_corgrp_mask(i));
>   		}
>   	}
>   }

