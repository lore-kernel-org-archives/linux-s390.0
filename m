Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbhANCu7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 21:50:59 -0500
Date: Thu, 14 Jan 2021 03:50:09 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 05/15] s390/vfio-ap: manage link between queue
 struct and matrix mdev
Message-ID: <20210114035009.375c5496.pasic@linux.ibm.com>
In-Reply-To: <8c701a5c-39f8-0c22-c936-aebbc3c8f60e@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-6-akrowiak@linux.ibm.com>
        <20210111201752.21a41db4.pasic@linux.ibm.com>
        <8c701a5c-39f8-0c22-c936-aebbc3c8f60e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 13 Jan 2021 16:41:27 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 1/11/21 2:17 PM, Halil Pasic wrote:
> > On Tue, 22 Dec 2020 20:15:56 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> Let's create links between each queue device bound to the vfio_ap device
> >> driver and the matrix mdev to which the queue's APQN is assigned. The idea
> >> is to facilitate efficient retrieval of the objects representing the queue
> >> devices and matrix mdevs as well as to verify that a queue assigned to
> >> a matrix mdev is bound to the driver.
> >>
> >> The links will be created as follows:
> >>
> >>     * When the queue device is probed, if its APQN is assigned to a matrix
> >>       mdev, the structures representing the queue device and the matrix mdev
> >>       will be linked.
> >>
> >>     * When an adapter or domain is assigned to a matrix mdev, for each new
> >>       APQN assigned that references a queue device bound to the vfio_ap
> >>       device driver, the structures representing the queue device and the
> >>       matrix mdev will be linked.
> >>
> >> The links will be removed as follows:
> >>
> >>     * When the queue device is removed, if its APQN is assigned to a matrix
> >>       mdev, the structures representing the queue device and the matrix mdev
> >>       will be unlinked.
> >>
> >>     * When an adapter or domain is unassigned from a matrix mdev, for each
> >>       APQN unassigned that references a queue device bound to the vfio_ap
> >>       device driver, the structures representing the queue device and the
> >>       matrix mdev will be unlinked.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >  

[..]

> >> +
> >>   int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
> >>   {
> >>   	struct vfio_ap_queue *q;
> >> @@ -1324,9 +1404,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
> >>   	q = kzalloc(sizeof(*q), GFP_KERNEL);
> >>   	if (!q)
> >>   		return -ENOMEM;
> >> +	mutex_lock(&matrix_dev->lock);
> >>   	dev_set_drvdata(&apdev->device, q);
> >>   	q->apqn = to_ap_queue(&apdev->device)->qid;
> >>   	q->saved_isc = VFIO_AP_ISC_INVALID;
> >> +	vfio_ap_queue_link_mdev(q);
> >> +	mutex_unlock(&matrix_dev->lock);
> >> +  
> > Does the critical section have to include more than just
> > vfio_ap_queue_link_mdev()? Did we need the critical section
> > before this patch?  
> 
> We did not need the critical section before this patch because
> the only function that retrieved the vfio_ap_queue via the queue
> device's drvdata was the remove callback. I included the initialization
> of the vfio_ap_queue object under lock because the
> vfio_ap_find_queue() function retrieves the vfio_ap_queue object from
> the queue device's drvdata so it might be advantageous to initialize
> it under the mdev lock. On the other hand, I can't come up with a good
> argument to change this.
> 
> 

I was asking out of curiosity, not because I want it changed. I was
also wondering if somebody could see a partially initialized device:
we even first call dev_set_drvdata() and only then finish the
initialization. Before 's390/vfio-ap: use new AP bus interface to search
for queue devices', which is the previous patch, we had the klist code
in between, which uses spinlocks, which I think ensure, that all
effects of probe are seen when we get the queue from
vfio_ap_find_queue(). But with patch 4 in place that is not the case any
more. Or am I wrong?

Regards,
Halil
