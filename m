Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 02 Feb 2021 16:41:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
References: <20210131001132.3368247-1-namit@vmware.com>
        <20210131001132.3368247-12-namit@vmware.com>
        <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
In-Reply-To: <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1612247956.0a1r1yjmm3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org, Yu Zhao <yuzhao@google.com>

Excerpts from Peter Zijlstra's message of February 1, 2021 10:09 pm:
> On Sat, Jan 30, 2021 at 04:11:23PM -0800, Nadav Amit wrote:
>=20
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 427bfcc6cdec..b97136b7010b 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -334,8 +334,8 @@ static inline void __tlb_reset_range(struct mmu_gath=
er *tlb)
>> =20
>>  #ifdef CONFIG_MMU_GATHER_NO_RANGE
>> =20
>> -#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma=
)
>> -#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma=
() and tlb_end_vma()
>> +#if defined(tlb_flush)
>> +#error MMU_GATHER_NO_RANGE relies on default tlb_flush()
>>  #endif
>> =20
>>  /*
>> @@ -362,10 +362,6 @@ static inline void tlb_end_vma(struct mmu_gather *t=
lb, struct vm_area_struct *vm
>> =20
>>  #ifndef tlb_flush
>> =20
>> -#if defined(tlb_start_vma) || defined(tlb_end_vma)
>> -#error Default tlb_flush() relies on default tlb_start_vma() and tlb_en=
d_vma()
>> -#endif
>=20
> #ifdef CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING
> #error ....
> #endif
>=20
> goes here...
>=20
>=20
>>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_s=
truct *vma)
>>  {
>>  	if (tlb->fullmm)
>>  		return;
>> =20
>> +	if (IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING))
>> +		return;
>=20
> Also, can you please stick to the CONFIG_MMU_GATHER_* namespace?
>=20
> I also don't think AGRESSIVE_FLUSH_BATCHING quite captures what it does.
> How about:
>=20
> 	CONFIG_MMU_GATHER_NO_PER_VMA_FLUSH

Yes please, have to have descriptive names.

I didn't quite see why this was much of an improvement though. Maybe=20
follow up patches take advantage of it? I didn't see how they all fit=20
together.

Thanks,
Nick
