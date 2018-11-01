From: Benjamin Block <bblock@linux.ibm.com>
Date: Thu, 01 Nov 2018 16:58:33 +0000
Subject: Re: [PATCH] s390/scsi: remove unnecessary condition check
Message-Id: <20181101165833.GB10447@w530-pk1mzal>
In-Reply-To: <20181101141028.3060-1-cgxu519@gmx.com>
References: <20181101141028.3060-1-cgxu519@gmx.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 01, 2018 at 10:10:28PM +0800, Chengguang Xu wrote:
> mempool_destroy() can handle NULL pointer correctly, so there is
> no need to check NULL pointer before calling mempool_destroy().
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index 94f4d8fe85e0..e06c3f21e51d 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zfcp_adapter *adapter)
>  
>  static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>  {
> -	if (adapter->pool.erp_req)
> -		mempool_destroy(adapter->pool.erp_req);
> -	if (adapter->pool.scsi_req)
> -		mempool_destroy(adapter->pool.scsi_req);
> -	if (adapter->pool.scsi_abort)
> -		mempool_destroy(adapter->pool.scsi_abort);
> -	if (adapter->pool.qtcb_pool)
> -		mempool_destroy(adapter->pool.qtcb_pool);
> -	if (adapter->pool.status_read_req)
> -		mempool_destroy(adapter->pool.status_read_req);
> -	if (adapter->pool.sr_data)
> -		mempool_destroy(adapter->pool.sr_data);
> -	if (adapter->pool.gid_pn)
> -		mempool_destroy(adapter->pool.gid_pn);
> +	mempool_destroy(adapter->pool.erp_req);
> +	mempool_destroy(adapter->pool.scsi_req);
> +	mempool_destroy(adapter->pool.scsi_abort);
> +	mempool_destroy(adapter->pool.qtcb_pool);
> +	mempool_destroy(adapter->pool.status_read_req);
> +	mempool_destroy(adapter->pool.sr_data);
> +	mempool_destroy(adapter->pool.gid_pn);
>  }
>  
>  /**
> -- 
> 2.17.2
> 

Sry, but we have the literally same patch already on the queue by
someone else.

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Martina Koederitz       /      Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
