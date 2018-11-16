From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:13:57 +0000
Subject: Re: [PATCH 13/23] zfcp: ERP thread setup kdoc update
Message-Id: <e9b8623b-adcd-fe28-89b3-7aa43afd3f32@suse.de>
In-Reply-To: <20181108144458.29012-14-maier@linux.ibm.com>
References: <20181108144458.29012-14-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> zfcp_erp_thread_setup() update complements v2.6.32 commit 347c6a965dc1
> ("[SCSI] zfcp: Use kthread API for zfcp erp thread").
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_erp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index e7e6b63905e2..f6a2d66eef57 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -1489,7 +1489,7 @@ static int zfcp_erp_thread(void *data)
>    * zfcp_erp_thread_setup - Start ERP thread for adapter
>    * @adapter: Adapter to start the ERP thread for
>    *
> - * Returns 0 on success or error code from kernel_thread()
> + * Return: 0 on success, or error code from kthread_run().
>    */
>   int zfcp_erp_thread_setup(struct zfcp_adapter *adapter)
>   {
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
