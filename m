Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbfKMMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:15:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADC9Bdm067248
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:15:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8hk20bhu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:15:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Nov 2019 12:15:19 -0000
Subject: Re: [PATCH] s390: vfio-ap: fix some comments
References: <20191113095319.6154-1-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 13 Nov 2019 13:15:15 +0100
MIME-Version: 1.0
In-Reply-To: <20191113095319.6154-1-cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <42f63f2b-2fc7-4a68-a86b-886f6a4efc04@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org


:) thanks,

Regards,

Pierre

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

On 2019-11-13 10:53, Cornelia Huck wrote:
> The functions are called vfio_ap_irq_{en,dis}able.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> Just some minor stuff I noted while grepping for something.
>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 5c0f53c6dde7..f8f3f3a4e5fd 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -182,7 +182,7 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>   }
>   
>   /**
> - * vfio_ap_setirq: Enable Interruption for a APQN
> + * vfio_ap_irq_enable: Enable Interruption for a APQN
>    *
>    * @dev: the device associated with the ap_queue
>    * @q:	 the vfio_ap_queue holding AQIC parameters
> @@ -265,7 +265,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>    * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
>    * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
>    * - AP_RESPONSE_NORMAL (0) : in case of successs
> - *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
> + *   Check vfio_ap_irq_enable() and vfio_ap_irq_disable() for other possible RC.
>    * We take the matrix_dev lock to ensure serialization on queues and
>    * mediated device access.
>    *

-- 
Pierre Morel
IBM Lab Boeblingen
