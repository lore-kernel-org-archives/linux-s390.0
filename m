Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgKKWfB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Nov 2020 17:35:01 -0500
Date: Wed, 11 Nov 2020 14:34:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 10/15] net/smc: Introduce SMCR get link
 command
Message-ID: <20201111143459.29aead6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201109151814.15040-11-kgraul@linux.ibm.com>
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
        <20201109151814.15040-11-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On Mon,  9 Nov 2020 16:18:09 +0100 Karsten Graul wrote:
> @@ -129,6 +131,12 @@ struct smc_diag_linkinfo {
>  	__u8 ibport;			/* RDMA device port number */
>  	__u8 gid[40];			/* local GID */
>  	__u8 peer_gid[40];		/* peer GID */
> +	/* Fields above used by legacy v1 code */
> +	__u32 conn_cnt;
> +	__u8 netdev[IFNAMSIZ];		/* ethernet device name */

Why report the name? Interfaces are generally identified by ifindex.

> +	__u8 link_uid[4];		/* unique link id */
> +	__u8 peer_link_uid[4];		/* unique peer link id */
> +	__u32 link_state;		/* link state */
>  };
