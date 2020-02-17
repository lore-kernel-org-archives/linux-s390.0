Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbgBQRIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:08:13 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH4uBH026018
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6adr29st-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:08:10 -0000
Date: Mon, 17 Feb 2020 18:08:04 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] s390/cio: use kobj_to_dev() API
References: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
Message-Id: <your-ad-here.call-01581959284-ext-3641@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: qiwuchen55@gmail.com
Cc: sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

On Fri, Feb 14, 2020 at 09:51:33PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> Signed-off-by: chenqiwu <qiwuchen55@gmail.com>
> ---
> changes in v2:
>  - add signed off for my gmail adderss.
> --- 
>  drivers/s390/cio/chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> index 51038ec..dfcbe54 100644
> --- a/drivers/s390/cio/chp.c
> +++ b/drivers/s390/cio/chp.c
> @@ -135,7 +135,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
>  	struct channel_path *chp;
>  	struct device *device;
>  
> -	device = container_of(kobj, struct device, kobj);
> +	device = kobj_to_dev(kobj);
>  	chp = to_channelpath(device);
>  	if (chp->cmg == -1)
>  		return 0;
> @@ -184,7 +184,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
>  	struct device *device;
>  	unsigned int size;
>  
> -	device = container_of(kobj, struct device, kobj);
> +	device = kobj_to_dev(kobj);
>  	chp = to_channelpath(device);
>  	css = to_css(chp->dev.parent);
>  
> -- 
> 1.9.1
> 
Applied, thanks
