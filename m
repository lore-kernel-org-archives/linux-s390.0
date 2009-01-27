From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 27 Jan 2009 11:16:44 +0000
Subject: Re: s390: struct device - replace bus_id with dev_name(),
Message-Id: <20090127121644.30606dc0@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1232924229.2924.22.camel@nga>
References: <1232924229.2924.22.camel@nga>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 25 Jan 2009 23:57:09 +0100
Kay Sievers <kay.sievers@vrfy.org> wrote:

> From: Kay Sievers <kay.sievers@vrfy.org>
> Subject: s390: struct device - replace bus_id with dev_name(), dev_set_name()
[...]
>  drivers/s390/net/qeth_l3_main.c |    2 +-
[...]
> @@ -1038,7 +1038,7 @@ static int qeth_l3_setadapter_parms(stru
>  	rc = qeth_query_setadapterparms(card);
>  	if (rc) {
>  		QETH_DBF_MESSAGE(2, "%s couldn't set adapter parameters: "
> -			"0x%x\n", card->gdev->dev.bus_id, rc);
> +			"0x%x\n", dev_name(&card->gdev->dev), rc);
>  		return rc;

Applied, thanks.
