Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507136212B;
	Mon, 19 Jan 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827606; cv=none; b=JFrmBWQe5qLyri5Fp++PPXTbjPISHgfyQtVMIMLlKdLlHrKbHW98Q6vB9l8zvBoSrIk4bILjb5Wz+xsuCfWtePlbkILMDSOkrSWwlta/4WDXa+XT0hYjgBXs3Q6S7R4hKKowWzO4ioX3tpIbNyKIu6S2dvWEvw3Ngt6+Pnkz1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827606; c=relaxed/simple;
	bh=R+3nwdRynboPRKN0wMkyKYy7AfSC7YOCXWI9kb02krc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LznBwFMbTJYZURQfG669BHe5ByZA8ympccw6FIYFWaUYuRjx33LAmnSeU+jUwArHuIiQQg826RMC4Ui3Sa1KyaYTMnOfWBxddju13ijl2540q2P3jpYNPLBTcTexIXollMmWBpDar0mKrNksEYdfKJBkCv+BIIImvBNETEAsWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE1A4497;
	Mon, 19 Jan 2026 04:59:56 -0800 (PST)
Received: from [10.57.93.204] (unknown [10.57.93.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3DC63F740;
	Mon, 19 Jan 2026 04:59:58 -0800 (PST)
Message-ID: <d3573f72-e476-43ba-8929-c3b6931d06f2@arm.com>
Date: Mon, 19 Jan 2026 12:59:57 +0000
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
To: Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
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
 <arnd@arndb.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
 <aW4NC9P3K7Ab_e8j@J2N7QTR9R3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aW4NC9P3K7Ab_e8j@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 10:52, Mark Rutland wrote:
> On Fri, Jan 02, 2026 at 01:11:51PM +0000, Ryan Roberts wrote:
>> Hi All,
> 
> Hi Ryan,
> 
>> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
>> and, on arm64 at least, the performance is poor. This series attempts to fix
>> both; patch 1 provides back-portable fixes for the functional bugs. Patches 2-3
>> propose a performance improvement approach.
>>
>> I've looked at a few different options but ultimately decided that Jeremy's
>> original prng approach is the fastest. I made the argument that this approach is
>> secure "enough" in the RFC [2] and the responses indicated agreement.
> 
> FWIW, the series all looks good to me. I understand you're likely to
> spin a v4 with a couple of minor tweaks (fixing typos and adding an
> out-of-line wrapper for a prandom function), but I don't think there's
> anything material that needs to change.

Thanks for the review, Mark! v4 incomming...

> 
> I've given my Ack on all three patches. I've given the series a quick
> boot test (atop v6.19-rc4) with a bunch of debug options enabled, and
> all looks well.
> 
> Kees, do you have any comments? It would be nice if we could queue this
> up soon.
> 
> Mark.
> 
>> More details in the commit logs.
>>
>>
>> Performance
>> ===========
>>
>> Mean and tail performance of 3 "small" syscalls was measured. syscall was made
>> 10 million times and each individually measured and binned. These results have
>> low noise so I'm confident that they are trustworthy.
>>
>> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
>> performance cost of turning it on without any changes to the implementation,
>> then the reduced performance cost of turning it on with my changes applied.
>>
>> **NOTE**: The below results were generated using the RFC patches but there is no
>> meaningful change, so the numbers are still valid.
>>
>> arm64 (AWS Graviton3):
>> +-----------------+--------------+-------------+---------------+
>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng |
>> |                 |              | rndstack-on |               |
>> |                 |              |             |               |
>> +=================+==============+=============+===============+
>> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |
>> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |
>> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |
>> +-----------------+--------------+-------------+---------------+
>> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |
>> |                 | p99 (ns)     | (R) 152.81% |         1.55% |
>> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |
>> +-----------------+--------------+-------------+---------------+
>> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |
>> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |
>> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |
>> +-----------------+--------------+-------------+---------------+
>>
>> Because arm64 was previously using get_random_u16(), it was expensive when it
>> didn't have any buffered bits and had to call into the crng. That's what caused
>> the enormous tail latency.
>>
>>
>> x86 (AWS Sapphire Rapids):
>> +-----------------+--------------+-------------+---------------+
>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng |
>> |                 |              | rndstack-on |               |
>> |                 |              |             |               |
>> +=================+==============+=============+===============+
>> | syscall/getpid  | mean (ns)    |  (R) 13.32% |     (R) 4.60% |
>> |                 | p99 (ns)     |  (R) 13.38% |    (R) 18.08% |
>> |                 | p99.9 (ns)   |      16.26% |    (R) 19.38% |
>> +-----------------+--------------+-------------+---------------+
>> | syscall/getppid | mean (ns)    |  (R) 11.96% |     (R) 5.26% |
>> |                 | p99 (ns)     |  (R) 11.83% |     (R) 8.35% |
>> |                 | p99.9 (ns)   |  (R) 11.42% |    (R) 22.37% |
>> +-----------------+--------------+-------------+---------------+
>> | syscall/invalid | mean (ns)    |  (R) 10.58% |     (R) 2.91% |
>> |                 | p99 (ns)     |  (R) 10.51% |     (R) 4.36% |
>> |                 | p99.9 (ns)   |  (R) 10.35% |    (R) 21.97% |
>> +-----------------+--------------+-------------+---------------+
>>
>> I was surprised to see that the baseline cost on x86 is 10-12% since it is just
>> using rdtsc. But as I say, I believe the results are accurate.
>>
>>
>> Changes since v2 (RFC) [3]
>> ==========================
>>
>> - Moved late_initcall() to initialize kstack_rnd_state out of
>>   randomize_kstack.h and into main.c. (issue noticed by kernel test robot)
>>
>> Changes since v1 (RFC) [2]
>> ==========================
>>
>> - Introduced patch 2 to make prandom_u32_state() __always_inline (needed since
>>   its called from noinstr code)
>> - In patch 3, prng is now per-cpu instead of per-task (per Ard)
>>
>>
>> [1] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
>> [2] https://lore.kernel.org/all/20251127105958.2427758-1-ryan.roberts@arm.com/
>> [3] https://lore.kernel.org/all/20251215163520.1144179-1-ryan.roberts@arm.com/
>>
>> Thanks,
>> Ryan
>>
>>
>> Ryan Roberts (3):
>>   randomize_kstack: Maintain kstack_offset per task
>>   prandom: Convert prandom_u32_state() to __always_inline
>>   randomize_kstack: Unify random source across arches
>>
>>  arch/Kconfig                         |  5 ++-
>>  arch/arm64/kernel/syscall.c          | 11 ------
>>  arch/loongarch/kernel/syscall.c      | 11 ------
>>  arch/powerpc/kernel/syscall.c        | 12 -------
>>  arch/riscv/kernel/traps.c            | 12 -------
>>  arch/s390/include/asm/entry-common.h |  8 -----
>>  arch/x86/include/asm/entry-common.h  | 12 -------
>>  include/linux/prandom.h              | 19 +++++++++-
>>  include/linux/randomize_kstack.h     | 54 +++++++++++-----------------
>>  init/main.c                          |  9 ++++-
>>  kernel/fork.c                        |  1 +
>>  lib/random32.c                       | 19 ----------
>>  12 files changed, 49 insertions(+), 124 deletions(-)
>>
>> --
>> 2.43.0
>>

