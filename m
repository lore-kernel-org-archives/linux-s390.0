Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEERVw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 13:21:52 -0400
Date: Tue, 5 May 2020 10:21:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 10/11] s390/qeth: allow reset via ethtool
Message-ID: <20200505102149.1fd5b9ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200505162559.14138-11-jwi@linux.ibm.com>
References: <20200505162559.14138-1-jwi@linux.ibm.com>
        <20200505162559.14138-11-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Tue,  5 May 2020 18:25:58 +0200 Julian Wiedmann wrote:
> Implement the .reset callback. Only a full reset is supported.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_ethtool.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
> index ebdc03210608..0d12002d0615 100644
> --- a/drivers/s390/net/qeth_ethtool.c
> +++ b/drivers/s390/net/qeth_ethtool.c
> @@ -193,6 +193,21 @@ static void qeth_get_drvinfo(struct net_device *dev,
>  		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
>  }
>  
> +static int qeth_reset(struct net_device *dev, u32 *flags)
> +{
> +	struct qeth_card *card = dev->ml_priv;
> +	int rc;
> +
> +	if (*flags != ETH_RESET_ALL)
> +		return -EINVAL;
> +
> +	rc = qeth_schedule_recovery(card);
> +	if (!rc)
> +		*flags = 0;

I think it's better if you only clear the flags for things you actually
reset. See the commit message for 7a13240e3718 ("bnxt_en: fix
ethtool_reset_flags ABI violations").
