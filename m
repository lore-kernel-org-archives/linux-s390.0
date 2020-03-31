Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbgCaCCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 22:02:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V1Wrc5018082
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303v2s8scb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02V1omNH021012
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Subject: Re: [PATCH 2/2] s390/cio: generate delayed uevent for vfio-ccw
 subchannels
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-3-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <486c1d51-2736-cf2f-8b82-2203b45cd928@linux.ibm.com>
Date: Mon, 30 Mar 2020 22:02:10 -0400
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>



On 3/27/20 8:45 AM, Cornelia Huck wrote:
> The common I/O layer delays the ADD uevent for subchannels and
> delegates generating this uevent to the individual subchannel
> drivers. The vfio-ccw I/O subchannel driver, however, did not
> do that, and will not generate an ADD uevent for subchannels
> that had not been bound to a different driver (or none at all,
> which also triggers the uevent).
> 
> Generate the ADD uevent at the end of the probe function if
> uevents were still suppressed for the device.
> 
> Fixes: 63f1934d562d ("vfio: ccw: basic implementation for vfio_ccw driver")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

This seems to line up with the other drivers.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index e401a3d0aa57..339a6bc0339b 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -167,6 +167,11 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>  	if (ret)
>  		goto out_disable;
>  
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
> +
>  	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
>  			   sch->schid.cssid, sch->schid.ssid,
>  			   sch->schid.sch_no);
> 
