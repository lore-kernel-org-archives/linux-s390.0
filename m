Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8372163BE;
	Wed,  5 Feb 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749672; cv=none; b=Bir6Ldf5++nH06DlMGOr4PrbXxs2DTVQi+6cY8hBqap/eyWMBhvqTEsrzdeOxmbvBz76/AhS3ohcY+GP0NUz3O/WAyPz4Pv/KytXAHBN6sUsfrYQzrlW3A/ZvF2/gSz2Y6/PKNMwKV8lTW2ODipyjbjimMguwjXLNxSWr5AM6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749672; c=relaxed/simple;
	bh=CiuHqqToU+/eNRrP10Z4tcsqFnwK6YpS57IbttfhWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZecATdHwbQxHtqAJxm2nQjNnNjKPAu3ul/ENK/A1Es9pc1YCz20K18HtrWa7/6BXmvtAWPd7iqc1KQu7SpIRGqvpFxd2a3u5cVvT3AfZrlUJpy3mP1MLsoMiV2wGnF+klu17i7D2HRjb+6vR/1Wm3lPNyYs5g/gAfMCh2yuIIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8085111FB;
	Wed,  5 Feb 2025 02:01:32 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 648383F5A1;
	Wed,  5 Feb 2025 02:01:04 -0800 (PST)
Date: Wed, 5 Feb 2025 10:01:01 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, steven.price@arm.com, christophe.leroy@csgroup.eu,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH V2] mm/ptdump: Drop GENERIC_PTDUMP
Message-ID: <Z6M23dR5wvZKW4JE@J2N7QTR9R3>
References: <20250205050039.1506377-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205050039.1506377-1-anshuman.khandual@arm.com>

On Wed, Feb 05, 2025 at 10:30:39AM +0530, Anshuman Khandual wrote:
> GENERIC_PTDUMP does not guard any code but instead just used for platform's
> subscription into core ptdump defined under PTDUMP_CORE, which is selected.

Selected by what?

> Instead use PTDUMP_CORE for platform subscription and drop GENERIC_PTDUMP.
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
> This patch applies on v6.14-rc1
> 
> Changes in V2:
> 
> - Keep arch/powerpc/Kconfig alphabetically sorted per Christophe
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20241217034807.2541349-1-anshuman.khandual@arm.com/
> 
>  Documentation/arch/arm64/ptdump.rst       | 1 -
>  arch/arm64/Kconfig                        | 2 +-
>  arch/arm64/kvm/Kconfig                    | 3 +--
>  arch/powerpc/Kconfig                      | 2 +-
>  arch/powerpc/configs/mpc885_ads_defconfig | 1 -
>  arch/riscv/Kconfig                        | 2 +-
>  arch/s390/Kconfig                         | 2 +-
>  arch/x86/Kconfig                          | 2 +-
>  arch/x86/Kconfig.debug                    | 2 +-
>  kernel/configs/debug.config               | 1 -
>  mm/Kconfig.debug                          | 8 ++------
>  11 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
> index 5dcfc5d7cddf..61ca040a885b 100644
> --- a/Documentation/arch/arm64/ptdump.rst
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -22,7 +22,6 @@ offlining of memory being accessed by the ptdump code.
>  In order to dump the kernel page tables, enable the following
>  configurations and mount debugfs::
>  
> - CONFIG_GENERIC_PTDUMP=y
>   CONFIG_PTDUMP_CORE=y
>   CONFIG_PTDUMP_DEBUGFS=y
>  
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca8..1f516bed81dd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -157,7 +157,7 @@ config ARM64
>  	select GENERIC_IRQ_SHOW_LEVEL
>  	select GENERIC_LIB_DEVMEM_IS_ALLOWED
>  	select GENERIC_PCI_IOMAP
> -	select GENERIC_PTDUMP
> +	select PTDUMP_CORE
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL

This change means that the ptdump core code will be built regardless of
whether any users are selected:

  [mark@lakrids:~/src/linux]% git grep CONFIG_PTDUMP_CORE
  Documentation/arch/arm64/ptdump.rst: CONFIG_PTDUMP_CORE=y
  arch/arm64/include/asm/ptdump.h:#ifdef CONFIG_PTDUMP_CORE
  arch/arm64/include/asm/ptdump.h:#endif /* CONFIG_PTDUMP_CORE */
  arch/arm64/mm/Makefile:obj-$(CONFIG_PTDUMP_CORE)        += ptdump.o
  arch/powerpc/mm/Makefile:obj-$(CONFIG_PTDUMP_CORE)      += ptdump/
  arch/riscv/mm/Makefile:obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
  arch/s390/mm/Makefile:obj-$(CONFIG_PTDUMP_CORE) += dump_pagetables.o
  arch/x86/mm/Makefile:obj-$(CONFIG_PTDUMP_CORE)  += dump_pagetables.o
  mm/Makefile:obj-$(CONFIG_PTDUMP_CORE) += ptdump.o

GENERIC_PTDUMP means "this architecture uses generic ptdump code for
ptdump", i.e. the architecture implements all the necessary bits for
that to work *IF* it is built.

PTDUMP_CORE means "actually build the core ptdump code".

If everyone uses the generic ptdump code now, maybe it's worth renaming
GENERIC_PTDUMP to ARCH_HAS_PTDUMP or something like that, but I don't
think this change makes sense as-is.

[...]

> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 20552f163930..8aafd050b754 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -73,7 +73,6 @@ CONFIG_DEBUG_VM=y
>  CONFIG_DEBUG_VM_PGFLAGS=y
>  CONFIG_DEBUG_VM_RB=y
>  CONFIG_DEBUG_VM_VMACACHE=y
> -CONFIG_GENERIC_PTDUMP=y
>  CONFIG_KASAN=y
>  CONFIG_KASAN_GENERIC=y
>  CONFIG_KASAN_INLINE=y

I think this is wrong today, and removing it is the right thing to do.

Architectures with support will select this themselves, and on
architectures without support this either does nothing or causes a build
failure.

Mark.
