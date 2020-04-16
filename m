Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441115AbgDPJhe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Apr 2020 05:37:34 -0400
Date: Thu, 16 Apr 2020 11:37:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20200416113721.124f9843.cohuck@redhat.com>
In-Reply-To: <35d8c3cb-78bb-8f84-41d8-c6e59d201ba0@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-4-akrowiak@linux.ibm.com>
        <20200414145851.562867ae.cohuck@redhat.com>
        <35d8c3cb-78bb-8f84-41d8-c6e59d201ba0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Wed, 15 Apr 2020 13:10:10 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/14/20 8:58 AM, Cornelia Huck wrote:
> > On Tue,  7 Apr 2020 15:20:03 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >> +
> >> +	if (ap_drv->in_use)
> >> +		if (ap_drv->in_use(newapm, ap_perms.aqm))  
> > Can we log the offending apm somewhere, preferably with additional info
> > that allows the admin to figure out why an error was returned?  
> 
> One of the things on my TODO list is to add logging to the vfio_ap
> module which will track all significant activity within the device
> driver. I plan to do that with a patch or set of patches specifically
> put together for that purpose. Having said that, the best place to
> log this would be in the in_use callback in the vfio_ap device driver
> (see next patch) where the APQNs that are in use can be identified.
> For now, I will log a message to the dmesg log indicating which
> APQNs are in use by the matrix mdev.

Sounds reasonable. My main issue was what an admin was supposed to do
until logging was in place :)

> 
> >  
> >> +			rc = -EADDRINUSE;
> >> +
> >> +	module_put(drv->owner);
> >> +
> >> +	return rc;
> >> +}  
