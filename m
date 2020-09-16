Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20200903083018.507894-1-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] dasd: remove the unused dasd_enable_device export
Message-ID: <20b28960-9c80-349e-c10f-bf45aae804e2@linux.ibm.com>
Date: Wed, 16 Sep 2020 16:52:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200903083018.507894-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Am 03.09.20 um 10:30 schrieb Christoph Hellwig:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by:Stefan Haberland <sth@linux.ibm.com>

> ---
>  drivers/s390/block/dasd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index eb17fea8075c6f..6ab992b3eed004 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -683,7 +683,6 @@ void dasd_enable_device(struct dasd_device *device)=

>  	if (device->discipline->kick_validate)
>  		device->discipline->kick_validate(device);
>  }
> -EXPORT_SYMBOL(dasd_enable_device);
> =20
>  /*
>   * SECTION: device operation (interrupt handler, start i/o, term i/o .=
=2E.)
