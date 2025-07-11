Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CB290092;
	Fri, 11 Jul 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236774; cv=none; b=jRIZYT/noWDrKWEGaDpFnqR3LurYeY7s3/VvXQq5nkYs5T3ImQKrTGFbw9Z6zVaukO2vQC/+THAQfmUSWAAYuLrtdqYSjUVmU+xeKtBvQMtKEfcpo9wowBgp2uWdzMqlgOjgvLiIUnVpxoZqd7r7WAnx1ZladUnYsl/wi4PGUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236774; c=relaxed/simple;
	bh=CBZeXdUUgFL+TPTegk8H1qs7POEc3HTSo3JRf2whjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VSfF4BCqXYTq17RFD6tflxa/hjAytSTtoOWzsu2ibZNyQSKy9n0MoWtqeiLvL9soD/cpx8p1TV0/1Bfn9dMeBwr3oSD5i3/upZnRmFHcrmKtAxkdWqGdPCAUMaYeLisu+6fbZ2ZQpNmaHP8usOBlL4S5PMhfKiq0GlU/Ryn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PaExWWTu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PaExWWTu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vGjGW/PtJqBFBruMN5J6ADYZtMINuph/UDezRVBHu1Y=; b=PaExWWTu6LCWc//YsZkBXUY3qB
	OhRcnm1raovoM5kv8uOVijsT/tUZyQM82IAAMgZVZWwPht3FD0gePK+so8z+iLW5V24Sdat5Yx2mU
	+vGUD2xwNKHxG9MoCvV+hUYL+u45hQBujCuTkz7HQwlB0T98xHl0AY+LGI63i+tP2F7HC2zX7xaCF
	8cv44QWL96iNFXy2QjuzOul6m/GtUhM6S1KJV6cGHv4ATQWy5EmxxvIhYPUdyMMF5b/vbp6wreTi7
	0p5woQ/tOGYzNNZUH0pMdgOC4iR4GlDpuNSpg7JM6Lb6wUh3lWAfmOV9IM4l0c0aRDZZhXTkigVnR
	lnzUcaSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCoj-00000009G4q-1Htk;
	Fri, 11 Jul 2025 12:25:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 489EA3001AA; Fri, 11 Jul 2025 14:25:28 +0200 (CEST)
Date: Fri, 11 Jul 2025 14:25:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Li Chen <me@linux.beauty>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Wei??schuh <thomas.weissschuh@linutronix.de>,
	Li Chen <chenl311@chinatelecom.cn>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Joel Granados <joel.granados@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
Message-ID: <20250711122528.GB905792@noisy.programming.kicks-ass.net>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710105715.66594-2-me@linux.beauty>

On Thu, Jul 10, 2025 at 06:57:07PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Define a small SDTL_INIT(maskfn, flagsfn, name) macro and use it to build the
> sched_domain_topology_level array. Purely a cleanup; behaviour is unchanged.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/powerpc/kernel/smp.c      | 34 +++++++++++++---------------------
>  arch/s390/kernel/topology.c    | 10 +++++-----
>  arch/x86/kernel/smpboot.c      | 21 ++++++---------------
>  include/linux/sched/topology.h |  4 ++--
>  kernel/sched/topology.c        | 24 ++++++++----------------
>  5 files changed, 34 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5ac7084eebc0b..0b7ab7d2eb142 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1700,28 +1700,20 @@ static void __init build_sched_topology(void)
>  #ifdef CONFIG_SCHED_SMT
>  	if (has_big_cores) {
>  		pr_info("Big cores detected but using small core scheduling\n");
> -		powerpc_topology[i++] = (struct sched_domain_topology_level){
> -			smallcore_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
> -		};
> -	} else {
> -		powerpc_topology[i++] = (struct sched_domain_topology_level){
> -			cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
> -		};
> -	}
> +		powerpc_topology[i++] =
> +			SDTL_INIT(smallcore_smt_mask, powerpc_smt_flags, SMT);
> +	} else
> +		powerpc_topology[i++] = SDTL_INIT(cpu_smt_mask, powerpc_smt_flags, SMT);
>  #endif
> -	if (shared_caches) {
> -		powerpc_topology[i++] = (struct sched_domain_topology_level){
> -			shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE)
> -		};
> -	}
> -	if (has_coregroup_support()) {
> -		powerpc_topology[i++] = (struct sched_domain_topology_level){
> -			cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC)
> -		};
> -	}
> -	powerpc_topology[i++] = (struct sched_domain_topology_level){
> -		cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(PKG)
> -	};
> +	if (shared_caches)
> +		powerpc_topology[i++] =
> +			SDTL_INIT(shared_cache_mask, powerpc_shared_cache_flags, CACHE);
> +
> +	if (has_coregroup_support())
> +		powerpc_topology[i++] =
> +			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
> +
> +	powerpc_topology[i++] = SDTL_INIT(cpu_cpu_mask, powerpc_shared_proc_flags, PKG);

You wrecked coding-style here and lost a bunch of curlies. I've fixed
that up for you.
