Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24478 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731572AbhAOBpe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 20:45:34 -0500
Date: Fri, 15 Jan 2021 02:44:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 06/15] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20210115024441.1d8f41bc.pasic@linux.ibm.com>
In-Reply-To: <270e192b-b88d-b072-428c-6cbfc0f9a280@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-7-akrowiak@linux.ibm.com>
        <20210111214037.477f0f03.pasic@linux.ibm.com>
        <270e192b-b88d-b072-428c-6cbfc0f9a280@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 14 Jan 2021 12:54:39 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >>   /**
> >>    * vfio_ap_mdev_verify_no_sharing
> >>    *
> >> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> >> - * and AP queue indexes comprising the AP matrix are not configured for another
> >> - * mediated device. AP queue sharing is not allowed.
> >> + * Verifies that each APQN derived from the Cartesian product of the AP adapter
> >> + * IDs and AP queue indexes comprising the AP matrix are not configured for
> >> + * another mediated device. AP queue sharing is not allowed.
> >>    *
> >> - * @matrix_mdev: the mediated matrix device
> >> + * @matrix_mdev: the mediated matrix device to which the APQNs being verified
> >> + *		 are assigned.
> >> + * @mdev_apm: mask indicating the APIDs of the APQNs to be verified
> >> + * @mdev_aqm: mask indicating the APQIs of the APQNs to be verified
> >>    *
> >> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> >> + * Returns 0 if the APQNs are not shared, otherwise; returns -EBUSY.
> >>    */
> >> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> >> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev,
> >> +					  unsigned long *mdev_apm,
> >> +					  unsigned long *mdev_aqm)
> >>   {
> >>   	struct ap_matrix_mdev *lstdev;
> >>   	DECLARE_BITMAP(apm, AP_DEVICES);
> >> @@ -523,20 +426,31 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> >>   		 * We work on full longs, as we can only exclude the leftover
> >>   		 * bits in non-inverse order. The leftover is all zeros.
> >>   		 */
> >> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
> >> -				lstdev->matrix.apm, AP_DEVICES))
> >> +		if (!bitmap_and(apm, mdev_apm, lstdev->matrix.apm, AP_DEVICES))
> >>   			continue;
> >>   
> >> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
> >> -				lstdev->matrix.aqm, AP_DOMAINS))
> >> +		if (!bitmap_and(aqm, mdev_aqm, lstdev->matrix.aqm, AP_DOMAINS))
> >>   			continue;
> >>   
> >> -		return -EADDRINUSE;
> >> +		vfio_ap_mdev_log_sharing_err(dev_name(mdev_dev(lstdev->mdev)),
> >> +					     apm, aqm);
> >> +
> >> +		return -EBUSY;  
> > Why do we change -EADDRINUSE to -EBUSY? This gets bubbled up to
> > userspace, or? So a tool that checks for the other mdev has it
> > condition by checking for -EADDRINUSE, would be confused...  
> 
> Back in v8 of the series, Christian suggested the occurrences
> of -EADDRINUSE should be replaced by the more appropriate
> -EBUSY (Message ID <d7954c15-b14f-d6e5-0193-aadca61883a8@de.ibm.com>),
> so I changed it here. It does get bubbled up to userspace, so you make a 
> valid point. I will
> change it back. I will, however, set the value returned from the
> __verify_card_reservations() function in ap_bus.c to -EBUSY as
> suggested by Christian.

As long as the error code for an ephemeral failure due to can't take a
lock right now, and the error code for a failure due to a sharing
conflict are (which most likely requires admin action to be resolved)
I'm fine.

Choosing EBUSY for sharing conflict, and something else for can't take
lock for the bus attributes, while choosing EADDRINUSE for sharing
conflict, and EBUSY for can't take lock in the case of the mdev
attributes (assign_*; unassign_*) sounds confusing to me, but is still
better than collating the two conditions. Maybe we can choose EAGAIN
or EWOULDBLOCK for the can't take the lock right now. I don't know.

I'm open to suggestions. And if Christian wants to change this for
the already released interfaces, I will have to live with that. But it
has to be a conscious decision at least.

What I consider tricky about EBUSY, is that according to my intuition,
in pseudocode, object.operation(argument) returns -EBUSY probably tells
me that object is busy (i.e. is in the middle of something incompatible
with performing operation). In our case, it is not the object that is
busy, but the resource denoted by the argument.

Regards,
Halil
