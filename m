Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgC0QuW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RGXcZx044218
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 12:50:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 300jevhk3q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 12:50:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Fri, 27 Mar 2020 16:50:18 -0000
Subject: Re: [PATCH 1/2] s390/cio: avoid duplicated 'ADD' uevents
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-2-cohuck@redhat.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Fri, 27 Mar 2020 17:50:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0301bea5-521f-21bc-f641-d0f256ddb385@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>

On 27.03.2020 13:45, Cornelia Huck wrote:
> The common I/O layer delays the ADD uevent for subchannels and
> delegates generating this uevent to the individual subchannel
> drivers. The io_subchannel driver will do so when the associated
> ccw_device has been registered -- but unconditionally, so more
> ADD uevents will be generated if a subchannel has been unbound
> from the io_subchannel driver and later rebound.
> 
> To fix this, only generate the ADD event if uevents were still
> suppressed for the device.
> 
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Fixes: fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Please also add Vineeth on cc of future patches against core CIO code.

This patch looks sane and makes handling of suppressed UDEV events
consistent to what is already implemented for CHSC and EADM subchannel
types.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

> ---
>  drivers/s390/cio/device.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 0c6245fc7706..983f9c9e08de 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -849,8 +849,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
>  	 * Now we know this subchannel will stay, we can throw
>  	 * our delayed uevent.
>  	 */
> -	dev_set_uevent_suppress(&sch->dev, 0);
> -	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
>  	/* make it known to the system */
>  	ret = ccw_device_add(cdev);
>  	if (ret) {
> @@ -1058,8 +1060,11 @@ static int io_subchannel_probe(struct subchannel *sch)
>  		 * Throw the delayed uevent for the subchannel, register
>  		 * the ccw_device and exit.
>  		 */
> -		dev_set_uevent_suppress(&sch->dev, 0);
> -		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		if (dev_get_uevent_suppress(&sch->dev)) {
> +			/* should always be the case for the console */
> +			dev_set_uevent_suppress(&sch->dev, 0);
> +			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		}
>  		cdev = sch_get_cdev(sch);
>  		rc = ccw_device_add(cdev);
>  		if (rc) {
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
