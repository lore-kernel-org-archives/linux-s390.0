Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C53C0B;
	Wed, 18 Dec 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505193; cv=none; b=cY3SoaD2Q8Baz+Q0fVUnjHcbogmd2lhYJpQr0VEaFfg4Kw5bTp7HSRkMFFGMcAqUSqzE0OcHm9Urc8nUEnLIEl8akWTQNlSxCVH1wrewQoD4NISiyGZ2pu6e4KX+Zaj6cSx92ypZ9AMv0QNYXNG9GmNm2JdIcIouRIWwtmjq6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505193; c=relaxed/simple;
	bh=6XkxCLnkagCQrqnMXLNlKWRCkotbGzdLQUScvqzHCWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5IcLiwqsNEwaivlkCFn3wXV/fxfPZRCcxOeutjL6CnwAwWmpqZwzTXwLRzhKP/fUmUhHPkf4j9cO89IpsQVLVBk2gc5D0ubF13tdWJ8PZMNMUT66oO4nksFXSjs/g+HchLCfUeTKJdzWmnPbBSoGJRImNJoFqOyiZV83t9HgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DF8FEC;
	Tue, 17 Dec 2024 23:00:18 -0800 (PST)
Received: from [10.163.50.13] (unknown [10.163.50.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7733F720;
	Tue, 17 Dec 2024 22:59:43 -0800 (PST)
Message-ID: <27980882-4433-443f-abd1-ea5d96b687ea@arm.com>
Date: Wed, 18 Dec 2024 12:29:40 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Drop GENERIC_PTDUMP
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc: steven.price@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20241217034807.2541349-1-anshuman.khandual@arm.com>
 <ddd4439e-6f6f-4513-a7dc-b7f01bec03dc@csgroup.eu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ddd4439e-6f6f-4513-a7dc-b7f01bec03dc@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/17/24 13:17, Christophe Leroy wrote:
> 
> 
> Le 17/12/2024 à 04:48, Anshuman Khandual a écrit :
>> GENERIC_PTDUMP does not guard any code but instead just used for platform's
>> subscription into core ptdump defined under PTDUMP_CORE, which is selected.
>> Instead use PTDUMP_CORE for platform subscription and drop GENERIC_PTDUMP.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kvmarm@lists.linux.dev
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.13-rc3 and has been tested on arm64, although it
>> also clears build tests on impacted platforms.
>>
>>   Documentation/arch/arm64/ptdump.rst       | 1 -
>>   arch/arm64/Kconfig                        | 2 +-
>>   arch/arm64/kvm/Kconfig                    | 3 +--
>>   arch/powerpc/Kconfig                      | 2 +-
>>   arch/powerpc/configs/mpc885_ads_defconfig | 1 -
>>   arch/riscv/Kconfig                        | 2 +-
>>   arch/s390/Kconfig                         | 2 +-
>>   arch/x86/Kconfig                          | 2 +-
>>   arch/x86/Kconfig.debug                    | 2 +-
>>   kernel/configs/debug.config               | 1 -
>>   mm/Kconfig.debug                          | 8 ++------
>>   11 files changed, 9 insertions(+), 17 deletions(-)
>>
> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index a0ce777f9706..c716f8df10de 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -203,7 +203,7 @@ config PPC
>>       select GENERIC_IRQ_SHOW
>>       select GENERIC_IRQ_SHOW_LEVEL
>>       select GENERIC_PCI_IOMAP        if PCI
>> -    select GENERIC_PTDUMP
>> +    select PTDUMP_CORE
> 
> Please keep alphabetical order.

Sure, will do that.

> 
>>       select GENERIC_SMP_IDLE_THREAD
>>       select GENERIC_TIME_VSYSCALL
>>       select GENERIC_VDSO_TIME_NS
> 
>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>> index 41a58536531d..b206e5a11f96 100644
>> --- a/mm/Kconfig.debug
>> +++ b/mm/Kconfig.debug
>> @@ -187,7 +187,7 @@ config DEBUG_WX
>>       bool "Warn on W+X mappings at boot"
>>       depends on ARCH_HAS_DEBUG_WX
>>       depends on MMU
>> -    select PTDUMP_CORE
>> +    depends on PTDUMP_CORE
> 
> This change is unclear to me. It works because all arch selecting ARCH_HAS_DEBUG_WX also select GENERIC_PTDUMP. For riscv it's even more tricking, Riscv only selects GENERIC_PTDUMP when MMU is set, so it works because here it also depends on MMU.

Right, all the archs selecting ARCH_HAS_DEBUG_WX also select PTDUMP_CORE.
DEBUG_WX dependency on PTDUMP_CORE will always be met, when the platform
selects ARCH_HAS_DEBUG_WX as expected.

git grep "select PTDUMP_CORE" arch/
arch/arm64/Kconfig:     select PTDUMP_CORE
arch/powerpc/Kconfig:   select PTDUMP_CORE
arch/riscv/Kconfig:     select PTDUMP_CORE if MMU
arch/s390/Kconfig:      select PTDUMP_CORE
arch/x86/Kconfig:       select PTDUMP_CORE

git grep ARCH_HAS_DEBUG_WX arch/
arch/arm64/Kconfig:     select ARCH_HAS_DEBUG_WX
arch/powerpc/Kconfig:   select ARCH_HAS_DEBUG_WX                if STRICT_KERNEL_RWX
arch/riscv/Kconfig:     select ARCH_HAS_DEBUG_WX
arch/s390/Kconfig:      select ARCH_HAS_DEBUG_WX
arch/x86/Kconfig:       select ARCH_HAS_DEBUG_WX

On riscv platform, does not PTDUMP_CORE implicitly imply existence of MMU ?
Could there be a page table dumper without a MMU.

> 
> But what happens if in the future an architecture selects ARCH_HAS_DEBUG_WX without selecting PTDUMP_CORE ?

Should DEBUG_WX just select PTDUMP_CORE as it exists now. A platform
will be able to get PTDUMP_CORE via DEBUG_WX if ARCH_HAS_DEBUG_WX is
subscribed into. Would that be better ?

> 
> 
>>       help
>>         Generate a warning if any W+X mappings are found at boot.
>>   @@ -212,9 +212,6 @@ config DEBUG_WX
>>           If in doubt, say "Y".
>>   -config GENERIC_PTDUMP
>> -    bool
>> -
>>   config PTDUMP_CORE
>>       bool
>>   @@ -222,8 +219,7 @@ config PTDUMP_DEBUGFS
>>       bool "Export kernel pagetable layout to userspace via debugfs"
>>       depends on DEBUG_KERNEL
>>       depends on DEBUG_FS
>> -    depends on GENERIC_PTDUMP
>> -    select PTDUMP_CORE
>> +    depends on PTDUMP_CORE
>>       help
>>         Say Y here if you want to show the kernel pagetable layout in a
>>         debugfs file. This information is only useful for kernel developers
> 
