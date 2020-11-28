Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbgK1VIV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 16:08:21 -0500
Date: Sat, 28 Nov 2020 13:07:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v6 09/14] net/smc: Add support for obtaining
 system information
Message-ID: <20201128130740.4f12c6e3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201126203916.56071-10-kgraul@linux.ibm.com>
References: <20201126203916.56071-1-kgraul@linux.ibm.com>
        <20201126203916.56071-10-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, 26 Nov 2020 21:39:11 +0100 Karsten Graul wrote:
> +	attrs = nla_nest_start_noflag(skb, SMC_GEN_SYS_INFO);

Missed this, nla_nest_start(), the _noflag() is for legacy code.
New families should not use it.
