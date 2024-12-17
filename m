Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986E15624D;
	Tue, 17 Dec 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421680; cv=none; b=VPLG/mlx7DIE8+jx2SBGZ53xl4V6jFqnzoNwSvQShANkm17ZaQZ++TvYKacQLpWEyZSFxmj9RwOnrxnULNvR71cmUHKxL1UayvFIEnoOKpFa+fHsEl2B4BWh9JzueWC2Y6PYOs/GIgbnTOcFqJJFMBH5TlAehSA4BLSqUcjsQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421680; c=relaxed/simple;
	bh=MgOQrO27meBf7NsG6OWTkY99J5lARFg7R+CbynX6vlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqUFnnTMZ/MBT21nWtVLJyqMbP4V+Mqn/qOK19tFKwEgn2BZEQCkyCX8vA8BvQHudq+Do6x9sjAaVL5XpyqFvICkc4EicK5RdWHRxslcidFrSpHvrRUXxMevEDxKql1igROyclFc0TA3kEooei3ziSMS+ibRMyiMPz0ZinMBtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YC86z6Lcmz9sPd;
	Tue, 17 Dec 2024 08:47:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fC7tw8E5ccA2; Tue, 17 Dec 2024 08:47:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YC86z5K7qz9rvV;
	Tue, 17 Dec 2024 08:47:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A3F418B768;
	Tue, 17 Dec 2024 08:47:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id iR2VLUnfgYsc; Tue, 17 Dec 2024 08:47:55 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 73D238B763;
	Tue, 17 Dec 2024 08:47:54 +0100 (CET)
Message-ID: <ddd4439e-6f6f-4513-a7dc-b7f01bec03dc@csgroup.eu>
Date: Tue, 17 Dec 2024 08:47:54 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Drop GENERIC_PTDUMP
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
References: <20241217034807.2541349-1-anshuman.khandual@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241217034807.2541349-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/12/2024 à 04:48, Anshuman Khandual a écrit :
> GENERIC_PTDUMP does not guard any code but instead just used for platform's
> subscription into core ptdump defined under PTDUMP_CORE, which is selected.
> Instead use PTDUMP_CORE for platform subscription and drop GENERIC_PTDUMP.
> 
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
> This patch applies on v6.13-rc3 and has been tested on arm64, although it
> also clears build tests on impacted platforms.
> 
>   Documentation/arch/arm64/ptdump.rst       | 1 -
>   arch/arm64/Kconfig                        | 2 +-
>   arch/arm64/kvm/Kconfig                    | 3 +--
>   arch/powerpc/Kconfig                      | 2 +-
>   arch/powerpc/configs/mpc885_ads_defconfig | 1 -
>   arch/riscv/Kconfig                        | 2 +-
>   arch/s390/Kconfig                         | 2 +-
>   arch/x86/Kconfig                          | 2 +-
>   arch/x86/Kconfig.debug                    | 2 +-
>   kernel/configs/debug.config               | 1 -
>   mm/Kconfig.debug                          | 8 ++------
>   11 files changed, 9 insertions(+), 17 deletions(-)
> 

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a0ce777f9706..c716f8df10de 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -203,7 +203,7 @@ config PPC
>   	select GENERIC_IRQ_SHOW
>   	select GENERIC_IRQ_SHOW_LEVEL
>   	select GENERIC_PCI_IOMAP		if PCI
> -	select GENERIC_PTDUMP
> +	select PTDUMP_CORE

Please keep alphabetical order.

>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_TIME_VSYSCALL
>   	select GENERIC_VDSO_TIME_NS

> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 41a58536531d..b206e5a11f96 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -187,7 +187,7 @@ config DEBUG_WX
>   	bool "Warn on W+X mappings at boot"
>   	depends on ARCH_HAS_DEBUG_WX
>   	depends on MMU
> -	select PTDUMP_CORE
> +	depends on PTDUMP_CORE

This change is unclear to me. It works because all arch selecting 
ARCH_HAS_DEBUG_WX also select GENERIC_PTDUMP. For riscv it's even more 
tricking, Riscv only selects GENERIC_PTDUMP when MMU is set, so it works 
because here it also depends on MMU.

But what happens if in the future an architecture selects 
ARCH_HAS_DEBUG_WX without selecting PTDUMP_CORE ?


>   	help
>   	  Generate a warning if any W+X mappings are found at boot.
>   
> @@ -212,9 +212,6 @@ config DEBUG_WX
>   
>   	  If in doubt, say "Y".
>   
> -config GENERIC_PTDUMP
> -	bool
> -
>   config PTDUMP_CORE
>   	bool
>   
> @@ -222,8 +219,7 @@ config PTDUMP_DEBUGFS
>   	bool "Export kernel pagetable layout to userspace via debugfs"
>   	depends on DEBUG_KERNEL
>   	depends on DEBUG_FS
> -	depends on GENERIC_PTDUMP
> -	select PTDUMP_CORE
> +	depends on PTDUMP_CORE
>   	help
>   	  Say Y here if you want to show the kernel pagetable layout in a
>   	  debugfs file. This information is only useful for kernel developers

