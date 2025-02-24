Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98B3F9D2;
	Mon, 24 Feb 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404999; cv=none; b=FT9mphIPQAwmKPNmT/uDLaZzeIVcXKYxxap+tNouMF5GDmHXfnl1x66Vqv0EaygHiKfzao8ygN0H3uhAnJQSnYwyfQr5ZGy0nTY74rZJZWGH+abokkCpTb9zwjHfMw386nH8cltODZJiyqTQSuSxNa+I2uz1DUtjekyCXdkOdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404999; c=relaxed/simple;
	bh=6hZpCix+DxYq3VLHZtaNL3DILryOerY//lnNIpG6/Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWXJsWO3c2Vm34/+I0tAKZDVgCkm0xpC+DMtXgpwswH51+ivAL7fzBQjcd5hAXWsJP4Dfi98k7U4t+Obyg8Au5uSqg/76ZHZvGYgNmjqHT4nPZ2PFKJWM3pPbTIcCOP6c8iZYQaPda1kRVJjAEQ26ZUMWb+woOu1wsLJLSrvvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACCB1515;
	Mon, 24 Feb 2025 05:50:13 -0800 (PST)
Received: from [10.163.40.148] (unknown [10.163.40.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00D913F5A1;
	Mon, 24 Feb 2025 05:49:47 -0800 (PST)
Message-ID: <137a241a-324a-45a9-a60b-d65f27dc4fc2@arm.com>
Date: Mon, 24 Feb 2025 19:19:47 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/5] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc: steven.price@arm.com, Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>
References: <20250217042220.32920-1-anshuman.khandual@arm.com>
 <20250217042220.32920-6-anshuman.khandual@arm.com>
 <ba5b12e4-850c-445b-a1b1-0dc5f3905dda@csgroup.eu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ba5b12e4-850c-445b-a1b1-0dc5f3905dda@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/24/25 17:31, Christophe Leroy wrote:
> 
> 
> Le 17/02/2025 à 05:22, Anshuman Khandual a écrit :
>> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
>> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
>> is confusing as they sound very similar and does not differentiate between
>> platform's feature subscription and feature enablement for ptdump. Rename
>> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
>> readability.
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
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 7612c52e9b1e..5aef2aa4103c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -43,6 +43,7 @@ config RISCV
>>       select ARCH_HAS_PMEM_API
>>       select ARCH_HAS_PREEMPT_LAZY
>>       select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>> +    select ARCH_HAS_PTDUMP
> 
> Is it OK to drop the 'if MMU' from below ?

Sure, will add it back.

> 
>>       select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>>       select ARCH_HAS_PTE_SPECIAL
>>       select ARCH_HAS_SET_DIRECT_MAP if MMU
>> @@ -112,7 +113,6 @@ config RISCV
>>       select GENERIC_IRQ_SHOW_LEVEL
>>       select GENERIC_LIB_DEVMEM_IS_ALLOWED
>>       select GENERIC_PCI_IOMAP
>> -    select GENERIC_PTDUMP if MMU
>>       select GENERIC_SCHED_CLOCK
>>       select GENERIC_SMP_IDLE_THREAD
>>       select GENERIC_TIME_VSYSCALL if MMU && 64BIT
