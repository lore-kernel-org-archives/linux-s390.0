Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789A30DD22;
	Tue, 16 Dec 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876627; cv=none; b=UWyu4vQubqcrMjZRz5kj8vYRO8jjpqwH/Odc8H9zDOxHcdMvT4UgzaHwR1fkDFh4EYfUf+aIIoWzK2uI+ckpL1TlomREjeVTvMygtYfEtMLIKljQBp0JvKRL3Q6HVjEFxrb9+pzyZl2cGlK7tH7KBYcJ3wjjORzbylEBmnHDqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876627; c=relaxed/simple;
	bh=sy1h3UIGBeG2MMT25lIycWl3qhGlqb0+xamWgNDUFNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbaoB7mJ/igIPfI3GE6NhHOxkM19nhiTopOt501DQ/rsvbsLhXG76wkqoxyNmAUPbbd1hRPTY7+kobCYAs6aKR4kYj9Cwgut7KBqltuj0CYtqoIFhGBQXwX//253D5AQOytbwFzhbFrq7GW49zxczqZrddXB9jtSoaVhXhHgTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6985FEC;
	Tue, 16 Dec 2025 01:16:57 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E956C3F73B;
	Tue, 16 Dec 2025 01:16:59 -0800 (PST)
Message-ID: <9ae8655f-e537-43bb-ae0e-3067d2481d79@arm.com>
Date: Tue, 16 Dec 2025 09:16:58 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] randomize_kstack: Unify random source across
 arches
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Jeremy Linton
 <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20251215163520.1144179-1-ryan.roberts@arm.com>
 <20251215163520.1144179-4-ryan.roberts@arm.com>
 <202512160024.B688A8D0@keescook>
 <CAMj1kXHaqfEqDpvC-iC1fUn+JpTj=oqfM2sh+sbaC8_PBVHBUQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHaqfEqDpvC-iC1fUn+JpTj=oqfM2sh+sbaC8_PBVHBUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2025 08:30, Ard Biesheuvel wrote:
> On Tue, 16 Dec 2025 at 09:27, Kees Cook <kees@kernel.org> wrote:
>>
>> On Mon, Dec 15, 2025 at 04:35:17PM +0000, Ryan Roberts wrote:
>>> [...]
>>> @@ -45,9 +46,22 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>>>  #define KSTACK_OFFSET_MAX(x) ((x) & 0b1111111100)
>>>  #endif
>>>
>>> +DECLARE_PER_CPU(struct rnd_state, kstack_rnd_state);
>>> +
>>> +static __always_inline u32 get_kstack_offset(void)
>>> +{
>>> +     struct rnd_state *state;
>>> +     u32 rnd;
>>> +
>>> +     state = &get_cpu_var(kstack_rnd_state);
>>> +     rnd = prandom_u32_state(state);
>>> +     put_cpu_var(kstack_rnd_state);
>>> +
>>> +     return rnd;
>>> +}
>>> [...]
>>> -static inline void random_kstack_task_init(struct task_struct *tsk)
>>> +static int random_kstack_init(void)
>>>  {
>>> -     tsk->kstack_offset = 0;
>>> +     prandom_seed_full_state(&kstack_rnd_state);
>>> +     return 0;
>>>  }
>>> +
>>> +late_initcall(random_kstack_init);
>>
>> Doesn't this need to be run for every CPU? (And how does hotplug work
>> for such things?) And doesn't it need a get_cpu_var?
>>
> 
> 
>  prandom_seed_full_state() takes a 'struct rnd_state __percpu
> *pcpu_state', and performs the initialization for all possible CPUs.

Yes, indeed, prandom_seed_full_state() is initializing all possible CPUs so it
doesn't matter if it gets migrated. I believe this is correct as is.

void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
{
	int i;

	for_each_possible_cpu(i) {
		struct rnd_state *state = per_cpu_ptr(pcpu_state, i);
		u32 seeds[4];

		get_random_bytes(&seeds, sizeof(seeds));
		state->s1 = __seed(seeds[0],   2U);
		state->s2 = __seed(seeds[1],   8U);
		state->s3 = __seed(seeds[2],  16U);
		state->s4 = __seed(seeds[3], 128U);

		prandom_warmup(state);
	}
}

