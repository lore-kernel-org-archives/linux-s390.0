Return-Path: <owner-linux-mm@kvack.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
In-Reply-To: <20171117014601.31606-1-pasha.tatashin@oracle.com>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
Date: Thu, 23 Nov 2017 23:52:45 +1100
Message-ID: <87wp2h17j6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, arbab@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mhocko@suse.com, linux-mm@kvack.org, linux-s390@vger.kernel.org, mgorman@techsingularity.net
List-ID: <linux-s390.vger.kernel.org>

Pavel Tatashin <pasha.tatashin@oracle.com> writes:

> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> as all the page initialization code is in common code.
>
> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> does not really use hotplug memory functionality. So, we can remove this
> requirement as well.
>
> This patch allows to use deferred struct page initialization on all
> platforms with memblock allocator.
>
> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> PPC with CONFIG_MEMORY_HOTPLUG disabled.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/powerpc/Kconfig | 1 -
>  arch/s390/Kconfig    | 1 -
>  arch/x86/Kconfig     | 1 -
>  mm/Kconfig           | 7 +------
>  4 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index cb782ac1c35d..1540348691c9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -148,7 +148,6 @@ config PPC
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> -	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
