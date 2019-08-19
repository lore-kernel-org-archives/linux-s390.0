Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr810109.outbound.protection.outlook.com ([40.107.81.109]:32719
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfHSU5q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Aug 2019 16:57:46 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 04/26] mips: remove ioremap_cachable
Date: Mon, 19 Aug 2019 20:57:30 +0000
Message-ID: <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-5-hch@lst.de>
In-Reply-To: <20190817073253.27819-5-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7A01E6E65132543B693A9F6442F8662@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Christoph,

On Sat, Aug 17, 2019 at 09:32:31AM +0200, Christoph Hellwig wrote:
> Just define ioremap_cache directly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/io.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 97a280640daf..c02db986ddf5 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -262,11 +262,11 @@ static inline void __iomem *ioremap_prot(phys_addr_=
t offset,
>  #define ioremap_uc ioremap_nocache
> =20
>  /*
> - * ioremap_cachable -	map bus memory into CPU space
> + * ioremap_cache -	map bus memory into CPU space
>   * @offset:	    bus address of the memory
>   * @size:	    size of the resource to map
>   *
> - * ioremap_nocache performs a platform specific sequence of operations t=
o
> + * ioremap_cache performs a platform specific sequence of operations to
>   * make bus memory CPU accessible via the readb/readw/readl/writeb/
>   * writew/writel functions and the other mmio helpers. The returned
>   * address is not guaranteed to be usable directly as a virtual
> @@ -276,9 +276,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t =
offset,
>   * the CPU.  Also enables full write-combining.	 Useful for some
>   * memory-like regions on I/O busses.
>   */
> -#define ioremap_cachable(offset, size)					\
> +#define ioremap_cache(offset, size)					\
>  	__ioremap_mode((offset), (size), _page_cachable_default)
> -#define ioremap_cache ioremap_cachable
> =20
>  /*
>   * ioremap_wc     -   map bus memory into CPU space
> --=20
> 2.20.1
>=20
