Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE186342;
	Tue, 26 Aug 2025 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187438; cv=none; b=GRkT+kchxx4jGkSpyJl2AF2X6/DeGKShW+YSzMYOvhd7VfgdjsBv+4Hb4x6lwcmwQkwOl9tD4RfUABjlHuk2/4x3ocQ0AWum5acUsMao+v8gg2k8BbF9ICocnpevPt7CWRFmqMlxyusbLHV9TfFbII575vOlQhoB7XJA9iTLNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187438; c=relaxed/simple;
	bh=8mr6sAPn1eF1SLloywwiZDdJyQaCjyvAxVz7GjFVWh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz26YaSJABOwZajbmKCmacmQFFgRpYIIqMoQ2EsMFc3GKElylPtOrdfFcvhe7w8A52s4Zg8Q1Z/GpK90yxBn4I38+CcBSMFx8EwwEDSxWufuxVy3ZOhvLl3PhOKSf7wLTE9/C9ji92ng1nJEne8LUrgUnkCheV/hK4AQNKNESRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9wqw191fz9sSd;
	Tue, 26 Aug 2025 07:16:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8QBWi60LJ5rv; Tue, 26 Aug 2025 07:16:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9wqw02g8z9sSc;
	Tue, 26 Aug 2025 07:16:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DA3DE8B764;
	Tue, 26 Aug 2025 07:16:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id w2QSnjtwcJ6v; Tue, 26 Aug 2025 07:16:27 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 139828B763;
	Tue, 26 Aug 2025 07:16:26 +0200 (CEST)
Message-ID: <154fd466-5305-431f-b49a-a5ccec81507a@csgroup.eu>
Date: Tue, 26 Aug 2025 07:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] sched/topology: Unify tl_pkg_mask() across core
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
 <20250826041319.1284-9-kprateek.nayak@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826041319.1284-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> Unify the tl_pkg_mask() wrapper around cpu_nod_mask() across core, x86,
> powerpc, and s390.
> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/powerpc/kernel/smp.c      | 7 +------
>   arch/s390/kernel/topology.c    | 7 +------
>   arch/x86/kernel/smpboot.c      | 5 -----
>   include/linux/sched/topology.h | 6 ++++++
>   kernel/sched/topology.c        | 5 -----
>   5 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 40719679385b..8e869c13f7ed 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1064,11 +1064,6 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>   }
>   #endif
>   
> -static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_node_mask(cpu);
> -}
> -
>   static int __init init_big_cores(void)
>   {
>   	int cpu;
> @@ -1728,7 +1723,7 @@ static void __init build_sched_topology(void)
>   	}
>   #endif
>   
> -	powerpc_topology[i++] = SDTL_INIT(cpu_pkg_mask, powerpc_shared_proc_flags, PKG);
> +	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
>   
>   	/* There must be one trailing NULL entry left.  */
>   	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 8dbf32f362e1..8f5b6ecc055f 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -524,17 +524,12 @@ static const struct cpumask *cpu_drawer_mask(struct sched_domain_topology_level
>   	return &cpu_topology[cpu].drawer_mask;
>   }
>   
> -static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_node_mask(cpu);
> -}
> -
>   static struct sched_domain_topology_level s390_topology[] = {
>   	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
>   	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
>   	SDTL_INIT(cpu_book_mask, NULL, BOOK),
>   	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
> -	SDTL_INIT(cpu_pkg_mask, NULL, PKG),
> +	SDTL_INIT(tl_pkg_mask, NULL, PKG),
>   	{ NULL, },
>   };
>   
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index bfbcac9a73d1..6c0ab30a80e2 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -472,11 +472,6 @@ static int x86_cluster_flags(void)
>   }
>   #endif
>   
> -static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_node_mask(cpu);
> -}
> -
>   /*
>    * Set if a package/die has multiple NUMA nodes inside.
>    * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 075d1f063668..807603bfe8ff 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -71,6 +71,12 @@ struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
>   }
>   #endif /* CONFIG_SCHED_MC */
>   
> +static const __maybe_unused

Same as the three previous patches, __maybe_unused shouldn't be required.

> +struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_node_mask(cpu);
> +}
> +
>   #ifdef CONFIG_NUMA
>   static inline int cpu_numa_flags(void)
>   {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 77d14430c5e1..18889bd97e22 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1724,11 +1724,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   	return sd;
>   }
>   
> -static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_node_mask(cpu);
> -}
> -
>   /*
>    * Topology list, bottom-up.
>    */

