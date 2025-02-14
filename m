Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094232080E1;
	Fri, 14 Feb 2025 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517980; cv=none; b=U3z55pjzh23xW+cbNVeQOSxi4R46SfWEf+AhPo2VoyiPEdRDvv5dBoawwqHVhvVHSM1CQt8aELM5sI7lVnnIEUzhOVZnRHOlA6NhTm63hOO65ORnIGhCMbeTWs5wrqRtzOein5JDzt1nkj48VKrYiInUWorSUQ31dUtcNrrOknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517980; c=relaxed/simple;
	bh=e/e3qRpo7LhLW8R2UTYX0GgNqFgT2Hororp8el2whMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6X6PWWRZ+kvjFWNNb6xkfwxQ4tDhaiZh4/bXq4uxY6SJAnkQAQA645May1QQ9HuNjTiduZLZPECBlYPFzwNXWSxccESanlf1I+fmmgQ9EMT5YlCIahO8ZmLMV8r2hQYB/euQPkDtZIrovkPmkmLSdkjl60MgAU/WU60e+sK8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A3D113E;
	Thu, 13 Feb 2025 23:26:38 -0800 (PST)
Received: from [10.163.37.128] (unknown [10.163.37.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E413F58B;
	Thu, 13 Feb 2025 23:26:08 -0800 (PST)
Message-ID: <03b042ec-1cb7-4419-8741-c65e74e49d51@arm.com>
Date: Fri, 14 Feb 2025 12:56:01 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-5-anshuman.khandual@arm.com>
 <8e75c5ff-a97b-4a6f-9c8b-ac2598eafe60@arm.com>
 <6e1201a1-60c1-40a3-951f-d603b6341a11@csgroup.eu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6e1201a1-60c1-40a3-951f-d603b6341a11@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/25 17:19, Christophe Leroy wrote:
> 
> 
> Le 13/02/2025 à 12:23, Steven Price a écrit :
>> On 13/02/2025 04:09, Anshuman Khandual wrote:
>>> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
>>> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
>>> is confusing as they sound very similar and does not differentiate between
>>> platform's feature subscription and feature enablement for ptdump. Rename
>>> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
>>> readability.
>>
>> [...]
>>> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
>>> index 77306be62e9e..db005618690b 100644
>>> --- a/arch/powerpc/configs/mpc885_ads_defconfig
>>> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
>>> @@ -78,4 +78,4 @@ CONFIG_DEBUG_VM_PGTABLE=y
>>>   CONFIG_DETECT_HUNG_TASK=y
>>>   CONFIG_BDI_SWITCH=y
>>>   CONFIG_PPC_EARLY_DEBUG=y
>>> -CONFIG_GENERIC_PTDUMP=y
>>> +CONFIG_PTDUMP=y
>>
>> I'd suggest dropp this from the defconfig too, just like patch 1 dropped
>> it from debug.config.
>>
> 
> Thanks for spotting that.
> 
> That one is wrong. Was introduced by commit d210ee3fdfe8 ("powerpc/configs: Update config files for removed/renamed symbols") which aimed at fixing commit e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP") but it did it wrong.
> 
> It is CONFIG_PTDUMP_DEBUGFS that is wanted.

Should this replacement be done in the series or would you like it
to be handled in powerpc later ?
