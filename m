Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711914533A;
	Thu, 23 May 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462846; cv=none; b=MR3muuHM2jzBMBzDnz6N2TM5L8/UIK31+Kh5jAkyTUveL4OrAvkpefbY/8jzbFjnaOe9GRxTMguSGLFz44af5WezEAA5NLvxJpVD4Melo8Ivk++0nqKQMeIg8S7FUvUYnft1UZRk+k0zD3Q3qlfzORaKvMgN7Adc5kipJ8MfrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462846; c=relaxed/simple;
	bh=WsFGnwTm99wDa34rj9YU1yMy/PbnfLe5oRW6cl9M6ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYcJS1d5juOshDeyboeZfNu5m7IKloK+m7TMmZUy24KCQkhXKkf5ZvVy8EvRIcYApgThj1ggR/lVUM1efykco2tnP7BH6v2PFdrInAg/J6GB2URHSud5Gxi7DTa2wbpNZy4y7fpF4J7We/8Oos1Y0thXD11DyqChAL6SPZUPeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TrAFcD/0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TrAFcD/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716462840;
	bh=RQkvd78utY4Ja+S0DO/1Mye5FaeMmZbhGPyeP5EJKQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TrAFcD/0oCSj4bONcbgtSXsgS11T7S6E6WEE0gffpW7ra3PdygToDHYnWt9FP325X
	 Ulu0bqi0OxVHifCazgqTPTcv/aaBzA/83J1DT67GuP6P4kjWTmxYpR3k5d8QUw5SLX
	 KaBhSbgX+yGymHJf39ImQ6bnlzCPqhwGCGOmHgS0sHnNQgFIAZ6faJ7xj1yh2/HfZ9
	 /Z9LFLWzTrGlhqhCpc9jNxdoVnW04Z3oqkCtkFgdgatmkjO7vuIyMxPYAtcwoYLtH4
	 NkZDz2N+aA5I64TWM3LiovfgstkBhV29OKuQ0ghCtOqMnTp1QDGg0kge9VdLNWKmjf
	 eyL0seoYf1YEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VlQXk23Vyz4wcK;
	Thu, 23 May 2024 21:13:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Chanudet <echanude@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Nick Piggin
 <npiggin@gmail.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Eric Chanudet
 <echanude@redhat.com>
Subject: Re: [PATCH v2] mm/mm_init: use node's number of cpus in
 deferred_page_init_max_threads
In-Reply-To: <20240522203758.626932-4-echanude@redhat.com>
References: <20240522203758.626932-4-echanude@redhat.com>
Date: Thu, 23 May 2024 21:13:55 +1000
Message-ID: <87jzjk3hn0.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Chanudet <echanude@redhat.com> writes:
> x86_64 is already using the node's cpu as maximum threads. Make that the
> default for all archs setting DEFERRED_STRUCT_PAGE_INIT.
>
> This returns to the behavior prior making the function arch-specific
> with commit ecd096506922 ("mm: make deferred init's max threads
> arch-specific").
>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
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
>
> - v1: https://lore.kernel.org/linux-arm-kernel/20240520231555.395979-5-echanude@redhat.com
> - Changes since v1:
>  - Make the generic function return the number of cpus of the node as
>    max threads limit instead overriding it for arm64.
> - Drop Baoquan He's R-b on v1 since the logic changed.
> - Add CCs according to patch changes (ppc and s390 set
>   DEFERRED_STRUCT_PAGE_INIT by default).
>
>  arch/x86/mm/init_64.c | 12 ------------
>  mm/mm_init.c          |  2 +-
>  2 files changed, 1 insertion(+), 13 deletions(-)

On a machine here (1TB, 40 cores, 4KB pages) the existing code gives:

  [    0.500124] node 2 deferred pages initialised in 210ms
  [    0.515790] node 3 deferred pages initialised in 230ms
  [    0.516061] node 0 deferred pages initialised in 230ms
  [    0.516522] node 7 deferred pages initialised in 230ms
  [    0.516672] node 4 deferred pages initialised in 230ms
  [    0.516798] node 6 deferred pages initialised in 230ms
  [    0.517051] node 5 deferred pages initialised in 230ms
  [    0.523887] node 1 deferred pages initialised in 240ms

vs with the patch:

  [    0.379613] node 0 deferred pages initialised in 90ms
  [    0.380388] node 1 deferred pages initialised in 90ms
  [    0.380540] node 4 deferred pages initialised in 100ms
  [    0.390239] node 6 deferred pages initialised in 100ms
  [    0.390249] node 2 deferred pages initialised in 100ms
  [    0.390786] node 3 deferred pages initialised in 110ms
  [    0.396721] node 5 deferred pages initialised in 110ms
  [    0.397095] node 7 deferred pages initialised in 110ms

Which is a nice speedup.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
