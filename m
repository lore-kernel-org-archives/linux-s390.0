Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Oct 2016 08:48:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 25/28] s390: pci: don't print uninitialized data for
 debugging
In-Reply-To: <20161017221650.1902729-6-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
        <20161017221650.1902729-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161018084855.1a100670@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Oct 2016 00:16:13 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> gcc correctly warns about an incorrect use of the 'pa' variable
> in case we pass an empty scatterlist to __s390_dma_map_sg:
> 
> arch/s390/pci/pci_dma.c: In function '__s390_dma_map_sg':
> arch/s390/pci/pci_dma.c:309:13: warning: 'pa' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This adds a bogus initialization to the function to sanitize
> the debug output.  I would have preferred a solution without
> the initialization, but I only got the report from the
> kbuild bot after turning on the warning again, and didn't
> manage to reproduce it myself.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/pci/pci_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 7350c8b..6b2f72f 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -423,7 +423,7 @@ static int __s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	dma_addr_t dma_addr_base, dma_addr;
>  	int flags = ZPCI_PTE_VALID;
>  	struct scatterlist *s;
> -	unsigned long pa;
> +	unsigned long pa = 0;
>  	int ret;
> 
>  	size = PAGE_ALIGN(size);

The compiler is right. pa is set in the for-loop. If "dma_addr < dma_addr_base + size"
is never true and __dma_purge_tlb() returns with an error, pa *is* uninitialized.
The fix seems sensible to me.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
