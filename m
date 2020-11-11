Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgKKWeP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Nov 2020 17:34:15 -0500
Date: Wed, 11 Nov 2020 14:34:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 09/15] net/smc: Introduce SMCR get linkgroup
 command
Message-ID: <20201111143405.7f5fb92f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201109151814.15040-10-kgraul@linux.ibm.com>
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
        <20201109151814.15040-10-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On Mon,  9 Nov 2020 16:18:08 +0100 Karsten Graul wrote:
> @@ -295,6 +377,14 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
>  {
> +	struct smc_diag_req_v2 *req = nlmsg_data(cb->nlh);
> +
> +	if (req->cmd == SMC_DIAG_GET_LGR_INFO) {
> +		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR - 1))))
> +			smc_diag_fill_lgr_list(smc_diag_ops->get_lgr_list(),
> +					       skb, cb, req);
> +	}
> +
>  	return skb->len;
>  }

IDK if this is appropriate for socket diag handler.

Is there precedent for funneling commands through socket diag instead
of just creating a genetlink family?
