Return-Path: <linux-kernel-owner+w=401wt.eu-S1752788AbXLRIYk@vger.kernel.org>
From: Swen Schillig <swen@vnet.ibm.com>
Subject: Re: [PATCH] drivers/s390/: Spelling fixes
Date: Tue, 18 Dec 2007 09:24:28 +0100
References: <1197920439-5455-7-git-send-email-joe@perches.com>
In-Reply-To: <1197920439-5455-7-git-send-email-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712180924.29223.swen@vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Monday 17 December 2007 20:40, Joe Perches wrote:
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/block/dasd_3990_erp.c |    2 +-
>  drivers/s390/block/dasd_eckd.c     |    2 +-
>  drivers/s390/char/sclp_rw.c        |    2 +-
>  drivers/s390/char/tape_3590.c      |    2 +-
>  drivers/s390/cio/airq.c            |    2 +-
>  drivers/s390/scsi/zfcp_erp.c       |    2 +-
>  drivers/s390/scsi/zfcp_qdio.c      |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
> index 5b7385e..c02f960 100644
> --- a/drivers/s390/block/dasd_3990_erp.c
> +++ b/drivers/s390/block/dasd_3990_erp.c
> @@ -2620,7 +2620,7 @@ dasd_3990_erp_handle_match_erp(struct dasd_ccw_req *erp_head,
>   * DASD_3990_ERP_ACTION
>   *
>   * DESCRIPTION
> - *   controll routine for 3990 erp actions.
> + *   control routine for 3990 erp actions.
>   *   Has to be called with the queue lock (namely the s390_irq_lock) acquired.
>   *
>   * PARAMETER
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index 44adf84..6038d91 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1542,7 +1542,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
>  	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
>  	memset(prssdp, 0, sizeof (struct dasd_psf_prssd_data));
>  	prssdp->order = PSF_ORDER_PRSSD;
> -	prssdp->suborder = 0x01;	/* Perfomance Statistics */
> +	prssdp->suborder = 0x01;	/* Performance Statistics */
>  	prssdp->varies[1] = 0x01;	/* Perf Statistics for the Subsystem */
> 
>  	ccw = cqr->cpaddr;
> diff --git a/drivers/s390/char/sclp_rw.c b/drivers/s390/char/sclp_rw.c
> index d6b06ab..ad7195d 100644
> --- a/drivers/s390/char/sclp_rw.c
> +++ b/drivers/s390/char/sclp_rw.c
> @@ -76,7 +76,7 @@ sclp_make_buffer(void *page, unsigned short columns, unsigned short htab)
>  }
> 
>  /*
> - * Return a pointer to the orignal page that has been used to create
> + * Return a pointer to the original page that has been used to create
>   * the buffer.
>   */
>  void *
> diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
> index da25f8e..8246ef3 100644
> --- a/drivers/s390/char/tape_3590.c
> +++ b/drivers/s390/char/tape_3590.c
> @@ -1495,7 +1495,7 @@ tape_3590_unit_check(struct tape_device *device, struct tape_request *request,
>  			   device->cdev->dev.bus_id);
>  		return tape_3590_erp_basic(device, request, irb, -EPERM);
>  	case 0x8013:
> -		PRINT_WARN("(%s): Another host has priviliged access to the "
> +		PRINT_WARN("(%s): Another host has privileged access to the "
>  			   "tape device\n", device->cdev->dev.bus_id);
>  		PRINT_WARN("(%s): To solve the problem unload the current "
>  			   "cartridge!\n", device->cdev->dev.bus_id);
> diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
> index 5287631..5eada73 100644
> --- a/drivers/s390/cio/airq.c
> +++ b/drivers/s390/cio/airq.c
> @@ -23,7 +23,7 @@ static adapter_int_handler_t adapter_handler;
>   * register for adapter interrupts
>   *
>   * With HiperSockets the zSeries architecture provides for
> - *  means of adapter interrups, pseudo I/O interrupts that are
> + *  means of adapter interrupts, pseudo I/O interrupts that are
>   *  not tied to an I/O subchannel, but to an adapter. However,
>   *  it doesn't disclose the info how to enable/disable them, but
>   *  to recognize them only. Perhaps we should consider them
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index 07fa824..8925b3a 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -1285,7 +1285,7 @@ zfcp_erp_strategy_do_action(struct zfcp_erp_action *erp_action)
>  	 * note: no lock in subsequent strategy routines
>  	 * (this allows these routine to call schedule, e.g.
>  	 * kmalloc with such flags or qdio_initialize & friends)
> -	 * Note: in case of timeout, the seperate strategies will fail
> +	 * Note: in case of timeout, the separate strategies will fail
>  	 * anyhow. No need for a special action. Even worse, a nameserver
>  	 * failure would not wake up waiting ports without the call.
>  	 */
> diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
> index 51d92b1..22fdc17 100644
> --- a/drivers/s390/scsi/zfcp_qdio.c
> +++ b/drivers/s390/scsi/zfcp_qdio.c
> @@ -529,7 +529,7 @@ zfcp_qdio_sbals_wipe(struct zfcp_fsf_req *fsf_req)
> 
> 
>  /**
> - * zfcp_qdio_sbale_fill - set address and lenght in current SBALE
> + * zfcp_qdio_sbale_fill - set address and length in current SBALE
>   *	on request_queue
>   */
>  static void

ACK 
for the zfcp bits.

Cheers Swen
