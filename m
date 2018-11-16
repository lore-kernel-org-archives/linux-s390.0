From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:03:49 +0000
Subject: Re: [PATCH 04/23] zfcp: drop unnecessary forward prototype for struct zfcp_reqlist
Message-Id: <6d3821d3-82c9-d08a-483d-fa0ee80e671e@suse.de>
In-Reply-To: <20181108144458.29012-5-maier@linux.ibm.com>
References: <20181108144458.29012-5-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> While struct zfcp_adapter contains a pointer to zfcp_reqlist,
> the pointer field does not need to know the structure or even a prototype.
> 
> The prototype was introduced with v2.6.34 commit b6bd2fb92a7b ("[SCSI]
> zfcp: Move FSF request tracking code to new file").
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index 3396a47721a7..1b6d64eb66b7 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -4,7 +4,7 @@
>    *
>    * Global definitions for the zfcp device driver.
>    *
> - * Copyright IBM Corp. 2002, 2010
> + * Copyright IBM Corp. 2002, 2017
>    */
>   
>   #ifndef ZFCP_DEF_H
> @@ -41,8 +41,6 @@
>   #include "zfcp_fc.h"
>   #include "zfcp_qdio.h"
>   
> -struct zfcp_reqlist;
> -
>   /********************* SCSI SPECIFIC DEFINES *********************************/
>   #define ZFCP_SCSI_ER_TIMEOUT                    (10*HZ)
>   
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
