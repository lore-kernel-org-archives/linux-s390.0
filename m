Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539731D750;
	Mon, 19 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827541; cv=none; b=Fe2vimVnlTwXiyyEYd5Cdmj0KGOUfq4V9u+AFKlCERxHmQkIXmAdR9RJbvbnUDu2N40uOTzzEmu2KFvpPLSPriS1o5OsYoOCtZIP/bNVfacar5gTfKgkPIPUO3TzU6k2ia+oQeg0lQRethtDbtpfFHqRaXeOGhdPd+h3gtmu7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827541; c=relaxed/simple;
	bh=NttKztIOy0IasX59E5ekHublqridOFTmX2aRWJnlsmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhfydNk3tpRrWDULjkeJ7oK/op38dmZuO8nP+31M8wJw+GoccbMwGWEFdwrQ0T+maVmGDmlQH1UV1yYoQ+Q3xRgEB1xf2SkFIoG66UuKSiNzjsxkU/BTOYeHdeC6pkFvWf9QXwEa/5ESz2zEmRE3pwYYYjKKlLSsEP1PJkTfGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31E1497;
	Mon, 19 Jan 2026 04:58:52 -0800 (PST)
Received: from [10.57.93.204] (unknown [10.57.93.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEBCD3F740;
	Mon, 19 Jan 2026 04:58:54 -0800 (PST)
Message-ID: <95da406c-e8e9-4029-bdbe-845322037be5@arm.com>
Date: Mon, 19 Jan 2026 12:58:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix bugs and performance of kstack offset
 randomisation
Content-Language: en-GB
To: David Laight <david.laight.linux@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
 <aW4NC9P3K7Ab_e8j@J2N7QTR9R3> <20260119122248.30974c78@pumpkin>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260119122248.30974c78@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 12:22, David Laight wrote:
> On Mon, 19 Jan 2026 10:52:59 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> On Fri, Jan 02, 2026 at 01:11:51PM +0000, Ryan Roberts wrote:
>>> Hi All,  
>>
>> Hi Ryan,
>>
>>> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
>>> and, on arm64 at least, the performance is poor. This series attempts to fix
>>> both; patch 1 provides back-portable fixes for the functional bugs. Patches 2-3
>>> propose a performance improvement approach.
>>>
>>> I've looked at a few different options but ultimately decided that Jeremy's
>>> original prng approach is the fastest. I made the argument that this approach is
>>> secure "enough" in the RFC [2] and the responses indicated agreement.  
>>
>> FWIW, the series all looks good to me. I understand you're likely to
>> spin a v4 with a couple of minor tweaks (fixing typos and adding an
>> out-of-line wrapper for a prandom function), but I don't think there's
>> anything material that needs to change.
>>
>> I've given my Ack on all three patches. I've given the series a quick
>> boot test (atop v6.19-rc4) with a bunch of debug options enabled, and
>> all looks well.
>>
>> Kees, do you have any comments? It would be nice if we could queue this
>> up soon.
> 
> I don't want to stop this being queued up in its current form.
> But I don't see an obvious need for multiple per-cpu prng
> (there are a couple of others lurking), surely one will do.

I see 2 other per-cpu prngs; one for BPF and one for the scheduler. The state is
16 bytes per prng, per cpu. So personally I think the maintainability advantages
of keeping them separate to their respective subsystems wins out vs the memory
cost in this particular case?

> 
> How much overhead does the get_cpu_var() add?
> I think it has to disable pre-emption (or interrupts) which might
> be more expensive on non-x86 (which can just do 'inc %gs:address').

The RFC used a per-task prng, then v2 switched to per-cpu. Performance numbers
can be compared from those 2 for arm64 only (the x86 numbers are from different
systems in the 2 version):

RFC: https://lore.kernel.org/all/20251127105958.2427758-3-ryan.roberts@arm.com/
v2: https://lore.kernel.org/all/20251215163520.1144179-4-ryan.roberts@arm.com/

+-----------------+--------------+---------------+---------------+
| Benchmark       | Result Class | per-task-prng |  per-cpu-prng |
|                 |              |         arm64 |         arm64 |
+=================+==============+===============+===============+
| syscall/getpid  | mean (ns)    |   (I) -10.54% |    (I) -9.50% |
|                 | p99 (ns)     |   (I) -59.53% |   (I) -59.24% |
|                 | p99.9 (ns)   |   (I) -59.90% |   (I) -59.52% |
+-----------------+--------------+---------------+---------------+
| syscall/getppid | mean (ns)    |   (I) -10.49% |    (I) -9.52% |
|                 | p99 (ns)     |   (I) -59.83% |   (I) -59.25% |
|                 | p99.9 (ns)   |   (I) -59.88% |   (I) -59.50% |
+-----------------+--------------+---------------+---------------+
| syscall/invalid | mean (ns)    |    (I) -9.28% |   (I) -10.31% |
|                 | p99 (ns)     |   (I) -61.06% |   (I) -60.79% |
|                 | p99.9 (ns)   |   (I) -61.40% |   (I) -61.04% |
+-----------------+--------------+---------------+---------------+

So getpid and getppid are a small amount better with per-task. invalid is a
small amount better with per-cpu. I decided that it's likely mostly noise and
per-cpu is therefore preferable since it costs (a bit) less memory.

> 
> I'm sure I remember a version that used a per-task prng.

Yes; as per above.

> That just needs 'current' - which might be known and/or be cheaper
> to get.
> (Although I also remember a reference some system where it was slow...)
> 
> The other option is just to play 'fast and loose' with the prng data.
> Using the state from the 'wrong cpu' (if the code is pre-empted) won't
> really matter.
> You might get a RrwW (or even RrwrwW) sequence, but the prng won't be used
> for anything 'really important' so it shouldn't matter.

As per above, I'm not really seeing much performance cost.

My opinion is that this series represents an improvement over what's already
there. I'd be happy to review an additional series to merge per-cpu prngs, but I
don't think that should be a prerequisite for getting this series merged.

Thanks,
Ryan

> 
> 	David

