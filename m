Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaDbd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 30 Jan 2021 22:31:33 -0500
Date: Sun, 31 Jan 2021 13:30:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
References: <20210131001132.3368247-1-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Message-Id: <1612063149.2awdsvvmhj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Nadav Amit <nadav.amit@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <namit@vmware.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org, Yu Zhao <yuzhao@google.com>

Excerpts from Nadav Amit's message of January 31, 2021 10:11 am:
> From: Nadav Amit <namit@vmware.com>
>=20
> There are currently (at least?) 5 different TLB batching schemes in the
> kernel:
>=20
> 1. Using mmu_gather (e.g., zap_page_range()).
>=20
> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>    ongoing deferred TLB flush and flushing the entire range eventually
>    (e.g., change_protection_range()).
>=20
> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>=20
> 4. Batching per-table flushes (move_ptes()).
>=20
> 5. By setting a flag on that a deferred TLB flush operation takes place,
>    flushing when (try_to_unmap_one() on x86).
>=20
> It seems that (1)-(4) can be consolidated. In addition, it seems that
> (5) is racy. It also seems there can be many redundant TLB flushes, and
> potentially TLB-shootdown storms, for instance during batched
> reclamation (using try_to_unmap_one()) if at the same time mmu_gather
> defers TLB flushes.
>=20
> More aggressive TLB batching may be possible, but this patch-set does
> not add such batching. The proposed changes would enable such batching
> in a later time.
>=20
> Admittedly, I do not understand how things are not broken today, which
> frightens me to make further batching before getting things in order.
> For instance, why is ok for zap_pte_range() to batch dirty-PTE flushes
> for each page-table (but not in greater granularity). Can't
> ClearPageDirty() be called before the flush, causing writes after
> ClearPageDirty() and before the flush to be lost?

Because it's holding the page table lock which stops page_mkclean from=20
cleaning the page. Or am I misunderstanding the question?

I'll go through the patches a bit more closely when they all come=20
through. Sparc and powerpc of course need the arch lazy mode to get=20
per-page/pte information for operations that are not freeing pages,=20
which is what mmu gather is designed for.

I wouldn't mind using a similar API so it's less of a black box when=20
reading generic code, but it might not quite fit the mmu gather API
exactly (most of these paths don't want a full mmu_gather on stack).

>=20
> This patch-set therefore performs the following changes:
>=20
> 1. Change mprotect, task_mmu and mapping_dirty_helpers to use mmu_gather
>    instead of {inc|dec}_tlb_flush_pending().
>=20
> 2. Avoid TLB flushes if PTE permission is not demoted.
>=20
> 3. Cleans up mmu_gather to be less arch-dependant.
>=20
> 4. Uses mm's generations to track in finer granularity, either per-VMA
>    or per page-table, whether a pending mmu_gather operation is
>    outstanding. This should allow to avoid some TLB flushes when KSM or
>    memory reclamation takes place while another operation such as
>    munmap() or mprotect() is running.
>=20
> 5. Changes try_to_unmap_one() flushing scheme, as the current seems
>    broken to track in a bitmap which CPUs have outstanding TLB flushes
>    instead of having a flag.

Putting fixes first, and cleanups and independent patches (like #2) next
would help with getting stuff merged and backported.

Thanks,
Nick
