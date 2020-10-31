Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgJaEI7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 00:08:59 -0400
Date: Sat, 31 Oct 2020 04:43:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20201031044329.77b5a249.pasic@linux.ibm.com>
In-Reply-To: <cb40a506-4a17-3562-728c-cbb57cd99817@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-2-akrowiak@linux.ibm.com>
        <20201027074846.30ee0ddc.pasic@linux.ibm.com>
        <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
        <20201030184242.3bceee09.pasic@linux.ibm.com>
        <cb40a506-4a17-3562-728c-cbb57cd99817@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 30 Oct 2020 16:37:04 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 10/30/20 1:42 PM, Halil Pasic wrote:
> > On Thu, 29 Oct 2020 19:29:35 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >>>> @@ -1177,7 +1166,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> >>>>    			 */
> >>>>    			if (ret)
> >>>>    				rc = ret;
> >>>> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
> >>>> +			q = vfio_ap_get_queue(matrix_mdev,
> >>>> +					      AP_MKQID(apid, apqi));
> >>>> +			if (q)
> >>>> +				vfio_ap_free_aqic_resources(q);  
> >>> Is it safe to do vfio_ap_free_aqic_resources() at this point? I don't
> >>> think so. I mean does the current code (and vfio_ap_mdev_reset_queue()
> >>> in particular guarantee that the reset is actually done when we arrive
> >>> here)? BTW, I think we have a similar problem with the current code as
> >>> well.  
> >> If the return code from the vfio_ap_mdev_reset_queue() function
> >> is zero, then yes, we are guaranteed the reset was done and the
> >> queue is empty.  
> > I've read up on this and I disagree. We should discuss this offline.  
> 
> Maybe you are confusing things here; my statement is specific to the return
> code from the vfio_ap_mdev_reset_queue() function, not the response code
> from the PQAP(ZAPQ) instruction. The vfio_ap_mdev_reset_queue()
> function issues the PQAP(ZAPQ) instruction and if the status response code
> is 0 indicating the reset was successfully initiated, it waits for the
> queue to empty. When the queue is empty, it returns 0 to indicate
> the queue is reset. 
> If the queue does not become empty after a period of 
> time,
> it will issue a warning (WARN_ON_ONCE) and return 0. In that case, I suppose
> there is no guarantee the reset was done, so maybe a change needs to be
> made there such as a non-zero return code.
>

I've overlooked the wait for empty. Maybe that return 0 had a part in
it. I now remember me insisting on having the wait code added when the
interrupt support was in the make. Sorry!

If we have given up on out of retries retries, we are in trouble anyway.
 
> >  
> >>    The function returns a non-zero return code if
> >> the reset fails or the queue the reset did not complete within a given
> >> amount of time, so maybe we shouldn't free AQIC resources when
> >> we get a non-zero return code from the reset function?
> >>  
> > If the queue is gone, or broken, it won't produce interrupts or poke the
> > notifier bit, and we should clean up the AQIC resources.  
> 
> True, which is what the code provided by this patch does; however,
> the AQIC resources should be cleaned up only if the KVM pointer is
> not NULL for reasons discussed elsewhere.

Yes, but these should be cleaned up before the KVM pointer becomes
null. We don't want to keep the page with the notifier byte pinned
forever, or?
