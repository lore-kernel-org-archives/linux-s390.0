Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfIDHf5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 03:35:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x847Y3Dw047672
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 03:35:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ut7xaj6xt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 03:35:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 4 Sep 2019 08:35:53 +0100
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
 <20190830180250.79804f76.pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Sep 2019 09:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190830180250.79804f76.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

Halil,

can you also send this patch as a separate mail. This also requires a much better
patch description about the why and it certainly should also have an agreement from
Anthony.

On 30.08.19 18:02, Halil Pasic wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Fri, 30 Aug 2019 17:39:47 +0200
> Subject: [PATCH 2/2] s390: vfio-ap: don't wait after AQIC interpretation
> 
> Waiting for the asynchronous part of AQIC to complete as a part
> AQIC implementation is unnecessary and silly.
> 
> Let's get rid of vfio_ap_wait_for_irqclear().
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 50 ++-------------------------------------
>  1 file changed, 2 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index dd07ebf..8d098f0 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -68,47 +68,6 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
>  }
>  
>  /**
> - * vfio_ap_wait_for_irqclear
> - * @apqn: The AP Queue number
> - *
> - * Checks the IRQ bit for the status of this APQN using ap_tapq.
> - * Returns if the ap_tapq function succeeded and the bit is clear.
> - * Returns if ap_tapq function failed with invalid, deconfigured or
> - * checkstopped AP.
> - * Otherwise retries up to 5 times after waiting 20ms.
> - *
> - */
> -static void vfio_ap_wait_for_irqclear(int apqn)
> -{
> -	struct ap_queue_status status;
> -	int retry = 5;
> -
> -	do {
> -		status = ap_tapq(apqn, NULL);
> -		switch (status.response_code) {
> -		case AP_RESPONSE_NORMAL:
> -		case AP_RESPONSE_RESET_IN_PROGRESS:
> -			if (!status.irq_enabled)
> -				return;
> -			/* Fall through */
> -		case AP_RESPONSE_BUSY:
> -			msleep(20);
> -			break;
> -		case AP_RESPONSE_Q_NOT_AVAIL:
> -		case AP_RESPONSE_DECONFIGURED:
> -		case AP_RESPONSE_CHECKSTOPPED:
> -		default:
> -			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
> -				  status.response_code, apqn);
> -			return;
> -		}
> -	} while (--retry);
> -
> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> -		  __func__, status.response_code, apqn);
> -}
> -
> -/**
>   * vfio_ap_free_aqic_resources
>   * @q: The vfio_ap_queue
>   *
> @@ -133,14 +92,10 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>   * @q: The vfio_ap_queue
>   *
>   * Uses ap_aqic to disable the interruption and in case of success, reset
> - * in progress or IRQ disable command already proceeded: calls
> - * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
> - * and calls vfio_ap_free_aqic_resources() to free the resources associated
> + * in progress or IRQ disable command already proceeded :calls
> + * vfio_ap_free_aqic_resources() to free the resources associated
>   * with the AP interrupt handling.
>   *
> - * In the case the AP is busy, or a reset is in progress,
> - * retries after 20ms, up to 5 times.
> - *
>   * Returns if ap_aqic function failed with invalid, deconfigured or
>   * checkstopped AP.
>   */
> @@ -155,7 +110,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>  		switch (status.response_code) {
>  		case AP_RESPONSE_OTHERWISE_CHANGED:
>  		case AP_RESPONSE_NORMAL:
> -			vfio_ap_wait_for_irqclear(q->apqn);
>  			goto end_free;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
> -- 2.5.5
