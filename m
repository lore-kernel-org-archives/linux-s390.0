Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgKDB0J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Nov 2020 20:26:09 -0500
Message-ID: <1c831e09cd2c42d69f5702733e7b083581517e79.camel@kernel.org>
Subject: Re: [PATCH net-next v2 11/15] net/smc: Add SMC-D Linkgroup
 diagnostic support
From: Saeed Mahameed <saeed@kernel.org>
Date: Tue, 03 Nov 2020 17:26:07 -0800
In-Reply-To: <20201103102531.91710-12-kgraul@linux.ibm.com>
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
         <20201103102531.91710-12-kgraul@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On Tue, 2020-11-03 at 11:25 +0100, Karsten Graul wrote:
> From: Guvenc Gulce <guvenc@linux.ibm.com>
> 
> Deliver SMCD Linkgroup information via netlink based
> diagnostic interface.
> 
> Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> ---
>  include/uapi/linux/smc_diag.h |   7 +++
>  net/smc/smc_diag.c            | 108
> ++++++++++++++++++++++++++++++++++
>  net/smc/smc_ism.c             |   2 +
>  3 files changed, 117 insertions(+)
> 
> diff --git a/include/uapi/linux/smc_diag.h
> b/include/uapi/linux/smc_diag.h
> index a57df0296aa4..5a80172df757 100644
> --- a/include/uapi/linux/smc_diag.h
> +++ b/include/uapi/linux/smc_diag.h
> @@ -81,6 +81,7 @@ enum {
>  enum {
>  	SMC_DIAG_LGR_INFO_SMCR = 1,
>  	SMC_DIAG_LGR_INFO_SMCR_LINK,
> +	SMC_DIAG_LGR_INFO_SMCD,
>  };
>  
> 
> +
> +static int smc_diag_fill_smcd_dev(struct smcd_dev_list *dev_list,
> +				  struct sk_buff *skb,
> +				  struct netlink_callback *cb,
> +				  struct smc_diag_req_v2 *req)
> +{
> +	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
> +	struct smcd_dev *smcd_dev;
> +	int snum = cb_ctx->pos[0];
> +	int rc = 0, num = 0;
> +
> +	mutex_lock(&dev_list->mutex);
> +	list_for_each_entry(smcd_dev, &dev_list->list, list) {
> +		if (!list_empty(&smcd_dev->lgr_list)) {

You could use early continue every where in this patch to avoid
indentation. 

> +			if (num < snum)
> +				goto next;
> +			rc = smc_diag_handle_smcd_lgr(smcd_dev, skb,
> +						      cb, req);
> +			if (rc < 0)
> +				goto errout;
> +next:
> +			num++;
> +		}
> +	}
> +errout:
> +	mutex_unlock(&dev_list->mutex);
> +	cb_ctx->pos[0] = num;
> +	return rc;
> +}
> +
>  static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>  			   struct netlink_callback *cb,
>  			   const struct smc_diag_req *req)
> @@ -441,6 +546,9 @@ static int smc_diag_dump_ext(struct sk_buff *skb,
> struct netlink_callback *cb)
>  		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR -
> 1))))
>  			smc_diag_fill_lgr_list(&smc_lgr_list, skb, cb,
>  					       req);
> +		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCD -
> 1))))
> +			smc_diag_fill_smcd_dev(&smcd_dev_list, skb, cb,
> +					       req);
>  	}
>  
>  	return skb->len;
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 6abbdd09a580..5bb2c7fb4ea8 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -20,6 +20,7 @@ struct smcd_dev_list smcd_dev_list = {
>  	.list = LIST_HEAD_INIT(smcd_dev_list.list),
>  	.mutex = __MUTEX_INITIALIZER(smcd_dev_list.mutex)
>  };
> +EXPORT_SYMBOL_GPL(smcd_dev_list);
>  
>  bool smc_ism_v2_capable;
>  
> @@ -50,6 +51,7 @@ u16 smc_ism_get_chid(struct smcd_dev *smcd)
>  {
>  	return smcd->ops->get_chid(smcd);
>  }
> +EXPORT_SYMBOL_GPL(smc_ism_get_chid);
>  

This is the 3rd EXPORT SYMBOL until now in this series,
IMHO it is unhealthy to contaminate the kernel symbol table just for
device specific diag purposes.
