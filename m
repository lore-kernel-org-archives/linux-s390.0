Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:46575
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231158AbhBBHVu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Feb 2021 02:21:50 -0500
From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Date: Tue, 2 Feb 2021 07:20:55 +0000
Message-ID: <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
In-Reply-To: <1612247956.0a1r1yjmm3.astroid@bobo.none>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36FF6560AB7F494FB9A440197E9AD6F6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

> On Feb 1, 2021, at 10:41 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> Excerpts from Peter Zijlstra's message of February 1, 2021 10:09 pm:
>> I also don't think AGRESSIVE_FLUSH_BATCHING quite captures what it does.
>> How about:
>>=20
>> 	CONFIG_MMU_GATHER_NO_PER_VMA_FLUSH
>=20
> Yes please, have to have descriptive names.

Point taken. I will fix it.

>=20
> I didn't quite see why this was much of an improvement though. Maybe=20
> follow up patches take advantage of it? I didn't see how they all fit=20
> together.

They do, but I realized as I said in other emails that I have a serious bug
in the deferred invalidation scheme.

Having said that, I think there is an advantage of having an explicit confi=
g
option instead of relying on whether tlb_end_vma is defined. For instance,
Arm does not define tlb_end_vma, and consequently it flushes the TLB after
each VMA. I suspect it is not intentional.
