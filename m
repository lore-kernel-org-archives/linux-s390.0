From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:09:47 +0000
Subject: Re: [PATCH 09/23] zfcp: drop unnecessary forward prototype for struct zfcp_fsf_req
Message-Id: <bf5e419c-2931-bb01-f902-75207c45c858@suse.de>
In-Reply-To: <20181108144458.29012-10-maier@linux.ibm.com>
References: <20181108144458.29012-10-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index 31b3e2bb3b42..572debf2f528 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -89,8 +89,6 @@
>   
>   /************************* STRUCTURE DEFINITIONS *****************************/
>   
> -struct zfcp_fsf_req;
> -
>   struct zfcp_erp_action {
>   	struct list_head list;
>   	int action;	              /* requested action code */
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
