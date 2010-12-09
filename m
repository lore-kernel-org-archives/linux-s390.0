From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Thu, 09 Dec 2010 15:29:56 +0000
Subject: Re: [PATCH] [SCSI] zfcp: Remove redundant unlikely()
Message-Id: <20101209152956.GA23465@schmichrtp.ibm.com>
In-Reply-To: <1291906663-1288-1-git-send-email-tklauser@distanz.ch>
References: <1291906663-1288-1-git-send-email-tklauser@distanz.ch>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 09, 2010 at 03:57:43PM +0100, Tobias Klauser wrote:
> IS_ERR() already implies unlikely(), so it can be omitted here.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/s390/scsi/zfcp_fsf.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
> index 2eb7dd5..722cdf5 100644
> --- a/drivers/s390/scsi/zfcp_fsf.c
> +++ b/drivers/s390/scsi/zfcp_fsf.c
> @@ -1553,7 +1553,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
>  				  SBAL_FLAGS0_TYPE_READ,
>  				  qdio->adapter->pool.erp_req);
> 
> -	if (unlikely(IS_ERR(req))) {
> +	if (IS_ERR(req)) {
>  		retval = PTR_ERR(req);
>  		goto out;
>  	}
> @@ -1606,7 +1606,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
>  				  SBAL_FLAGS0_TYPE_READ,
>  				  qdio->adapter->pool.erp_req);
> 
> -	if (unlikely(IS_ERR(req))) {
> +	if (IS_ERR(req)) {
>  		retval = PTR_ERR(req);
>  		goto out;
>  	}
> -- 

Thanks for catching this. I will add the patch to our patch queue.

Christof
