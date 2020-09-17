Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbgIQMPB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Sep 2020 08:15:01 -0400
Date: Thu, 17 Sep 2020 14:14:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 04/16] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20200917141442.6e531799.cohuck@redhat.com>
In-Reply-To: <fe3ba715-8ea7-45df-4144-d1f5dec38a45@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-5-akrowiak@linux.ibm.com>
        <20200914172947.533ddf56.cohuck@redhat.com>
        <fe3ba715-8ea7-45df-4144-d1f5dec38a45@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>

On Tue, 15 Sep 2020 15:32:35 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 9/14/20 11:29 AM, Cornelia Huck wrote:
> > On Fri, 21 Aug 2020 15:56:04 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> Introduces a new driver callback to prevent a root user from unbinding
> >> an AP queue from its device driver if the queue is in use. The intent of
> >> this callback is to provide a driver with the means to prevent a root user
> >> from inadvertently taking a queue away from a matrix mdev and giving it to
> >> the host while it is assigned to the matrix mdev. The callback will
> >> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
> >> attributes would result in one or more AP queues being removed from its
> >> driver. If the callback responds in the affirmative for any driver
> >> queried, the change to the apmask or aqmask will be rejected with a device
> >> in use error.
> >>
> >> For this patch, only non-default drivers will be queried. Currently,
> >> there is only one non-default driver, the vfio_ap device driver. The
> >> vfio_ap device driver facilitates pass-through of an AP queue to a
> >> guest. The idea here is that a guest may be administered by a different
> >> sysadmin than the host and we don't want AP resources to unexpectedly
> >> disappear from a guest's AP configuration (i.e., adapters, domains and
> >> control domains assigned to the matrix mdev). This will enforce the proper
> >> procedure for removing AP resources intended for guest usage which is to
> >> first unassign them from the matrix mdev, then unbind them from the
> >> vfio_ap device driver.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reported-by: kernel test robot <lkp@intel.com>  
> > This looks a bit odd...  
> 
> I've removed all of those. These kernel test robot errors were flagged
> in the last series. The review comments from the robot suggested
> the reported-by, but I assume that was for patches intended to
> fix those errors, so I am removing these as per Christian's comments.

Yes, I think the Reported-by: mostly makes sense if you include a patch
to fix something on top.

> 
> >  
> >> ---
> >>   drivers/s390/crypto/ap_bus.c | 148 ++++++++++++++++++++++++++++++++---
> >>   drivers/s390/crypto/ap_bus.h |   4 +
> >>   2 files changed, 142 insertions(+), 10 deletions(-)
> >>  
> > (...)
> >  
> >> @@ -1107,12 +1118,70 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
> >>   	return rc;
> >>   }
> >>   
> >> +static int __verify_card_reservations(struct device_driver *drv, void *data)
> >> +{
> >> +	int rc = 0;
> >> +	struct ap_driver *ap_drv = to_ap_drv(drv);
> >> +	unsigned long *newapm = (unsigned long *)data;
> >> +
> >> +	/*
> >> +	 * No need to verify whether the driver is using the queues if it is the
> >> +	 * default driver.
> >> +	 */
> >> +	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
> >> +		return 0;
> >> +
> >> +	/* The non-default driver's module must be loaded */
> >> +	if (!try_module_get(drv->owner))
> >> +		return 0;
> >> +
> >> +	if (ap_drv->in_use)
> >> +		if (ap_drv->in_use(newapm, ap_perms.aqm))
> >> +			rc = -EADDRINUSE;  
> > ISTR that Christian suggested -EBUSY in a past revision of this series?
> > I think that would be more appropriate.  
> 
> I went back and looked and sure enough, he did recommend that.
> You have a great memory! I didn't respond to that comment, so I
> must have missed it at the time.
> 
> I personally prefer EADDRINUSE because I think it is more indicative
> of the reason an AP resource can not be assigned back to the host
> drivers is because it is in use by a guest or, at the very least, reserved
> for use by a guest (i.e., assigned to an mdev). To say it is busy implies
> that the device is busy performing encryption services which may or
> may not be true at a given moment. Even if so, that is not the reason
> for refusing to allow reassignment of the device.

I have a different understanding of these error codes: EADDRINUSE is
something used in the networking context when an actual address is
already used elsewhere. EBUSY is more of a generic error that indicates
that a certain resource is not free to perform the requested operation;
it does not necessarily mean that the resource is currently actively
doing something. Kind of when you get EBUSY when trying to eject
something another program holds a reference on: that other program
might not actually be doing anything, but it potentially could.
