From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Thu, 04 Aug 2016 07:34:17 +0000
Subject: Re: [bug report] [S390] dasd: Add support for raw ECKD access.
Message-Id: <57A2EFF9.1010706@linux.vnet.ibm.com>
In-Reply-To: <20160803124338.GA16986@mwanda>
References: <20160803124338.GA16986@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

thanks for the report.

Am 03.08.2016 um 14:43 schrieb Dan Carpenter:
> Hello Stefan Haberland,
>
> The patch e4dbb0f2b5dd: "[S390] dasd: Add support for raw ECKD
> access." from Jan 5, 2011, leads to the following static checker
> warning:
>
> 	drivers/s390/block/dasd_eckd.c:3970 dasd_raw_build_cp()
> 	warn: 'cqr' isn't an ERR_PTR
>
> drivers/s390/block/dasd_eckd.c
>    3961          cqr->startdev = startdev;
>    3962          cqr->memdev = startdev;
>    3963          cqr->block = block;
>    3964          cqr->expires = startdev->default_expires * HZ;
>    3965          cqr->lpm = startdev->path_data.ppm;
>    3966          cqr->retries = startdev->default_retries;
>    3967          cqr->buildclk = get_tod_clock();
>    3968          cqr->status = DASD_CQR_FILLED;
>                  ^^^^^^^^^^^
> We're dereferencing cqr pretty hard here.

cqr is checked previously so it is valid at this point.

>
>    3969
>    3970          if (IS_ERR(cqr) && PTR_ERR(cqr) != -EAGAIN)
>                      ^^^^^^^^^^^
> so it had better not be an error pointer.  Perhaps move this after the
> out label?

This line does not make any sense.
It will never be reached since cqr is checked previously and returning 
an error in cqr is correct. I will remove it.

>
>    3971                  cqr = NULL;
>    3972  out:
>    3973          return cqr;
>    3974  }
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
