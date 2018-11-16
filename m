From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:20:56 +0000
Subject: Re: [PATCH 21/23] zfcp: silence -Wimplicit-fallthrough in zfcp_erp_lun_strategy()
Message-Id: <64191921-162b-9bc9-5490-5765495ff992@suse.de>
In-Reply-To: <20181108144458.29012-22-maier@linux.ibm.com>
References: <20181108144458.29012-22-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> For some reason the already existing substring "fall through" in the
> comment is not sufficient for GCC to silence -Wimplicit-fallthrough.
> 
>    CC [M]  drivers/s390/scsi/zfcp_erp.o
> drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_lun_strategy':
> drivers/s390/scsi/zfcp_erp.c:1065:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_OPEN)
>        ^
> drivers/s390/scsi/zfcp_erp.c:1068:2: note: here
>    case ZFCP_ERP_STEP_LUN_CLOSING:
>    ^~~~
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_erp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index 8e5f01f5be81..b2845c5b8106 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -1070,7 +1070,8 @@ static enum zfcp_erp_act_result zfcp_erp_lun_strategy(
>   		zfcp_erp_lun_strategy_clearstati(sdev);
>   		if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_OPEN)
>   			return zfcp_erp_lun_strategy_close(erp_action);
> -		/* already closed, fall through */
> +		/* already closed */
> +		/* fall through */
>   	case ZFCP_ERP_STEP_LUN_CLOSING:
>   		if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_OPEN)
>   			return ZFCP_ERP_FAILED;
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
