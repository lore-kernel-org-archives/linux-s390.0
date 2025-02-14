Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386BA15854F;
	Fri, 14 Feb 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517466; cv=none; b=AFUC/G3MpyUGMstsXpTwrjwjfOqBpgOop+oy1oYLKjQb/SiIgn63XNS2rrxhjSCRs1M3tYo9/hofEO4Kz4qIMan9cUPQZPoVwfEJXQ5i5EyvBStWoUoXn05mAqGpl6Cy5VF2KRv51IADixOvSDG6ewL7Yn/tDtTfgF/tPtO/h/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517466; c=relaxed/simple;
	bh=mAa3jdANMHof+F7y5TApWObEFxZoSX/MrlNxD26m8+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URkGZvA/x02JlKnm3UjKolkiUEt5Tg/Qeo8asyYVLFgRjqUpyBcoH7HiC6/oIrXck1CAGZEaa2SV5vO2eFrYO/3wlC6LOPbGvFb2b9L3x8fE7fBjTpGzMeJh1R0XeG4TDXeGvLP8PmYMX6CzY56RTCEAUB9p6CeKB4FzEq+dJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D429D113E;
	Thu, 13 Feb 2025 23:18:03 -0800 (PST)
Received: from [10.163.37.128] (unknown [10.163.37.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A8453F58B;
	Thu, 13 Feb 2025 23:17:34 -0800 (PST)
Message-ID: <e7f80acd-623b-4fda-9292-6f8344d0f185@arm.com>
Date: Fri, 14 Feb 2025 12:47:31 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
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
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-5-anshuman.khandual@arm.com>
 <4fa83d76-117f-41bc-9137-676fb0c204dd@csgroup.eu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4fa83d76-117f-41bc-9137-676fb0c204dd@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 13:08, Christophe Leroy wrote:
> 
> 
> Le 13/02/2025 à 05:09, Anshuman Khandual a écrit :
>> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
>> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
>> is confusing as they sound very similar and does not differentiate between
>> platform's feature subscription and feature enablement for ptdump. Rename
>> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
>> readability.
> 
> For me GENERIC_PTDUMP is more explicit and similar to GENERIC_IOMAP or GENERIC_IOREMAP or GENERIC_GETTIMEOFDAY: The arch provides the necessary helpers to use the generic implementation.

I do realize that GENERIC_ is another method for achieving shared
feature across multiple platforms via providing necessary helpers.
But I guess there might be a difference - it might not have other
similar but separate dependent configs ?

> 
> For me ARCH_HAS_PTDUMP just mean't that an architecture implements PTDUMP, it doesn't mean it does it by using the generic infrastructure.

ARCH_HAS_XXX indicates that an architecture subscribes to a generic
feature XXX, by implementing all necessary helpers. But the feature
in itself is a generic and a shared one.

If the platform were to implement a feature on its own without any
generic component, it could do that via a separate platform specific
config without requiring ARCH_HAS_XXX based subscription indication.

> 
> For instance, arm32 implements PTDUMP but without using the generic one so I would say that arm32 has PTDUMP and expect it to select ARCH_HAS_PTDUMP

Actually it does not need to select ARCH_HAS_PTDUMP, as it does not
subscribe into generic PTDUMP. Let's see PTDUMP configs on arm (32)

ARM_PTDUMP_CORE
ARM_PTDUMP_DEBUGFS	--> select ARM_PTDUMP_CORE
ARM_DEBUG_WX 		--> select ARM_PTDUMP_CORE

The platform has a self contained PTDUMP implementation which does
not depend on generic PTDUMP at all. Hence all these ptdump configs
are marked as ARM_ etc as they are platform specific.
