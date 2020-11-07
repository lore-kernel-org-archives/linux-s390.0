Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgKGR5f (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 7 Nov 2020 12:57:35 -0500
Date: Sat, 7 Nov 2020 09:57:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v3 03/15] net/smc: Add connection counters for
 links
Message-ID: <20201107095733.7a381e84@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201107125958.16384-4-kgraul@linux.ibm.com>
References: <20201107125958.16384-1-kgraul@linux.ibm.com>
        <20201107125958.16384-4-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On Sat,  7 Nov 2020 13:59:46 +0100 Karsten Graul wrote:
> +static inline void smc_switch_link_and_count(struct smc_connection *conn,
> +					     struct smc_link *to_lnk)

Please avoid the use of static inline functions.

The compiler should inline this 3 instruction function anyway.

Please fix other instances in this submission as well.

> +{
> +	atomic_dec(&conn->lnk->conn_cnt);
> +	conn->lnk = to_lnk;
> +	atomic_inc(&conn->lnk->conn_cnt);
> +}
