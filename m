Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232514AbhAaAkj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 Jan 2021 19:40:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E3E64E25
        for <linux-s390@vger.kernel.org>; Sun, 31 Jan 2021 00:39:54 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id dj23so14808719edb.13
        for <linux-s390@vger.kernel.org>; Sat, 30 Jan 2021 16:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 30 Jan 2021 16:39:41 -0800
Message-ID: <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-csky@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Nadav Amit <namit@vmware.com>
>
> There are currently (at least?) 5 different TLB batching schemes in the
> kernel:
>
> 1. Using mmu_gather (e.g., zap_page_range()).
>
> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>    ongoing deferred TLB flush and flushing the entire range eventually
>    (e.g., change_protection_range()).
>
> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>
> 4. Batching per-table flushes (move_ptes()).
>
> 5. By setting a flag on that a deferred TLB flush operation takes place,
>    flushing when (try_to_unmap_one() on x86).

Are you referring to the arch_tlbbatch_add_mm/flush mechanism?
