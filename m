Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB932ED52;
	Mon,  5 Jan 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611125; cv=none; b=mH4XgpF40aDN3mSDSxGcjYgFg2+nyresTOiQHdk4iA25dfZcPU1wlOCo+1eoHcG3MmfhVLG8ex9venUV/t7ljdPbPFuSMYaLqlyJGlpsynsHvjedahTs3zPyMEfgeEDym2TKi7MJw+wI83SXt0wyvgprJDm4JoNsnKU9w80MWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611125; c=relaxed/simple;
	bh=/IWMkjWKAb7cBRk9rXBo7XSunxAC8lWcg1+e5MkGQ1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5tC3VMaM5+evfmTJQe4S6vE9MN6jlnxxPKIoTFopP2BQFAlGtFCqRwNjbxOaTElv8FVgdnsH9UY9CBgIRfsjgY766eNGvQirocV4q7yrhitxuZJyc7Bklh1li372khRpkuU3vuXxfhsAoOWwf5ofRtPhTABfR+MATcVbnFX21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6BC5497;
	Mon,  5 Jan 2026 03:05:15 -0800 (PST)
Received: from [10.1.38.150] (XHFQ2J9959.cambridge.arm.com [10.1.38.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652C93F5A1;
	Mon,  5 Jan 2026 03:05:19 -0800 (PST)
Message-ID: <60c5d7b1-1ab7-490c-8cb8-dfd50cf23856@arm.com>
Date: Mon, 5 Jan 2026 11:05:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] randomize_kstack: Unify random source across
 arches
Content-Language: en-GB
To: David Laight <david.laight.linux@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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
 Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
 <20260102131156.3265118-4-ryan.roberts@arm.com>
 <20260104230136.7aaf8886@pumpkin>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260104230136.7aaf8886@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2026 23:01, David Laight wrote:
> On Fri,  2 Jan 2026 13:11:54 +0000
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Previously different architectures were using random sources of
>> differing strength and cost to decide the random kstack offset. A number
>> of architectures (loongarch, powerpc, s390, x86) were using their
>> timestamp counter, at whatever the frequency happened to be. Other
>> arches (arm64, riscv) were using entropy from the crng via
>> get_random_u16().
>>
>> There have been concerns that in some cases the timestamp counters may
>> be too weak, because they can be easily guessed or influenced by user
>> space. And get_random_u16() has been shown to be too costly for the
>> level of protection kstack offset randomization provides.
>>
>> So let's use a common, architecture-agnostic source of entropy; a
>> per-cpu prng, seeded at boot-time from the crng. This has a few
>> benefits:
>>
>>   - We can remove choose_random_kstack_offset(); That was only there to
>>     try to make the timestamp counter value a bit harder to influence
>>     from user space.
>>
>>   - The architecture code is simplified. All it has to do now is call
>>     add_random_kstack_offset() in the syscall path.
>>
>>   - The strength of the randomness can be reasoned about independently
>>     of the architecture.
>>
>>   - Arches previously using get_random_u16() now have much faster
>>     syscall paths, see below results.
>>
>> There have been some claims that a prng may be less strong than the
>> timestamp counter if not regularly reseeded. But the prng has a period
>> of about 2^113. So as long as the prng state remains secret, it should
>> not be possible to guess. If the prng state can be accessed, we have
>> bigger problems.
> 
> If you have 128 bits of output from consecutive outputs I think you
> can trivially determine the full state using (almost) 'school boy' maths
> that could be done on pencil and paper.
> (Most of the work only has to be done once.)
> 
> The underlying problem is that the TAUSWORTHE() transformation is 'linear'
> So that TAUSWORTHE(x ^ y) == TAUSWORTHE(x) ^ TAUSWORTHE(y).
> (This is true of a LFSR/CRC and TOUSWORTH() is doing some subset of CRCs.)
> This means that each output bit is the 'xor' of some of the input bits.
> The four new 'state' values are just xor of the the bits of the old ones.
> The final xor of the four states gives a 32bit value with each bit just
> an xor of some of the 128 state bits.
> Get four consecutive 32 bit values and you can solve the 128 simultaneous
> equations (by trivial substitution) and get the initial state.
> The solution gives you the 128 128bit constants for:
> 	u128 state = 0;
> 	u128 val = 'value returned from 4 calls';
> 	for (int i = 0; i < 128; i++)
> 		state |= parity(const128[i] ^ val) << i;

What is const128[] here?

> You done need all 32bits, just accumulate 128 bits.  
> So if you can get the 5bit stack offset from 26 system calls you know the
> value that will be used for all the subsequent calls.

It's not immediately obvious to me how user space would do this, but I'll take
it on faith that it may be possible.

> 
> Simply changing the final line to use + not ^ makes the output non-linear
> and solving the equations a lot harder.

There has been pushback on introducing new primitives [1] but I don't think
that's a reason not to considder it.

[1] https://lore.kernel.org/all/aRyppb8PCxFKVphr@zx2c4.com/

> 
> I might sit down tomorrow and see if I can actually code it...

Thanks for the analysis! I look forward to seeing your conclusion... although
I'm not sure I'll be qualified to evaluate it mathematically.

FWIW, I previously had a go at various schemes using siphash to calculate some
random bits. I found it to be significantly slower than this prng. I've so far
taken the view that 6 bits of randomness is not much of a defence against brute
force so we really shouldn't be spending too many cycles to generate the bits.
If we can get to approach to work, I think that's best.

Thanks,
Ryan

> 
> 	David
> 
>  

