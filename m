Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 5 Aug 2015 09:05:18 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390: Remove unneeded variables
Message-ID: <20150805070518.GB4163@osiris>
References: <1438701107-30727-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438701107-30727-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, linux390@de.ibm.com, maier@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 04, 2015 at 05:11:47PM +0200, Peter Senna Tschudin wrote:
> This patch remove unneeded variables used to store return values.
> 
> These issues were detected with the Coccinelle script:
> scripts/coccinelle/misc/returnvar.cocci
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  static struct css_device_id eadm_subchannel_ids[] = {
> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index 2e65b98..a79d698 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -392,8 +392,6 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
> 
>  static int qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
>  {
> -	int rc = 0;
> -
>  	QETH_DBF_TEXT(SETUP , 2, "stopcard");
>  	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
> 
> @@ -427,7 +425,8 @@ static int qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
>  		qeth_clear_cmd_buffers(&card->read);
>  		qeth_clear_cmd_buffers(&card->write);
>  	}
> -	return rc;
> +
> +	return 0;
>  }
> 
>  static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index 70eb2f6..ee5e2ac 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -2160,8 +2160,6 @@ static struct qeth_card *qeth_l3_get_card_from_dev(struct net_device *dev)
> 
>  static int qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
>  {
> -	int rc = 0;
> -
>  	QETH_DBF_TEXT(SETUP, 2, "stopcard");
>  	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
> 
> @@ -2196,7 +2194,8 @@ static int qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
>  		qeth_clear_cmd_buffers(&card->read);
>  		qeth_clear_cmd_buffers(&card->write);
>  	}
> -	return rc;
> +
> +	return 0;

Applied. However I changed your patch a bit and made the *_stop_card()
functions return void instead, since the calling functions didn't care
anyway.

Thanks!
