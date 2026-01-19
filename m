Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A629BDB4;
	Mon, 19 Jan 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841502; cv=none; b=Fr5TkPabHJdiHTTKDTIWaam7UFacvG/cDLjc2NMU0AOUEO4O3r6cdFmlt3KQyUpSFSS7Slam7eTmwAeya5c5iTVjFNPeRk0l2IL5lSRGCG9i2f0fR180Xif6ZOFyQOfi8+TUyOoXy7GsoTcf7bB0eg6O4AXiptbxwBAr8NADqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841502; c=relaxed/simple;
	bh=p098u2QcF7PcYF7PLCedwxsYfwpiCc19sPIk+R78juM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0RuTnRpt2v/X+Z3OulPNjKrDc3VnCrhOWv9aKjex6LItkSgTEe1kO9t3/mb9YTM6yTmATXCTK+B4g11ayuC48WYATzaouFYoJcv2bIf9te469N5uqJoXUEh7YgkOGvyJCqs10qU3GpE3HIS41TT3ynqkaoDg5y8vXsRMMjbH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A4B497;
	Mon, 19 Jan 2026 08:51:32 -0800 (PST)
Received: from [10.57.93.204] (unknown [10.57.93.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE0C3F632;
	Mon, 19 Jan 2026 08:51:33 -0800 (PST)
Message-ID: <31187502-2a11-4ef3-82b4-927a271d8b44@arm.com>
Date: Mon, 19 Jan 2026 16:51:32 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] randomize_kstack: Maintain kstack_offset per task
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-2-ryan.roberts@arm.com>
 <85d0d013-eca2-4b9f-bee3-d583d0eeb99e@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <85d0d013-eca2-4b9f-bee3-d583d0eeb99e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the review!

On 19/01/2026 16:10, Dave Hansen wrote:
> On 1/19/26 05:01, Ryan Roberts wrote:
> ...
>> Cc: stable@vger.kernel.org
> 
> Since this doesn't fix any known functional issues, if it were me, I'd
> leave stable@ alone. It isn't clear that this is stable material.

I listed 2 issues in the commit log; I agree that issue 1 falls into the
category of "don't really care", but issue 2 means that kstack randomization is
currently trivial to defeat. That's the reason I thought it would valuable in
stable.

But if you're saying don't bother and others agree, then this whole patch can be
dropped; this is just intended to be the backportable fix. Patch 3 reimplements
this entirely for upstream.

I'll wait and see if others have opinions if that's ok?

> 
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1591,6 +1591,10 @@ struct task_struct {
>>  	unsigned long			prev_lowest_stack;
>>  #endif
>>  
>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>> +	u32				kstack_offset;
>> +#endif
>> +
>>  #ifdef CONFIG_X86_MCE
>>  	void __user			*mce_vaddr;
> 
> Nit: This seems to be throwing a u32 potentially in between a couple of
> void*/ulong sized objects.

Yeah, I spent a bit of time with pahole but eventually concluded that it was
difficult to find somewhere to nestle it that would work reliably cross arch.
Eventually I just decided to group it with other stack meta data.

> 
> It probably doesn't matter with struct randomization and it's really
> hard to get right among the web of task_struct #ifdefs. But, it would be
> nice to at _least_ nestle this next to another int-sized thing.
> 
> Does it really even need to be 32 bits? x86 has this comment:
> 
>>         /*
>>          * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
>>          * bits. The actual entropy will be further reduced by the compiler
>>          * when applying stack alignment constraints (see cc_stack_align4/8 in
>>          * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
>>          * low bits from any entropy chosen here.
>>          *
>>          * Therefore, final stack offset entropy will be 7 (x86_64) or
>>          * 8 (ia32) bits.
>>          */

For more recent kernels it's 6 bits shifted by 4 for 64-bit kernels or 8 bits
shifted by 2 for 32-bit kernels regardless of arch. So could probably make it
work with 8 bits of storage. Although I was deliberately trying to keep the
change simple, since it was intended for backporting. Patch 3 rips it out.

Overall I'd prefer to leave it all as is. But if people don't think we should
backport, then let's just drop the whole patch.

Thanks,
Ryan


