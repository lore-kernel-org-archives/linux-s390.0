Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Fri, 07 Dec 2018 10:45:13 -0800 (PST)
Subject: Re: [PATCH RFC 4/7] riscv/vdso: don't clear PG_reserved
In-Reply-To: <20181205122851.5891-5-david@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3e6b4869-d5d7-42f4-a9d8-789a6772f52a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: david@redhat.com
Cc: linux-s390@vger.kernel.org, aou@eecs.berkeley.edu, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, tklauser@distanz.ch, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 05 Dec 2018 04:28:48 PST (-0800), david@redhat.com wrote:
> The VDSO is part of the kernel image and therefore the struct pages are
> marked as reserved during boot.
>
> As we install a special mapping, the actual struct pages will never be
> exposed to MM via the page tables. We can therefore leave the pages
> marked as reserved.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/riscv/kernel/vdso.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 582cb153eb24..0cd044122234 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -54,7 +54,6 @@ static int __init vdso_init(void)
>  		struct page *pg;
>
>  		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
> -		ClearPageReserved(pg);
>  		vdso_pagelist[i] = pg;
>  	}
>  	vdso_pagelist[i] = virt_to_page(vdso_data);

I'm going to assume this will go in through another tree along with the rest of 
the set assuming everyone else is happy with it.

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
