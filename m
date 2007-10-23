Return-Path: <linux-kernel-owner+w=401wt.eu-S1754135AbXJWHPm@vger.kernel.org>
Date: Tue, 23 Oct 2007 09:14:07 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 04/10] [SG] Update drivers to use sg helpers
Message-ID: <20071023071407.GF25962@kernel.dk>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com> <1193076664-13652-5-git-send-email-jens.axboe@oracle.com> <20071023062857.GB24546@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023062857.GB24546@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Christoph Schmitt <schmichr@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 23 2007, Heiko Carstens wrote:
> On Mon, Oct 22, 2007 at 08:10:58PM +0200, Jens Axboe wrote:
> > Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> > ---
> 
> You forgot s390's zfcp driver. But unfortunately the trivial fix below
> doesn't work. No more I/O possible. Swen and/or Christof could you
> provide a correct fix for this please? Thanks!
> 
> ---
>  drivers/s390/scsi/zfcp_def.h |    4 ++--
>  drivers/s390/scsi/zfcp_erp.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/s390/scsi/zfcp_def.h
> ===================================================================
> --- linux-2.6.orig/drivers/s390/scsi/zfcp_def.h
> +++ linux-2.6/drivers/s390/scsi/zfcp_def.h
> @@ -63,7 +63,7 @@
>  static inline void *
>  zfcp_sg_to_address(struct scatterlist *list)
>  {
> -	return (void *) (page_address(list->page) + list->offset);
> +	return (void *) (page_address(sg_page(list) + list->offset));
>  }

return sg_virt(list); would be better.

I'll fix up the driver, no worries.

-- 
Jens Axboe
