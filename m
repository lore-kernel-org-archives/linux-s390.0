Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49346 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731849AbgDAHar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Apr 2020 03:30:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03175pka170487
        for <linux-s390@vger.kernel.org>; Wed, 1 Apr 2020 03:30:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304mcb3ju6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 01 Apr 2020 03:30:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <fiuczy@linux.ibm.com>;
        Wed, 1 Apr 2020 08:30:35 +0100
Subject: Re: [PATCH 1/2] s390/cio: avoid duplicated 'ADD' uevents
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-2-cohuck@redhat.com>
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
Date: Wed, 1 Apr 2020 09:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-2-cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ce487cdf-fd2a-e466-8234-b2591967eb50@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>

The code changes look good and I was able to test this fix successfully.
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>


On 3/27/20 1:45 PM, Cornelia Huck wrote:
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
> ---
>   drivers/s390/cio/device.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 0c6245fc7706..983f9c9e08de 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -849,8 +849,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
>   	 * Now we know this subchannel will stay, we can throw
>   	 * our delayed uevent.
>   	 */
> -	dev_set_uevent_suppress(&sch->dev, 0);
> -	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
>   	/* make it known to the system */
>   	ret = ccw_device_add(cdev);
>   	if (ret) {
> @@ -1058,8 +1060,11 @@ static int io_subchannel_probe(struct subchannel *sch)
>   		 * Throw the delayed uevent for the subchannel, register
>   		 * the ccw_device and exit.
>   		 */
> -		dev_set_uevent_suppress(&sch->dev, 0);
> -		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		if (dev_get_uevent_suppress(&sch->dev)) {
> +			/* should always be the case for the console */
> +			dev_set_uevent_suppress(&sch->dev, 0);
> +			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		}
>   		cdev = sch_get_cdev(sch);
>   		rc = ccw_device_add(cdev);
>   		if (rc) {
> 


-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
