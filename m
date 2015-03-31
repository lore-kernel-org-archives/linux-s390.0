Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Mar 2015 09:13:31 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 07/25] s390: Use bool function return values of
 true/false not 1/0
Message-ID: <20150331071331.GA4479@osiris>
References: <cover.1427759009.git.joe@perches.com>
 <3b4dd85cf7c16e6c79f98ecb041cd7799ea28c66.1427759009.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4dd85cf7c16e6c79f98ecb041cd7799ea28c66.1427759009.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 04:46:05PM -0700, Joe Perches wrote:
> Use the normal return values for bool functions
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/include/asm/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
> index 709955d..9d39596 100644
> --- a/arch/s390/include/asm/dma-mapping.h
> +++ b/arch/s390/include/asm/dma-mapping.h
> @@ -42,7 +42,7 @@ static inline int dma_supported(struct device *dev, u64 mask)
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  {
>  	if (!dev->dma_mask)
> -		return 0;
> +		return false;
>  	return addr + size - 1 <= *dev->dma_mask;
>  }

Applied, thanks!
