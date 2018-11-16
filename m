From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:08:19 +0000
Subject: Re: [PATCH 05/23] zfcp: move scsi_eh & non-ERP timeout defines owned by and local to zfcp_fsf.c
Message-Id: <239be824-bff3-eb05-7ff0-ccc09447b586@suse.de>
In-Reply-To: <20181108144458.29012-6-maier@linux.ibm.com>
References: <20181108144458.29012-6-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Also clarify namespace prefix for the timeout used for FSF requests
> on behalf of SCSI error recovery: It is zfcp_fsf_ not zfcp_scsi_.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 6 ------
>   drivers/s390/scsi/zfcp_fsf.c | 9 +++++++--
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index 1b6d64eb66b7..87a1fef5568e 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -41,17 +41,11 @@
>   #include "zfcp_fc.h"
>   #include "zfcp_qdio.h"
>   
> -/********************* SCSI SPECIFIC DEFINES *********************************/
> -#define ZFCP_SCSI_ER_TIMEOUT                    (10*HZ)
> -
>   /********************* FSF SPECIFIC DEFINES *********************************/
>   
>   /* ATTENTION: value must not be used by hardware */
>   #define FSF_QTCB_UNSOLICITED_STATUS		0x6305
>   
> -/* timeout value for "default timer" for fsf requests */
> -#define ZFCP_FSF_REQUEST_TIMEOUT (60*HZ)
> -
>   /*************** ADAPTER/PORT/UNIT AND FSF_REQ STATUS FLAGS ******************/
>   
>   /*
> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
> index 3c86e27f094d..095ab7fdcf4b 100644
> --- a/drivers/s390/scsi/zfcp_fsf.c
> +++ b/drivers/s390/scsi/zfcp_fsf.c
> @@ -19,6 +19,11 @@
>   #include "zfcp_qdio.h"
>   #include "zfcp_reqlist.h"
>   
> +/* timeout for FSF requests sent during scsi_eh: abort or FCP TMF */
> +#define ZFCP_FSF_SCSI_ER_TIMEOUT (10*HZ)
> +/* timeout for: exchange config/port data outside ERP, or open/close WKA port */
> +#define ZFCP_FSF_REQUEST_TIMEOUT (60*HZ)
> +
>   struct kmem_cache *zfcp_fsf_qtcb_cache;
>   
>   static void zfcp_fsf_request_timeout_handler(struct timer_list *t)
> @@ -912,7 +917,7 @@ struct zfcp_fsf_req *zfcp_fsf_abort_fcp_cmnd(struct scsi_cmnd *scmnd)
>   	req->qtcb->header.port_handle = zfcp_sdev->port->handle;
>   	req->qtcb->bottom.support.req_handle = (u64) old_req_id;
>   
> -	zfcp_fsf_start_timer(req, ZFCP_SCSI_ER_TIMEOUT);
> +	zfcp_fsf_start_timer(req, ZFCP_FSF_SCSI_ER_TIMEOUT);
>   	if (!zfcp_fsf_req_send(req))
>   		goto out;
>   
> @@ -2369,7 +2374,7 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_device *sdev,
>   	fcp_cmnd = &req->qtcb->bottom.io.fcp_cmnd.iu;
>   	zfcp_fc_fcp_tm(fcp_cmnd, sdev, tm_flags);
>   
> -	zfcp_fsf_start_timer(req, ZFCP_SCSI_ER_TIMEOUT);
> +	zfcp_fsf_start_timer(req, ZFCP_FSF_SCSI_ER_TIMEOUT);
>   	if (!zfcp_fsf_req_send(req))
>   		goto out;
>   
> 
Actually, I would love to see ZFCP_FSF_SCSI_ER_TIMEOUT be initialized by 
scsi_device->eh_timeout ...

But that's probably something for a bigger review affecting all drivers.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
