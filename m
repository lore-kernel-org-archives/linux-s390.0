Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgKSMA0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 07:00:26 -0500
Date: Thu, 19 Nov 2020 13:00:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 2/2] vfio-ccw: Wire in the request callback
Message-ID: <20201119130011.0bc2cbbe.cohuck@redhat.com>
In-Reply-To: <20201119124326.0345a353.cohuck@redhat.com>
References: <20201117032139.50988-1-farman@linux.ibm.com>
        <20201117032139.50988-3-farman@linux.ibm.com>
        <20201119124326.0345a353.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 19 Nov 2020 12:43:26 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 17 Nov 2020 04:21:39 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
> > The device is being unplugged, so pass the request to userspace to
> > ask for a graceful cleanup. This should free up the thread that
> > would otherwise loop waiting for the device to be fully released.
> > 
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
> >  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
> >  include/uapi/linux/vfio.h           |  1 +
> >  3 files changed, 31 insertions(+)
> >   
> 
> (...)
> 
> > @@ -607,6 +611,27 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
> >  	}
> >  }
> >  
> > +/* Request removal of the device*/
> > +static void vfio_ccw_mdev_request(struct mdev_device *mdev, unsigned int count)
> > +{
> > +	struct vfio_ccw_private *private = dev_get_drvdata(mdev_parent_dev(mdev));
> > +
> > +	if (!private)
> > +		return;
> > +
> > +	if (private->req_trigger) {
> > +		if (!(count % 10))
> > +			dev_notice_ratelimited(mdev_dev(private->mdev),
> > +					       "Relaying device request to user (#%u)\n",
> > +					       count);
> > +
> > +		eventfd_signal(private->req_trigger, 1);
> > +	} else if (count == 0) {
> > +		dev_notice(mdev_dev(private->mdev),
> > +			   "No device request channel registered, blocked until released by user\n");
> > +	}
> > +}  
> 
> This looks like the vfio-pci request handler, so probably good :)
> 
> Still have to read up on the QEMU side, but a LGTM for now.

And now that I've looked at the QEMU code:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
