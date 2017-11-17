Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 17 Nov 2017 08:47:11 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117014601.31606-1-pasha.tatashin@oracle.com>
Message-Id: <20171117074711.GA3308@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, arbab@linux.vnet.ibm.com, schwidefsky@de.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mhocko@suse.com, linux-mm@kvack.org, linux-s390@vger.kernel.org, mgorman@techsingularity.net
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 16, 2017 at 08:46:01PM -0500, Pavel Tatashin wrote:
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

For s390 the s390 bit:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
