Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Date: Fri, 18 Jan 2019 18:02:03 +0000
Message-ID: <20190118180201.uva5nhf2g23uamkn@pburton-laptop>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
Content-Language: en-US
Content-ID: <8AB5FF9934BD5A4E822E85B3C315428B@namprd22.prod.outlook.com>
MIME-Version: 1.0
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
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, Petr Mladek <pmladek@suse.com>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Mike,

On Wed, Jan 16, 2019 at 03:44:19PM +0200, Mike Rapoport wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
> 
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
> 
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> + 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>%
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index e8eb60e..db1deb2 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -245,6 +245,9 @@ void __init plat_swiotlb_setup(void)
>  	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
>  
>  	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
> +	if (!octeon_swiotlb)
> +		panic("%s: Failed to allocate %lu bytes align=%lx\n",
> +		      __func__, swiotlbsize, PAGE_SIZE);
>  
>  	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
>  		panic("Cannot allocate SWIOTLB buffer");

That one should be %zu rather than %lu. The rest looks good, so with
that one tweak:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
