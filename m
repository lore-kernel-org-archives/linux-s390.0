Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727512AbgKTLWX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 06:22:23 -0500
Date: Fri, 20 Nov 2020 12:22:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
Message-ID: <20201120122209.18f89fb5.cohuck@redhat.com>
In-Reply-To: <27946d84-ae22-6882-67a5-edb5bd782bfa@linux.ibm.com>
References: <20201117032139.50988-1-farman@linux.ibm.com>
        <20201117032139.50988-2-farman@linux.ibm.com>
        <20201119123026.1353cb3c.cohuck@redhat.com>
        <20201119092754.240847b8@w520.home>
        <27946d84-ae22-6882-67a5-edb5bd782bfa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 19 Nov 2020 15:04:08 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 11/19/20 11:27 AM, Alex Williamson wrote:
> > On Thu, 19 Nov 2020 12:30:26 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Tue, 17 Nov 2020 04:21:38 +0100
> >> Eric Farman <farman@linux.ibm.com> wrote:
> >>  
> >>> While performing some destructive tests with vfio-ccw, where the
> >>> paths to a device are forcible removed and thus the device itself
> >>> is unreachable, it is rather easy to end up in an endless loop in
> >>> vfio_del_group_dev() due to the lack of a request callback for the
> >>> associated device.
> >>>
> >>> In this example, one MDEV (77c) is used by a guest, while another
> >>> (77b) is not. The symptom is that the iommu is detached from the
> >>> mdev for 77b, but not 77c, until that guest is shutdown:
> >>>
> >>>      [  238.794867] vfio_ccw 0.0.077b: MDEV: Unregistering
> >>>      [  238.794996] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: Removing from iommu group 2
> >>>      [  238.795001] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: MDEV: detaching iommu
> >>>      [  238.795036] vfio_ccw 0.0.077c: MDEV: Unregistering
> >>>      ...silence...
> >>>
> >>> Let's wire in the request call back to the mdev device, so that a hot
> >>> unplug can be (gracefully?) handled by the parent device at the time
> >>> the device is being removed.  
> >>
> >> I think it makes a lot of sense to give the vendor driver a way to
> >> handle requests.
> >>  
> >>>
> >>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >>> ---
> >>>   drivers/vfio/mdev/vfio_mdev.c | 11 +++++++++++
> >>>   include/linux/mdev.h          |  4 ++++
> >>>   2 files changed, 15 insertions(+)
> >>>
> >>> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
> >>> index 30964a4e0a28..2dd243f73945 100644
> >>> --- a/drivers/vfio/mdev/vfio_mdev.c
> >>> +++ b/drivers/vfio/mdev/vfio_mdev.c
> >>> @@ -98,6 +98,16 @@ static int vfio_mdev_mmap(void *device_data, struct vm_area_struct *vma)
> >>>   	return parent->ops->mmap(mdev, vma);
> >>>   }
> >>>   
> >>> +static void vfio_mdev_request(void *device_data, unsigned int count)
> >>> +{
> >>> +	struct mdev_device *mdev = device_data;
> >>> +	struct mdev_parent *parent = mdev->parent;
> >>> +
> >>> +	if (unlikely(!parent->ops->request))  
> >>
> >> Hm. Do you think that all drivers should implement a ->request()
> >> callback?  
> > 
> > It's considered optional for bus drivers in vfio-core, obviously
> > mdev-core could enforce presence of this callback, but then we'd break
> > existing out of tree drivers.  We don't make guarantees to out of tree
> > drivers, but it feels a little petty.  We could instead encourage such
> > support by printing a warning for drivers that register without a
> > request callback.  
> 
> Coincidentally, I'd considered adding a dev_warn_once() message in
> drivers/vfio/vfio.c:vfio_del_group_dev() when vfio_device->ops->request
> is NULL, and thus we're looping endlessly (and silently). But adding 
> this patch and not patch 2 made things silent again, so I left it out. 
> Putting a warning when the driver registers seems cool.

If we expect to run into problems without a callback, a warning seems
fine. Then we can also continue to use the (un)likely annotation
without it being weird.

> 
> > 
> > Minor nit, I tend to prefer:
> > 
> > 	if (callback for thing)
> > 		call thing
> > 
> > Rather than
> > 
> > 	if (!callback for thing)
> > 		return;
> > 	call thing  
> 
> I like it too.  I'll set it up that way in v2.

That also would be my preference, although existing code uses the
second pattern.

> 
> > 
> > Thanks,
> > Alex
> >   
> >>  
> >>> +		return;
> >>> +	parent->ops->request(mdev, count);
> >>> +}
> >>> +
> >>>   static const struct vfio_device_ops vfio_mdev_dev_ops = {
> >>>   	.name		= "vfio-mdev",
> >>>   	.open		= vfio_mdev_open,  
> >   
> 
