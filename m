Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgKXKB3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 05:01:29 -0500
Date: Tue, 24 Nov 2020 11:00:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 0/2] Connect request callback to mdev and vfio-ccw
Message-ID: <20201124110057.78092517.cohuck@redhat.com>
In-Reply-To: <20201120180740.87837-1-farman@linux.ibm.com>
References: <20201120180740.87837-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 20 Nov 2020 19:07:38 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> There is a situation where removing all the paths from a device
> connected via mdev and vfio-ccw can cause some difficulty.
> Using the "chchp -c 0 xx" command to all paths will cause the
> device to be removed from the configuration, and any guest
> filesystem that is relying on that device will encounter errors.
> Interestingly, the last chchp command will actually fail to
> return to a shell prompt, and subsequent commands (another
> chchp to bring the paths back online, chzdev, etc.) will also
> hang because of the outstanding chchp.
> 
> The last chchp command drives to vfio_ccw_sch_remove() for every
> affected mediated device, and ultimately enters an infinite loop
> in vfio_del_group_dev(). This loop is broken when the guest goes
> away, which in this case doesn't occur until the guest is shutdown.
> This drives vfio_ccw_mdev_release() and thus vfio_device_release()
> to wake up the vfio_del_group_dev() thread.
> 
> There is also a callback mechanism called "request" to ask a
> driver (and perhaps user) to release the device, but this is not
> implemented for mdev. So this adds one to that point, and then
> wire it to vfio-ccw to pass it along to userspace. This will
> gracefully drive the unplug code, and everything behaves nicely.
> 
> Despite the testing that was occurring, this doesn't appear related
> to the vfio-ccw channel path handling code. I can reproduce this with
> an older kernel/QEMU, which makes sense because the above behavior is
> driven from the subchannel event codepaths and not the chpid events.
> Because of that, I didn't flag anything with a Fixes tag, since it's
> seemingly been this way forever.

Both patches look good to me.

Which would be the best way to merge this? Via vfio or via vfio-ccw?

> 
> RFC->V2:
>  - Patch 1
>    - Added a message when registering a device without a request callback
>    - Changed the "if(!callback) return" to "if(callback) do" layout
>    - Removed "unlikely" from "if(callback)" logic
>    - Clarified some wording in the device ops struct commentary
>  - Patch 2
>    - Added Conny's r-b
> 
> Eric Farman (2):
>   vfio-mdev: Wire in a request handler for mdev parent
>   vfio-ccw: Wire in the request callback
> 
>  drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>  drivers/vfio/mdev/mdev_core.c       |  4 ++++
>  drivers/vfio/mdev/vfio_mdev.c       | 10 ++++++++++
>  include/linux/mdev.h                |  4 ++++
>  include/uapi/linux/vfio.h           |  1 +
>  6 files changed, 49 insertions(+)
> 
