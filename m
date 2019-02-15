Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v3] hugetlb: allow to free gigantic pages regardless of
 the configuration
References: <20190214193100.3529-1-alex@ghiti.fr>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <363365a7-f1ac-5bde-ff7f-bdb137c20628@suse.cz>
Date: Fri, 15 Feb 2019 17:48:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190214193100.3529-1-alex@ghiti.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On 2/14/19 8:31 PM, Alexandre Ghiti wrote:
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patch simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This patch also renames:
> 
> - the triplet CMA or (MEMORY_ISOLATION && COMPACTION) into CONTIG_ALLOC,
> and gets rid of all use of it in architecture specific code (and then
> removes ARCH_HAS_GIGANTIC_PAGE config).
> - gigantic_page_supported to make it more accurate: this value being false
> does not mean that the system cannot use gigantic pages, it just means that
> runtime allocation of gigantic pages is not supported, one can still
> allocate boottime gigantic pages if the architecture supports it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

...

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -252,12 +252,17 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +

Stray newline? No need to resend, Andrew can fix up.
Ah, he wasn't in To:, adding.

>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool
>  
>  config ARCH_ENABLE_THP_MIGRATION
>  	bool
>  
> +config CONTIG_ALLOC
> +	def_bool y
> +	depends on (MEMORY_ISOLATION && COMPACTION) || CMA
> +
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
