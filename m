Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A541A80;
	Wed, 22 May 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716417969; cv=none; b=l3z0mx87XtvQIOydhX4bs+J0GrmsnwxK/sqyi5ZB9ZwdsQAhemz5cyxKSIjZLaQA4OkWVOVOJdpPzSnrtjhOLKdOqJR48OYvLA/hTw8jHbJ8fOe7GzGigm1tP+koY8M3E8JqU7SODsFLRR1miO8ogs0KOKw+ygEtvxXOjXAx7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716417969; c=relaxed/simple;
	bh=Wt/lYOMjZ5EiLqgZDOMSYLAv6ghVbecXbWEEUnbdvAk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I8ley0LEtGN3PubbW8F/1VlsVW4cBCTy/Je3OK1HaJqftPWDz1O0UFruzsh+cZQ4hdzyfYyB0Gc21YQ8ZN5szw0UROkEfXNVOy0qle6DNvKVL/AqLMijXOA3tWaeBnkA/UhnLi4RzFxLrliUY06dKEJig74iWGGX06ejQ+89Gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Difkpi8p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Difkpi8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A8C2BBFC;
	Wed, 22 May 2024 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716417969;
	bh=Wt/lYOMjZ5EiLqgZDOMSYLAv6ghVbecXbWEEUnbdvAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Difkpi8pE8zKRNDX2+VZ7EyZcNiHjM0HR8FJLGZH0pip8MxP1u7thd/rd83PcA09V
	 TVYuNLsB9uDO/0L6O8a4XCtYe8AGfV2GMFw/WHUCsVYFKPfQALg/JlSvIlzFXcExDp
	 AtnoA3XHUlrJl32QhYOsFNsXhIwLTMDFKtCKGeoA=
Date: Wed, 22 May 2024 15:46:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport
 <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nick Piggin <npiggin@gmail.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] mm/mm_init: use node's number of cpus in
 deferred_page_init_max_threads
Message-Id: <20240522154607.bd5790c0b0dc642aefd3a05c@linux-foundation.org>
In-Reply-To: <20240522203758.626932-4-echanude@redhat.com>
References: <20240522203758.626932-4-echanude@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 16:38:01 -0400 Eric Chanudet <echanude@redhat.com> wrote:

> x86_64 is already using the node's cpu as maximum threads. Make that the
> default for all archs setting DEFERRED_STRUCT_PAGE_INIT.
> 
> This returns to the behavior prior making the function arch-specific
> with commit ecd096506922 ("mm: make deferred init's max threads
> arch-specific").
> 

It isn't clear to me what is the runtime effect of this change upon our
users.  Can you please prepare a sentence which spells this out?

> 
> ---
> Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64 platforms
> shows faster deferred_init_memmap completions:
> 
> |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> |---------|-------------|--------------|-----------------|--------------|
> | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> |---------|-------------|--------------|-----------------|--------------|
> | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |

The above is useful info, I'll hoist it into the main changelog.

> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2126,7 +2126,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  __weak int __init
>  deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>  {
> -	return 1;
> +	return max_t(int, cpumask_weight(node_cpumask), 1);
>  }

It's an unrelated cleanup , but that could be

	max(cpumask_weight(node_cpumask), 1U);

and the function could/should return unsigned.
