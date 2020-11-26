Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKZASE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 19:18:04 -0500
Date: Wed, 25 Nov 2020 16:18:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v5 08/14] net/smc: Introduce generic netlink
 interface for diagnostic purposes
Message-ID: <20201125161802.402912b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201124175047.56949-9-kgraul@linux.ibm.com>
References: <20201124175047.56949-1-kgraul@linux.ibm.com>
        <20201124175047.56949-9-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, 24 Nov 2020 18:50:41 +0100 Karsten Graul wrote:
> From: Guvenc Gulce <guvenc@linux.ibm.com>
> 
> Introduce generic netlink interface infrastructure to expose
> the diagnostic information regarding smc linkgroups, links and devices.
> 
> Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

> @@ -2494,6 +2495,7 @@ static int __init smc_init(void)
>  
>  	smc_ism_init();
>  	smc_clc_init();
> +	smc_nl_init();

This can fail.

> +static const struct nla_policy smc_gen_nl_policy[SMC_GEN_MAX + 1] = {
> +	[SMC_GEN_UNSPEC]	= { .type = NLA_UNSPEC, },

This is unnecessary, NLA_UNSPEC is 0.

> +};
