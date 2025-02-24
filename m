Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0626FD8C;
	Mon, 24 Feb 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396007; cv=none; b=PnRYdcFGTNKtl43bs4nYY3lZZ4nRsehi7FHnQuCWaI5Gr39rG/GTR6c+2JgeJqW1vO9CVTJD/J+YysS5Z7XC+a9LS319t5zE4OkQN8wVvp4nuzmGsg9QfBf7TOPGhm0IlMf3cIlyrErECuji6qwDp5wO86f4GwRZJFCNgwwVF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396007; c=relaxed/simple;
	bh=fTwmSX9CANDd4nzWERWWEeN0ITcff80LRgr5IG5Dzlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9Q4tURuXLZt7yJJmix9Z1Dc96wpX+bZw+GWBePmxW7WPttlaoXBARy87hH1c6CbfFTt+CuFH4QP/eC5X1FhGoK+pJw+Zum7jrmSreeonaHa2YNVokP8oKZBu6BeR2EW6CrmzsSEsQ/6WvRHIh+QLxLWng89JS8OiBYensY2GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1dPS72wNz9sSn;
	Mon, 24 Feb 2025 12:12:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SIiDK1YPjhuf; Mon, 24 Feb 2025 12:12:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1dPS5txxz9sSm;
	Mon, 24 Feb 2025 12:12:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B3BD38B765;
	Mon, 24 Feb 2025 12:12:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id tnzzpVojmwHn; Mon, 24 Feb 2025 12:12:44 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 63CE98B763;
	Mon, 24 Feb 2025 12:12:44 +0100 (CET)
Message-ID: <43937a0a-679e-47e8-a4c5-d20759ef53c8@csgroup.eu>
Date: Mon, 24 Feb 2025 12:12:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
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
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-5-anshuman.khandual@arm.com>
 <4fa83d76-117f-41bc-9137-676fb0c204dd@csgroup.eu>
 <e7f80acd-623b-4fda-9292-6f8344d0f185@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <e7f80acd-623b-4fda-9292-6f8344d0f185@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/02/2025 à 08:17, Anshuman Khandual a écrit :
> On 2/13/25 13:08, Christophe Leroy wrote:
>>
>>
>> Le 13/02/2025 à 05:09, Anshuman Khandual a écrit :
>>> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
>>> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
>>> is confusing as they sound very similar and does not differentiate between
>>> platform's feature subscription and feature enablement for ptdump. Rename
>>> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
>>> readability.
>>
>> For me GENERIC_PTDUMP is more explicit and similar to GENERIC_IOMAP or GENERIC_IOREMAP or GENERIC_GETTIMEOFDAY: The arch provides the necessary helpers to use the generic implementation.
> 
> I do realize that GENERIC_ is another method for achieving shared
> feature across multiple platforms via providing necessary helpers.
> But I guess there might be a difference - it might not have other
> similar but separate dependent configs ?
> 
>>
>> For me ARCH_HAS_PTDUMP just mean't that an architecture implements PTDUMP, it doesn't mean it does it by using the generic infrastructure.
> 
> ARCH_HAS_XXX indicates that an architecture subscribes to a generic
> feature XXX, by implementing all necessary helpers. But the feature
> in itself is a generic and a shared one.

I'm not sure about your interpretation.

For instance CONFIG_ARCH_HAS_ILOG2_U32 means that a plateform provides 
its own implementation. When this is _NOT_ defined, then the generic 
implementation is used instead.

> 
> If the platform were to implement a feature on its own without any
> generic component, it could do that via a separate platform specific
> config without requiring ARCH_HAS_XXX based subscription indication.

Not sure. Usually when a plateform needs something generic it subscribes 
to something like CONFIG_ARCH_WANT_GENERAL_HUGETLB


> 
>>
>> For instance, arm32 implements PTDUMP but without using the generic one so I would say that arm32 has PTDUMP and expect it to select ARCH_HAS_PTDUMP
> 
> Actually it does not need to select ARCH_HAS_PTDUMP, as it does not
> subscribe into generic PTDUMP. Let's see PTDUMP configs on arm (32)
> 
> ARM_PTDUMP_CORE
> ARM_PTDUMP_DEBUGFS	--> select ARM_PTDUMP_CORE
> ARM_DEBUG_WX 		--> select ARM_PTDUMP_CORE
> 
> The platform has a self contained PTDUMP implementation which does
> not depend on generic PTDUMP at all. Hence all these ptdump configs
> are marked as ARM_ etc as they are platform specific.

That's the reason why I believe the wording CONFIG_ARCH_HAS_SOMETHING is 
not appropriate.

Christophe
