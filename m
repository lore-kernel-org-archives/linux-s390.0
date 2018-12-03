Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] [SCSI] zfcp: NULL check before some freeing functions is
 not needed.
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930051-347492467-5-diffsplit-thomas@m3y3r.de>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 3 Dec 2018 11:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <1543760930051-347492467-5-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <28bf96ec-4dff-29bd-f628-1a30e189aea8@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Meyer <thomas@m3y3r.de>, bblock@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, this was already submitted for v4.12 with
https://www.spinics.net/lists/linux-scsi/msg125190.html
based on
https://www.spinics.net/lists/linux-s390/msg21307.html

Also, previously seen in
https://www.spinics.net/lists/linux-s390/msg22035.html

On 12/02/2018 09:52 PM, Thomas Meyer wrote:
> NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers
>   
>   static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>   {
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
>   }
>   
>   /**
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
