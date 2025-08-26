Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB61514E4;
	Tue, 26 Aug 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185636; cv=none; b=iXSbdTLsgREIwiPSXVBvdz/RlDh5DoCD4J4V/P8RbUdzr+d9GtXkTEqvvtQqMnN5VE6U0V3uboMT1y6Z8fJwPihKB7mmoOw3rWKRX1nCDOXbQfSlahapH2mwmscbva6nljg0n2TV+AKBBc6M9zwJC910278PAyAX2qr+jNycCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185636; c=relaxed/simple;
	bh=k2xuUkJ5CYoYevoKomjEJAfiGiwMnldUI6wVPw1rmqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dncF3lyJlhAir8Ndvoh5sYqPycZI52tEYgjbnUPhsp3XTiu4DiOq/y5p36qmrVuzY8yPfP6LRCpXjpeVjGbLRUC1KzAfzNcMM90TfMUd8BjPUV1r1FXJVi4hQ11IwEn+c24XI7iYpO2XerxWeb6f+yXd1p5sWYPilaepEdFJin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9wnp3pJPz9sSY;
	Tue, 26 Aug 2025 07:14:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEmYXdeORp8H; Tue, 26 Aug 2025 07:14:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9wnp2XzBz9sSX;
	Tue, 26 Aug 2025 07:14:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C7C08B764;
	Tue, 26 Aug 2025 07:14:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5Jvj8WfM3QuB; Tue, 26 Aug 2025 07:14:38 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 577028B763;
	Tue, 26 Aug 2025 07:14:36 +0200 (CEST)
Message-ID: <e926a154-0f4e-49b2-aefa-1e778530c34c@csgroup.eu>
Date: Tue, 26 Aug 2025 07:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/8] sched/topology: Unify tl_cls_mask() across core
 and x86
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
 <20250826041319.1284-7-kprateek.nayak@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826041319.1284-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> Unify the tl_cls_mask() used by both the scheduler core and x86.
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/x86/kernel/smpboot.c      | 4 ----
>   include/linux/sched/topology.h | 8 +++++++-
>   kernel/sched/topology.c        | 7 -------
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 03ff6270966a..81a40d777d65 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -470,10 +470,6 @@ static int x86_cluster_flags(void)
>   {
>   	return cpu_cluster_flags() | x86_sched_itmt_flags();
>   }
> -static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_clustergroup_mask(cpu);
> -}
>   #endif
>   
>   #ifdef CONFIG_SCHED_MC
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index d75fbb7d9667..e54501cc8e47 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -50,7 +50,13 @@ static inline int cpu_cluster_flags(void)
>   {
>   	return SD_CLUSTER | SD_SHARE_LLC;
>   }
> -#endif
> +
> +static const __maybe_unused

Same as previous patch, don't hide dust under the carpet, if you need 
__maybe_unused it means there is a problem in the construct.

> +struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_clustergroup_mask(cpu);
> +}
> +#endif /* CONFIG_SCHED_CLUSTER */
>   
>   #ifdef CONFIG_SCHED_MC
>   static inline int cpu_core_flags(void)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 92165fe56a2d..4530cbad41e1 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1724,13 +1724,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   	return sd;
>   }
>   
> -#ifdef CONFIG_SCHED_CLUSTER
> -static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
> -{
> -	return cpu_clustergroup_mask(cpu);
> -}
> -#endif
> -
>   #ifdef CONFIG_SCHED_MC
>   static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
>   {

