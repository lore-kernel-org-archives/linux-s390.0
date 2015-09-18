Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Sep 2015 13:19:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390/crash_dump: Use PFN_PHYS and PFN_DOWN macros
Message-ID: <20150918111928.GB3986@osiris>
References: <1442343278-10641-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442343278-10641-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 16, 2015 at 12:54:38AM +0600, Alexander Kuleshov wrote:
> The <linux/pfn.h> provides PFN_PHYS and PFN_DOWN macros for the
> getting page frame number and physical address of a page frame number.
> This patch replaces (pfn << PAGE_SHIFT) and (addr >> PAGE_SHIFT)
> expressions with the PFN_PHYS and PFN_DOWN macros.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  arch/s390/kernel/crash_dump.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 1e4fcfa..f8da32c 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -136,7 +136,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
> 
>  	if (!csize)
>  		return 0;
> -	src = (pfn << PAGE_SHIFT) + offset;
> +	src = (PFN_PHYS(pfn)) + offset;
>  	if (OLDMEM_BASE)
>  		return copy_oldmem_page_kdump(buf, csize, src, userbuf);
>  	else
> @@ -156,16 +156,17 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
>  	unsigned long size_old;
>  	int rc;
> 
> -	if (pfn < OLDMEM_SIZE >> PAGE_SHIFT) {
> -		size_old = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));
> +	if (pfn < PFN_DOWN(OLDMEM_SIZE)) {
> +		size_old = min(size,
> +			OLDMEM_SIZE - (unsigned long)(PFN_PHYS(pfn)));

Cleanup patches like this are supposed to increase readability. That's
certainly not the case here.
Therefore I'm not applying this one.

Thanks,
Heiko
