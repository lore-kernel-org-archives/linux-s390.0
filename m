Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFE6AB8;
	Wed, 29 May 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960740; cv=none; b=ewYPDZylUz8Nw1JrHJoSMfHR1qsu6SVXuNaLPl2KCPIC0Scn/vwt6J664LPDgyTXvPWnBulBP/lV7uQdiq1AogdEWu5D5orbB8gJ2WsVx4Z6l5UrWj8VVrAR4js6cgrJMmxcnOlsZttDa8QyqbwSMuuFKALpvmqCvc7s/0Dym80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960740; c=relaxed/simple;
	bh=aBznwI196mCXdIjypa7AmSwqqkGS5EsYJK31pzgSYXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anw3k28OxNx+aKzId/IrGt7MpT+Z1/F11WZes45Zq7ao1//Qp5N6AgMOOqD4mBUAMdl5ZrE23wojPI7cbMsx099f5fO9njEODUxyTXVumreJq+NECsE23rRaAkMfNWJAOz25BY7UZ/vi7Hwajacd0h8MTGq1m8CusmrMT8zcuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeEZBqXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeEZBqXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7FFC2BD10;
	Wed, 29 May 2024 05:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716960739;
	bh=aBznwI196mCXdIjypa7AmSwqqkGS5EsYJK31pzgSYXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeEZBqXsaFwHKqq22xYJkq1anme+3hC9y4dtkgVlEK8L0HpFZWUwdSNmDY9Dkw6NW
	 jmYzLhjePapm2TqQULKLIdowZXJ5+4rkJdUNI6remV3ooCQ/tnpDnrCOCjxWLhxWUa
	 wnIWzdQOEkuJE9hEeHvETExo8PPpuO700JnCabxsCN0WeaNU6RsdbqNH06C052cUbz
	 pcYHVG/nEm6xkBGENDwx7i0hAa/WwhPnHmaFiBu7FRjnOtZfVtTI158ewx8yBQdXzA
	 2PEUKqEd3KrOUZjq6zO2DU3cPgp149y+59wWRzK4VAWqxaA4LAIaxHdvKkBqK7f830
	 Q8mHay2aWjJlg==
Date: Wed, 29 May 2024 08:30:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nick Piggin <npiggin@gmail.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] mm/mm_init: use node's number of cpus in
 deferred_page_init_max_threads
Message-ID: <Zla9cwSorlNg98F5@kernel.org>
References: <20240528185455.643227-4-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528185455.643227-4-echanude@redhat.com>

On Tue, May 28, 2024 at 02:54:58PM -0400, Eric Chanudet wrote:
> When DEFERRED_STRUCT_PAGE_INIT=y, use a node's cpu count as maximum
> thread count for the deferred initialization of struct pages via padata.
> This should result in shorter boot times for these configurations by
> going through page_alloc_init_late() faster as systems tend not to be
> under heavy load that early in the bootstrap.
> 
> Only x86_64 does that now. Make it archs agnostic when
> DEFERRED_STRUCT_PAGE_INIT is set. With the default defconfigs, that
> includes powerpc and s390.
> 
> It used to be so before offering archs to override the function for
> tuning with commit ecd096506922 ("mm: make deferred init's max threads
> arch-specific").
> 
> Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64 platforms
> shows faster deferred_init_memmap completions:
> |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> |---------|-------------|--------------|-----------------|--------------|
> | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> |---------|-------------|--------------|-----------------|--------------|
> | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |
> 
> Michael Ellerman on a powerpc machine (1TB, 40 cores, 4KB pages) reports
> faster deferred_init_memmap from 210-240ms to 90-110ms between nodes.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> - v1: https://lore.kernel.org/linux-arm-kernel/20240520231555.395979-5-echanude@redhat.com
> - Changes since v1:
>  - Make the generic function return the number of cpus of the node as
>    max threads limit instead overriding it for arm64.
>  - Drop Baoquan He's R-b on v1 since the logic changed.
>  - Add CCs according to patch changes (ppc and s390 set
>    DEFERRED_STRUCT_PAGE_INIT by default).
> 
> - v2: https://lore.kernel.org/linux-arm-kernel/20240522203758.626932-4-echanude@redhat.com/
> - Changes since v2:
>  - deferred_page_init_max_threads returns unsigned and use max instead
>    of max_t.
>  - Make deferred_page_init_max_threads static since there are no more
>    override.
>  - Rephrase description.
>  - Add T-b and report from Michael Ellerman.
> 
>  arch/x86/mm/init_64.c    | 12 ------------
>  include/linux/memblock.h |  2 --
>  mm/mm_init.c             |  5 ++---
>  3 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 7e177856ee4f..adec42928ec1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1354,18 +1354,6 @@ void __init mem_init(void)
>  	preallocate_vmalloc_pages();
>  }
>  
> -#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> -int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
> -{
> -	/*
> -	 * More CPUs always led to greater speedups on tested systems, up to
> -	 * all the nodes' CPUs.  Use all since the system is otherwise idle
> -	 * now.
> -	 */
> -	return max_t(int, cpumask_weight(node_cpumask), 1);
> -}
> -#endif
> -
>  int kernel_set_to_readonly;
>  
>  void mark_rodata_ro(void)
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e2082240586d..40c62aca36ec 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -335,8 +335,6 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  	for (; i != U64_MAX;					  \
>  	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
>  
> -int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
> -
>  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
>  
>  /**
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f72b852bd5b8..acfeba508796 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2122,11 +2122,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  	}
>  }
>  
> -/* An arch may override for more concurrency. */
> -__weak int __init
> +static unsigned int __init
>  deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>  {
> -	return 1;
> +	return max(cpumask_weight(node_cpumask), 1U);
>  }
>  
>  /* Initialise remaining memory on a node */
> -- 
> 2.44.0
> 

-- 
Sincerely yours,
Mike.
