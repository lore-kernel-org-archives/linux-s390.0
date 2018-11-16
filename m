From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:22:57 +0000
Subject: Re: [PATCH 23/23] zfcp: drop old default switch case which might paper over missing case
Message-Id: <98a07c7e-b557-08e7-9bd9-7e0dbb5ec595@suse.de>
In-Reply-To: <20181108144458.29012-24-maier@linux.ibm.com>
References: <20181108144458.29012-24-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> This was introduced with v2.6.27 commit 287ac01acf22 ("[SCSI] zfcp: Cleanup
> code in zfcp_erp.c") but would now suppress helpful -Wswitch compiler
> warnings when building with W=1 such as the following forced example:
> 
> drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_setup_act':
> drivers/s390/scsi/zfcp_erp.c:220:2: warning: enumeration value 'ZFCP_ERP_ACTION_REOPEN_PORT' not handled in switch [-Wswitch]
>    switch (need) {
>    ^~~~~~
> 
> But then again, only with W=1 we would notice unhandled enum cases.
> Without the default cases and a missed unhandled enum case, the code
> might perform unforeseen things we might not want...
> 
> As of today, we never run through the removed default case,
> so removing it is no functional change.
> In the future, we never should run through a default case but
> introduce the necessary specific case(s) to handle new functionality.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_erp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index 9345fed3bb37..744a64680d5b 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -257,9 +257,6 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(enum zfcp_erp_act_type need,
>   		      ZFCP_STATUS_COMMON_RUNNING))
>   			act_status |= ZFCP_STATUS_ERP_CLOSE_ONLY;
>   		break;
> -
> -	default:
> -		return NULL;
>   	}
>   
>   	WARN_ON_ONCE(erp_action->adapter != adapter);
> 
Same here.
If you don't expect the code to run into this case, please do add a 
WARN_ON() or something so that it can be tracked down.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
