Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgFEHji (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 03:39:38 -0400
Date: Fri, 5 Jun 2020 09:39:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/virtio: remove unused pm callbacks
Message-ID: <20200605093907.4d4b3c2a.cohuck@redhat.com>
In-Reply-To: <20200604234421.4ada966b.pasic@linux.ibm.com>
References: <20200526093629.257649-1-cohuck@redhat.com>
        <20200604234421.4ada966b.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

On Thu, 4 Jun 2020 23:44:21 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 26 May 2020 11:36:29 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Support for hibernation on s390 has been recently been removed with

s/been recently been removed/recently been removed/

> > commit 394216275c7d ("s390: remove broken hibernate / power management
> > support"), no need to keep unused code around.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!

As this is only a single patch, I think a pull request is a bit
overkill, so it would probably be best for someone to pick this
directly.

s390 arch maintainers? Michael?

> 
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 26 --------------------------
> >  1 file changed, 26 deletions(-)
> > 
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 957889a42d2e..5730572b52cd 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1372,27 +1372,6 @@ static struct ccw_device_id virtio_ids[] = {
> >  	{},
> >  };
> >  
> > -#ifdef CONFIG_PM_SLEEP
> > -static int virtio_ccw_freeze(struct ccw_device *cdev)
> > -{
> > -	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > -
> > -	return virtio_device_freeze(&vcdev->vdev);
> > -}
> > -
> > -static int virtio_ccw_restore(struct ccw_device *cdev)
> > -{
> > -	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > -	int ret;
> > -
> > -	ret = virtio_ccw_set_transport_rev(vcdev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return virtio_device_restore(&vcdev->vdev);
> > -}
> > -#endif
> > -
> >  static struct ccw_driver virtio_ccw_driver = {
> >  	.driver = {
> >  		.owner = THIS_MODULE,
> > @@ -1405,11 +1384,6 @@ static struct ccw_driver virtio_ccw_driver = {
> >  	.set_online = virtio_ccw_online,
> >  	.notify = virtio_ccw_cio_notify,
> >  	.int_class = IRQIO_VIR,
> > -#ifdef CONFIG_PM_SLEEP
> > -	.freeze = virtio_ccw_freeze,
> > -	.thaw = virtio_ccw_restore,
> > -	.restore = virtio_ccw_restore,
> > -#endif
> >  };
> >  
> >  static int __init pure_hex(char **cp, unsigned int *val, int min_digit,  
> 
