Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:28256
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230038AbhAaIPv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 31 Jan 2021 03:15:51 -0500
From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Date: Sun, 31 Jan 2021 08:14:16 +0000
Message-ID: <30BE6144-A66B-4FF7-9112-35EDF6EF6304@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <1612063149.2awdsvvmhj.astroid@bobo.none>
 <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
In-Reply-To: <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3581594BDEC2384E80E3AEE6C81F192A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

> On Jan 30, 2021, at 11:57 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
>> On Jan 30, 2021, at 7:30 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> Excerpts from Nadav Amit's message of January 31, 2021 10:11 am:
>>> From: Nadav Amit <namit@vmware.com>
>>>=20
>>> There are currently (at least?) 5 different TLB batching schemes in the
>>> kernel:
>>>=20
>>> 1. Using mmu_gather (e.g., zap_page_range()).
>>>=20
>>> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>>>  ongoing deferred TLB flush and flushing the entire range eventually
>>>  (e.g., change_protection_range()).
>>>=20
>>> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>>>=20
>>> 4. Batching per-table flushes (move_ptes()).
>>>=20
>>> 5. By setting a flag on that a deferred TLB flush operation takes place=
,
>>>  flushing when (try_to_unmap_one() on x86).
>>>=20
>>> It seems that (1)-(4) can be consolidated. In addition, it seems that
>>> (5) is racy. It also seems there can be many redundant TLB flushes, and
>>> potentially TLB-shootdown storms, for instance during batched
>>> reclamation (using try_to_unmap_one()) if at the same time mmu_gather
>>> defers TLB flushes.
>>>=20
>>> More aggressive TLB batching may be possible, but this patch-set does
>>> not add such batching. The proposed changes would enable such batching
>>> in a later time.
>>>=20
>>> Admittedly, I do not understand how things are not broken today, which
>>> frightens me to make further batching before getting things in order.
>>> For instance, why is ok for zap_pte_range() to batch dirty-PTE flushes
>>> for each page-table (but not in greater granularity). Can't
>>> ClearPageDirty() be called before the flush, causing writes after
>>> ClearPageDirty() and before the flush to be lost?
>>=20
>> Because it's holding the page table lock which stops page_mkclean from=20
>> cleaning the page. Or am I misunderstanding the question?
>=20
> Thanks. I understood this part. Looking again at the code, I now understa=
nd
> my confusion: I forgot that the reverse mapping is removed after the PTE =
is
> zapped.
>=20
> Makes me wonder whether it is ok to defer the TLB flush to tlb_finish_mmu=
(),
> by performing set_page_dirty() for the batched pages when needed in
> tlb_finish_mmu() [ i.e., by marking for each batched page whether
> set_page_dirty() should be issued for that page while collecting them ].

Correcting myself (I hope): no we cannot do so, since the buffers might be
remove from the page at that point.
