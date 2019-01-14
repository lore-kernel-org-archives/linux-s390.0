Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-8-david@redhat.com>
In-Reply-To: <20190114125903.24845-8-david@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 14 Jan 2019 21:22:49 +0530
Message-ID: <CACi5LpPphoJzfKXPN5kSV42aF27=2ZjqXSVLQjEtMdSN8+6bsA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: kdump: No need to mark crashkernel pages
 manually PG_reserved
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
To: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, CHANDAN VN <chandan.vn@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Laura Abbott <labbott@redhat.com>, Kristina Martsenko <kristina.martsenko@arm.com>, linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Logan Gunthorpe <logang@deltatee.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, James Morse <james.morse@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Greg Hackmann <ghackmann@android.com>
List-ID: <linux-s390.vger.kernel.org>

Hi David,

On Mon, Jan 14, 2019 at 6:30 PM David Hildenbrand <david@redhat.com> wrote:
>
> The crashkernel is reserved via memblock_reserve(). memblock_free_all()
> will call free_low_memory_core_early(), which will go over all reserved
> memblocks, marking the pages as PG_reserved.
>
> So manually marking pages as PG_reserved is not necessary, they are
> already in the desired state (otherwise they would have been handed over
> to the buddy as free pages and bad things would happen).
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: CHANDAN VN <chandan.vn@samsung.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/kernel/machine_kexec.c |  2 +-
>  arch/arm64/mm/init.c              | 27 ---------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6f0587b5e941..66b5d697d943 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -321,7 +321,7 @@ void crash_post_resume(void)
>   * but does not hold any data of loaded kernel image.
>   *
>   * Note that all the pages in crash dump kernel memory have been initially
> - * marked as Reserved in kexec_reserve_crashkres_pages().
> + * marked as Reserved as memory was allocated via memblock_reserve().
>   *
>   * In hibernation, the pages which are Reserved and yet "nosave" are excluded
>   * from the hibernation iamge. crash_is_nosave() does thich check for crash
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..c38976b70069 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -118,35 +118,10 @@ static void __init reserve_crashkernel(void)
>         crashk_res.start = crash_base;
>         crashk_res.end = crash_base + crash_size - 1;
>  }
> -
> -static void __init kexec_reserve_crashkres_pages(void)
> -{
> -#ifdef CONFIG_HIBERNATION
> -       phys_addr_t addr;
> -       struct page *page;
> -
> -       if (!crashk_res.end)
> -               return;
> -
> -       /*
> -        * To reduce the size of hibernation image, all the pages are
> -        * marked as Reserved initially.
> -        */
> -       for (addr = crashk_res.start; addr < (crashk_res.end + 1);
> -                       addr += PAGE_SIZE) {
> -               page = phys_to_page(addr);
> -               SetPageReserved(page);
> -       }
> -#endif
> -}
>  #else
>  static void __init reserve_crashkernel(void)
>  {
>  }
> -
> -static void __init kexec_reserve_crashkres_pages(void)
> -{
> -}
>  #endif /* CONFIG_KEXEC_CORE */
>
>  #ifdef CONFIG_CRASH_DUMP
> @@ -586,8 +561,6 @@ void __init mem_init(void)
>         /* this will put all unused low memory onto the freelists */
>         memblock_free_all();
>
> -       kexec_reserve_crashkres_pages();
> -
>         mem_init_print_info(NULL);
>
>         /*
> --
> 2.17.2

LGTM, so:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
