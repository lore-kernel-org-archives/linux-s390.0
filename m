Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgJ3Rmv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Oct 2020 13:42:51 -0400
Date: Fri, 30 Oct 2020 18:42:42 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20201030184242.3bceee09.pasic@linux.ibm.com>
In-Reply-To: <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-2-akrowiak@linux.ibm.com>
        <20201027074846.30ee0ddc.pasic@linux.ibm.com>
        <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 29 Oct 2020 19:29:35 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >> @@ -1177,7 +1166,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> >>   			 */
> >>   			if (ret)
> >>   				rc = ret;
> >> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
> >> +			q = vfio_ap_get_queue(matrix_mdev,
> >> +					      AP_MKQID(apid, apqi));
> >> +			if (q)
> >> +				vfio_ap_free_aqic_resources(q);  
> > Is it safe to do vfio_ap_free_aqic_resources() at this point? I don't
> > think so. I mean does the current code (and vfio_ap_mdev_reset_queue()
> > in particular guarantee that the reset is actually done when we arrive
> > here)? BTW, I think we have a similar problem with the current code as
> > well.  
> 
> If the return code from the vfio_ap_mdev_reset_queue() function
> is zero, then yes, we are guaranteed the reset was done and the
> queue is empty.

I've read up on this and I disagree. We should discuss this offline.

>  The function returns a non-zero return code if
> the reset fails or the queue the reset did not complete within a given
> amount of time, so maybe we shouldn't free AQIC resources when
> we get a non-zero return code from the reset function?
> 

If the queue is gone, or broken, it won't produce interrupts or poke the
notifier bit, and we should clean up the AQIC resources.


> There are three occasions when the vfio_ap_mdev_reset_queues()
> is called:
> 1. When the VFIO_DEVICE_RESET ioctl is invoked from userspace
>      (i.e., when the guest is started)
> 2. When the mdev fd is closed (vfio_ap_mdev_release())
> 3. When the mdev is removed (vfio_ap_mdev_remove())
> 
> The IRQ resources are initialized when the PQAP(AQIC)
> is intercepted to enable interrupts. This would occur after
> the guest boots and the AP bus initializes. So, 1 would
> presumably occur before that happens. I couldn't find
> anywhere in the AP bus or zcrypt code where a PQAP(AQIC)
> is executed to disable interrupts, so my assumption is
> that IRQ disablement is accomplished by a reset on
> the guest. I'll have to ask Harald about that. So, 2 would
> occur when the guest is about to terminate and 3
> would occur only after the guest is terminated. In any
> case, it seems that IRQ resources should be cleaned up.
> Maybe it would be more appropriate to do that in the
> vfio_ap_mdev_release() and vfio_ap_mdev_remove()
> functions themselves?

I'm a bit confused. But I think you are wrong. What happens when the
guest reIPLs? I guess the subsystem reset should also do the
VFIO_DEVICE_RESET ioctl, and that has to reset the queues and disable
the interrupts. Or?

Regards,
Halil
