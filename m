Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC83BA258;
	Tue,  3 Mar 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548991; cv=none; b=fCu6h3vViwQ3CtFpOHXSoXA8d5R/5lLc8GSpfQ6zq2OrVXB4wXxR8t0Iv2Z/URnQnV7iR4uPwz6RzAYDYw9vOEJVar3hZOKkBBb3qSz99PBj9Ir2gs11zSkpuoPo0ZSvImxVC6Q7H/akZKTZnWdCYns5LhYMRYzRa+Bvbesb9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548991; c=relaxed/simple;
	bh=EMGnVRjQbLjyIY9qUixp0Up05NpgzTmwbXFz2gri1Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFycvewPT9B24MDXBfj06DAy97foxhlUADyeydv8JXEdWx+j2lR0rinrlwJUlzgbtbw+MffjLJhEzTjD1famLuA/9SM4bRqgkkSHvC6RV8BkhBgot00r0csJ/Bq8rglYm1sY9T371iVa/K0bA1VZCeACUtsdiuHoJG/BZ7yG19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D7F4497;
	Tue,  3 Mar 2026 06:43:03 -0800 (PST)
Received: from [10.1.31.220] (XHFQ2J9959.cambridge.arm.com [10.1.31.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12EE23F694;
	Tue,  3 Mar 2026 06:43:05 -0800 (PST)
Message-ID: <8c799a17-56e3-4ea4-84a2-b878337bddfd@arm.com>
Date: Tue, 3 Mar 2026 14:43:04 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across
 arches
Content-Language: en-GB
To: Thomas Gleixner <tglx@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-4-ryan.roberts@arm.com> <87ecmcwjh9.ffs@tglx>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87ecmcwjh9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2026 21:34, Thomas Gleixner wrote:
> On Mon, Jan 19 2026 at 13:01, Ryan Roberts wrote:
>> I tested an earlier version of this change on x86 bare metal and it
>> showed a smaller but still significant improvement. The bare metal
>> system wasn't available this time around so testing was done in a VM
>> instance. I'm guessing the cost of rdtsc is higher for VMs.
> 
> No it's not, unless the hypervisor traps RDTSC, which would be insane as
> that would cause massive regressions all over the place.
> 
> So guessing is not really helpful if you want to argue performance.

Sorry for the slow response. I no longer have access to a recent bare metal x86
system that I can do performance testing on. All I have is the Sapphire Rapids
(m7i.24xlarge) VM.

My original testing was on bare metal Sapphire Rapids (same number of CPUs and
RAM as the VM).

Just to be clear, these are the results I got with bare metal vs vm. Negative is
an improvement (less time). (I)/(R) means statistically significant
improvement/regression:

+-----------------+--------------+---------------+---------------+
| Benchmark       | Result Class |        x86_64 |        x86_64 |
|                 |              |    bare metal |            VM |
+=================+==============+===============+===============+
| syscall/getpid  | mean (ns)    |    (I) -7.69% |   (I) -17.65% |
|                 | p99 (ns)     |         4.14% |   (I) -24.41% |
|                 | p99.9 (ns)   |         2.68% |   (I) -28.52% |
+-----------------+--------------+---------------+---------------+
| syscall/getppid | mean (ns)    |    (I) -5.98% |   (I) -19.24% |
|                 | p99 (ns)     |        -3.11% |   (I) -25.03% |
|                 | p99.9 (ns)   |     (R) 9.84% |   (I) -28.17% |
+-----------------+--------------+---------------+---------------+
| syscall/invalid | mean (ns)    |    (I) -6.94% |   (I) -18.56% |
|                 | p99 (ns)     |    (I) -5.57% |   (I) -20.06% |
|                 | p99.9 (ns)   |    (R) 10.53% |   (I) -25.04% |
+-----------------+--------------+---------------+---------------+

So both sets of results represent an improvement, I would say.

Given the level of review that the series has had, I propose to repost today,
then hopefully Kees will be happy to put it in his branch so that it can get
plenty of linux-next soak testing and if there are any x86 regressions lurking,
hopefully ZeroDay will spot them?

Thanks,
Ryan


> 
> Thanks,
> 
>         tglx

