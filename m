Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 8 Jan 2018 21:13:39 -0600
From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 06/67] hexagon: remove unused flush_write_buffers
 definition
Message-ID: <20180109031339.GA4196@codeaurora.org>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229081911.2802-7-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180109031339.hM5AMttVanuUbbSiBXCnbcJqs_XmkffAwiX-eGyTZQQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 29, 2017 at 09:18:10AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/io.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 66f5e9a61efc..9e8621d94ee9 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -330,8 +330,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
>  	}
>  }
>  
> -#define flush_write_buffers() do { } while (0)
> -
>  #endif /* __KERNEL__ */
>  
>  #endif
> -- 
> 2.14.2
> 

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
