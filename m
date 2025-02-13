Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B902227EB4;
	Thu, 13 Feb 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445802; cv=none; b=GnscnHA6dE9ZsRW9/YmX+QUx/N9k7iCYH5trJWmM74a2AQ7wJge/SMQZ9VsD6VE2PxcvXeCOOjLMeD9JdCmJnP3/s85f0r1zaS9Z9TWbS0e84+M+4RjjnsPURyQkIaNRVTEVnpSsK+zAhLLIEWrrZ04wVer7hiQSRaes74RrU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445802; c=relaxed/simple;
	bh=ogiguVW4Z7vn4yhlEE4l8PDGLrOsug+PvKa6NwTYaco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHCTCin4FuLwuGh9ztsDuGDoXHnIe3p03WPvZd2lu2wWbtA00owpoCOOC/V32Pw8crSiThEAg4OFZ4Mn1EnDYSiSsjTv51/4XGxpoZbkl4rH+YzkFmyyP9jgG1LNYJaojGxe6bHAPbu6KZyCktbfsgKvTyjb9iGBIB8lVSZDn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F7226A4;
	Thu, 13 Feb 2025 03:23:40 -0800 (PST)
Received: from [10.1.32.44] (e122027.cambridge.arm.com [10.1.32.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE743F6A8;
	Thu, 13 Feb 2025 03:23:14 -0800 (PST)
Message-ID: <8e75c5ff-a97b-4a6f-9c8b-ac2598eafe60@arm.com>
Date: Thu, 13 Feb 2025 11:23:10 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: christophe.leroy@csgroup.eu, Catalin Marinas <catalin.marinas@arm.com>,
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
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250213040934.3245750-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 04:09, Anshuman Khandual wrote:
> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
> is confusing as they sound very similar and does not differentiate between
> platform's feature subscription and feature enablement for ptdump. Rename
> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
> readability.

I'm not going to bikeshed over the naming, but a few points below.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kvmarm@lists.linux.dev
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/arch/arm64/ptdump.rst       |  4 ++--
>  arch/arm64/Kconfig                        |  2 +-
>  arch/arm64/include/asm/ptdump.h           |  4 ++--
>  arch/arm64/kvm/Kconfig                    |  4 ++--
>  arch/arm64/mm/Makefile                    |  2 +-
>  arch/powerpc/Kconfig                      |  2 +-
>  arch/powerpc/configs/mpc885_ads_defconfig |  2 +-
>  arch/powerpc/mm/Makefile                  |  2 +-
>  arch/riscv/Kconfig                        |  2 +-
>  arch/riscv/mm/Makefile                    |  2 +-
>  arch/s390/Kconfig                         |  2 +-
>  arch/s390/mm/Makefile                     |  2 +-
>  arch/x86/Kconfig                          |  2 +-
>  arch/x86/Kconfig.debug                    |  2 +-
>  arch/x86/mm/Makefile                      |  2 +-
>  mm/Kconfig.debug                          | 12 ++++++------
>  mm/Makefile                               |  2 +-
>  17 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
> index 5dcfc5d7cddf..a2e527377da3 100644
> --- a/Documentation/arch/arm64/ptdump.rst
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -22,8 +22,8 @@ offlining of memory being accessed by the ptdump code.
>  In order to dump the kernel page tables, enable the following
>  configurations and mount debugfs::
>  
> - CONFIG_GENERIC_PTDUMP=y
> - CONFIG_PTDUMP_CORE=y
> + CONFIG_ARCH_HAS_PTDUMP=y
> + CONFIG_PTDUMP=y
>   CONFIG_PTDUMP_DEBUGFS=y

I think we should drop CONFIG_GENERIC_PTDUMP/CONFIG_ARCH_HAS_PTDUMP from
this list. It's not a user-selectable symbol so there's no need to be
documenting it here.

>  
>   mount -t debugfs nodev /sys/kernel/debug
[...]
> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
> index 77306be62e9e..db005618690b 100644
> --- a/arch/powerpc/configs/mpc885_ads_defconfig
> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
> @@ -78,4 +78,4 @@ CONFIG_DEBUG_VM_PGTABLE=y
>  CONFIG_DETECT_HUNG_TASK=y
>  CONFIG_BDI_SWITCH=y
>  CONFIG_PPC_EARLY_DEBUG=y
> -CONFIG_GENERIC_PTDUMP=y
> +CONFIG_PTDUMP=y

I'd suggest dropp this from the defconfig too, just like patch 1 dropped
it from debug.config.

Steve

