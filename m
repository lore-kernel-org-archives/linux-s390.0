Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC44E3240;
	Mon, 21 Sep 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013277; cv=none; b=bggfmvnC2vQb6e37isN3faVLz70idThzwE9BXTaYe9U2Ybw1XO62MuvmCfnFZIDubh2TN37ozT8ID76O0ZUrrKrs5LeK2lfQDnOvVJ1HqvMEdp9AvJLvQVs1XZbVyTrGFkXkbhQBv834RLFNh71NPTyy8q52T8GZZaJzJ3C58Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013277; c=relaxed/simple;
	bh=iXjd/Mb/aSg6S9xZD/dMOVm6HDGo/P6gE7a+fsa5/oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUf793BJDcxqH+g28BEU88Ciguq+3YNrF6G2wHNCTwkwSkDNxkSz4BiOA3TvqgLEwsowKo7CZifJlTnVSI1vgayvvoPNrMDEKrCG1zeKbfXSuyMywK6Qvh2SuVong4xDVmNZzQF+WlYWNZ2DpTswKDDavuHzOVqnp80vsZj7/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0lA4uFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0lA4uFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B31F000FF;
	Mon, 21 Sep 2026 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013275;
	bh=ZauDV3vJKUROsmCoqVdGrpQ07LaYoylUMtCQPyYKr3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j0lA4uFjJBcRY6wWftw6EMIqyMIJ3+NR7zrSfOF1Z9f/TpSIZ9Gh4y4jjvxmRONiM
	 ObFuyLQ3ujm1yOOBV9KrS8elLJVfpjsktABH0b/F1q1DonDxSlGIPFvplEykYNyWru
	 TlrUJIAlHIsRcMxf5Hseb1ckLHW5wBXYIPyvOsX2gRpDZsTqCte91cFQpVs3/uhjQy
	 /uSJ4AgrDQbnh845s783rZmk0fA2Mnl9gEqoW27HOmlO9rUd44HaqIaFmOIhFLKK2U
	 BjNB7hlhY1CcorgDW7hwVfGqMdkjLPpMfT+I78qw5XqoHtqO09h+yru8tFtvcXd+2y
	 9NHxKZRfAtd9Q==
Date: Mon, 21 Sep 2026 18:54:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baohua@kernel.org, surenb@google.com, david@kernel.org, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, willy@infradead.org, zhaonanzhe@xiaomi.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	loongarch@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <arFYRAa-i7CIwmHL@gremlin>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911025613.1220845-1-zhanghongru@xiaomi.com>

OK I finally got to this...

I fear we're going to go round in circles on this/have endless revisions of
the same thing.

So 2 things the patch needs to answer, more or less right away:

1. What are you actually optimising for?

2. Where does the hurt happen?

Your patch does neither, then goes on to arm wave away all the complexity
and presents a 'simple' solution that I feel brushes a lot under the rug.

Answer to 1 is 'cold app startup time for a specific set of apps'
2 is filemap_fault() AFAICT.

You should definitely be stating this upfront.

And I also seem to remember that zygote + multi-threaded apps = fork
blocking is part of the problem here, which is why there was push-back on
just holding the VMA lock over I/O.

Looking through filemap_fault() makes me want to cry and looking through
the other retry logic in the fault code makes me want to live on an island
with parakeets and coconuts forgetting any of this even exists...

The retry logic is fu.. err.. ndamentally a total mess.

Part of the problem is that each time this patch is respinned we lose
context on what is a complicated istuation.

VM_FAULT_RETRY can mean a million different things:

1. I dropped the lock and waited for the folio to be unlocked.

do_swap_page(), remove_device_exclusive_entry() -> folio_lock_or_retry()

2. I dropped the lock to start I/O it may or may not be ready when you come
   back.

filemap_fault() after do_sync_mmap_readahead() or page not uptodate
synchronous read with lock dropped <- what you are optimising for, or
shmem_falloc_wait() waiting for a hole punch.

The maybe_unlock_mmap_for_io() stuff.

3. I dropped the lock and nothing was waited for, OOM me on retry!

filemap_fault() allocation failure, gotta retry because we dropped the
lock!

4. I can't do this under the VMA lock, use an mmap lock

vmf_can_call_fault(), any vm_ops without ->map_pages, __vmf_anon_prepare()
when mmap_read_trylock() lost, also hugetlb_fault() horror shows.

Also device-private swap entries.

5. Userfaultfd! Because of course!

Userspace has to do something.

handle_userfault() after sleeping for uffd handler, retry should succeed.

ctx->released -> yield to releasing thread.

6. Fatal signal

Arch handlers rely on this, so retry also means 'check signals'. Fun.

7. Some driver insanity

It means all things to all people. Used for waiting on stuff like

LLM says:

