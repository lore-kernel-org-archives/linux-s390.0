Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbfJ3HoT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 03:44:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9U7gdgu112284
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 03:44:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vy5tx92d5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 03:44:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 30 Oct 2019 07:44:16 -0000
Subject: Re: [PATCH] s390: vfio-ap: disable IRQ in remove callback results in
 kernel OOPS
References: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 30 Oct 2019 08:44:11 +0100
MIME-Version: 1.0
In-Reply-To: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0565c250-726f-dd99-f933-f91162dc107e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com

On 29.10.19 23:09, Tony Krowiak wrote:
> From: aekrowia <akrowiak@linux.ibm.com>
>
> When an AP adapter card is configured off via the SE or the SCLP
> Deconfigure Adjunct Processor command and the AP bus subsequently detects
> that the adapter card is no longer in the AP configuration, the card
> device representing the adapter card as well as each of its associated
> AP queue devices will be removed by the AP bus. If one or more of the
> affected queue devices is bound to the VFIO AP device driver, its remove
> callback will be invoked for each queue to be removed. The remove callback
> resets the queue and disables IRQ processing. If interrupt processing was
> never enabled for the queue, disabling IRQ processing will fail resulting
> in a kernel OOPS.
>
> This patch verifies IRQ processing is enabled before attempting to disable
> interrupts for the queue.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Signed-off-by: aekrowia <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index be2520cc010b..42d8308fd3a1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -79,7 +79,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>  	apid = AP_QID_CARD(q->apqn);
>  	apqi = AP_QID_QUEUE(q->apqn);
>  	vfio_ap_mdev_reset_queue(apid, apqi, 1);
> -	vfio_ap_irq_disable(q);
> +	if (q->saved_isc != VFIO_AP_ISC_INVALID)
> +		vfio_ap_irq_disable(q);
>  	kfree(q);
>  	mutex_unlock(&matrix_dev->lock);
>  }
Reset of an APQN does also clear IRQ processing. I don't say that the
resources associated with IRQ handling for the APQN are also cleared.
But when you call PQAP(AQIC) after an PQAP(RAPQ) or PQAP(ZAPQ)
it is superfluous. However, there should not appear any kernel OOPS.
So can you please give me more details about this kernel oops - maybe
I need to add exception handler code to the inline ap_aqic() function.

regards, Harald Freudenberger
