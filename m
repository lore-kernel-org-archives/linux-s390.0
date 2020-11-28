Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbgK1VHh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 16:07:37 -0500
Date: Sat, 28 Nov 2020 13:06:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v6 08/14] net/smc: Introduce generic netlink
 interface for diagnostic purposes
Message-ID: <20201128130655.0540f3e5@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201126203916.56071-9-kgraul@linux.ibm.com>
References: <20201126203916.56071-1-kgraul@linux.ibm.com>
        <20201126203916.56071-9-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, 26 Nov 2020 21:39:10 +0100 Karsten Graul wrote:
> +/* SMC_GENL family definition */
> +struct genl_family smc_gen_nl_family __ro_after_init = {
> +	.hdrsize = 0,
> +	.name = SMC_GENL_FAMILY_NAME,
> +	.version = SMC_GENL_FAMILY_VERSION,
> +	.maxattr = SMC_GEN_MAX,
> +	.netnsok = true,
> +	.module = THIS_MODULE,
> +	.ops = smc_gen_nl_ops,
> +	.n_ops =  ARRAY_SIZE(smc_gen_nl_ops)
> +};

Sorry, one more spin.

Now you'll let any attribute in. We try to reject any input that won't
be acted on in the kernel these days to allow the interfaces to be
extended in the future without worrying that something that was
throwing random data in the messages will suddenly start misbehaving.

You should still declare a policy just make it empty. And you can make
the policy array size 1, and set .maxattr to 1, AFAIK. These are both
pretty much* for input validation only.

* the only exception is dumping the policy to be able to tell types in
  user space automatically, but I don't think you'll care.
