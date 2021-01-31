Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:7136
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232426AbhAaBJD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 Jan 2021 20:09:03 -0500
From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Date: Sun, 31 Jan 2021 01:08:08 +0000
Message-ID: <34961389-0BFD-4F30-84AF-FB2FE5B07949@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
In-Reply-To: <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1C9C8C367CECB4EB7C409D0F1B224C1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

> On Jan 30, 2021, at 4:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> There are currently (at least?) 5 different TLB batching schemes in the
>> kernel:
>>=20
>> 1. Using mmu_gather (e.g., zap_page_range()).
>>=20
>> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>>   ongoing deferred TLB flush and flushing the entire range eventually
>>   (e.g., change_protection_range()).
>>=20
>> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>>=20
>> 4. Batching per-table flushes (move_ptes()).
>>=20
>> 5. By setting a flag on that a deferred TLB flush operation takes place,
>>   flushing when (try_to_unmap_one() on x86).
>=20
> Are you referring to the arch_tlbbatch_add_mm/flush mechanism?

Yes.
