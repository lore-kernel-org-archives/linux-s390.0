Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Oct 2020 18:54:06 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20201030185406.7fa13fbe.pasic@linux.ibm.com>
In-Reply-To: <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-2-akrowiak@linux.ibm.com>
        <20201027074846.30ee0ddc.pasic@linux.ibm.com>
        <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

[..]

> >
> > Under what circumstances do we expect !q? If we don't, then we need to
> > complain one way or another.  
> 
> In the current code (i.e., prior to introducing the subsequent hot
> plug patches), an APQN can not be assigned to an mdev unless it
> references a queue device bound to the vfio_ap device driver; however,
> there is nothing preventing a queue device from getting unbound
> while the guest is running (one of the problems mostly resolved by this
> series). In that case, q would be NULL.

But if the queue does not belong to us any more it does not make sense
call vfio_ap_mdev_reset_queue() on it's APQN, or?

I think we should have 

if(!q)
	continue; 
at the very beginning of the loop body, or we want to be sure that q is
not null. 