- TTM at drivers/gpu/drm/ttm/ttm_bo_vm.c:62 and 144, dma_resv contention
  and GPU idle wait. Consumers in amdgpu, i915, nouveau, radeon and vmwgfx
  re-derive "was the reservation unlocked" from ret == VM_FAULT_RETRY &&
  !NOWAIT.

- xe_bo_cpu_fault_fastpath() at drivers/gpu/drm/xe/xe_bo.c:2021, where
  RETRY is the default return value, including for "runtime PM not active".

- panthor at drivers/gpu/drm/panthor/panthor_gem.c:831 onwards, where
  dma_resv_trylock() failure is RETRY and the same error is NOPAGE, SIGBUS
  or RETRY depending on mmap_lock_held.

- sgx_vepc_fault() at arch/x86/kernel/cpu/sgx/virt.c:91, EBUSY from
  __sgx_vepc_fault().  All of these call mmap_read_unlock() directly rather
  than release_fault_lock(). They are only safe because none has
  ->map_pages, so vmf_can_call_fault() bounces them before ->fault
  runs. The VMA-lock design rests on that proxy.

So yeah. All that. Wow.

8. Nothing!

LLM says:

  - page_mkwrite() returns in fs/exfat/file.c:951 (inode_trylock lost),
    fs/nfs/file.c:699, fs/netfs/buffered_write.c:576 and
    fs/orangefs/inode.c:635 onwards, including the combination
    VM_FAULT_LOCKED | VM_FAULT_RETRY. do_page_mkwrite() at mm/memory.c only
    passes through ERROR and NOPAGE, and do_shared_fault() and
    wp_page_shared() then ignore the returned value entirely. The write
    fault completes as if page_mkwrite had succeeded.

And maybe I'm missing some stuff too.

there's also places where retries are done which don't even involve
VM_FAULT_RETRY like migration_entry_wait() and pte_same() mismatches and
do_page_mkwrite() on truncation and some other places.

I think any patch maybe doesn't have to have a massive essay but it DOES
need to ack that three are a LOT of meanings and it's a TOTAL DISASTER.

Your perf numbers look very artificial - you create situations where you
KNOW from the code you'll get mmap lock contention, then have a lot of
threads contend and gosh darn it, well the contention is really high! :)

I mean - I feel like most of your perf numbers amount to 'contend locks
gets us lock contention' - and are thus useless really?

I think the bit that _matters_ is what you're actually after which is stuff
like:

> Tencent Video cold app launch time
>
> +-----------+----------+----------+--------+
> | Statistic |  Vanilla |  Patched | Change |
> +-----------+----------+----------+--------+
> |    Mean   | 1,907 ms | 1,840 ms |  -3.5% |
> +-----------+----------+----------+--------+
> |  Maximum  | 3,023 ms | 2,851 ms |  -5.7% |
> +-----------+----------+----------+--------+

Which is not earth-shattering to me.

Now, while the patch is _small_ it takes all of the above, all of the
complexity, all of the bigger questions about how to solve this and
compresses it down into 'just retry the VMA lock'.

(I note that you change the tried logic subtly too which is another thing
but never mind that).

I worry that we're not doing the REAL work here and this is just shoving
stuff under the rug for what look to be mediocre performance improvements
in a very specific workload and costing a bunch of paths (albeit not common
ones) pointless VMA lock retries.

And I worry that maybe that actually _adds_ complexity by the back door a
bit.

But I worry a LOT more that it's just a HACK (and I know Barry was nice
about the idea and I appreciate it but I have to be honest).

Instead of dealing with any of the above, we just leave the mess in place +
just retry the operation under VMA because we happen to know, for this ONE
workload, it works out better.

And PROBABLY it doesn't add too much overhead to anything else.

SO.

I've written too much again, let's sum it up.

1. WE HAVE TO DECIDE whether we want to accept the hack because it
   helps in a known case and probably doesn't harm any other cases.

2. WE HAVE TO FIX THIS DAMN MESS. Even if we take something like this WE
   HAVE TO FIX IT.

I'm inclined to rip out the whole retry thing altogether one way or another
but I leave that to Matthew to figure out :)


If we decide we DO want the hack, then DEAR LORD can we not have this
horrible duplication across arches? I seem to remember you agreed to take
that out ([0]), and maybe it's pending what Matthew wants to do, but is
there not a way to avoid that?

ALSO. It seem we are subtly changing how the tried flag stuff works and
that really needs to be considered carefully.

And FINALLY if we DO do that, the patch message MUST be honest about the
goals MUST state EXACTLY what it's trying to optimise, it MUST clearly
state that in a comment or whatever where the code is.

It must NOT wave its arms and pretend that it's some general solution for
fault retries the way it does now. It feels like it's hiding what it's
really intended for at that just adds yet more confusion to this mess.

I REALLY want to hear from Matthew on all this, I don't think we can move
ahead without his clear feedback.

--
Cheers, Lorenzo

[0]:https://lore.kernel.org/linux-mm/20260709084752.147379-1-zhanghongru@xiaomi.com/
