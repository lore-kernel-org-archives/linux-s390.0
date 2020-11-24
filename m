Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731321AbgKXJ5V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:21 -0500
Date: Tue, 24 Nov 2020 10:57:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
Message-ID: <20201124105707.7f5802eb.cohuck@redhat.com>
In-Reply-To: <20201120180740.87837-2-farman@linux.ibm.com>
References: <20201120180740.87837-1-farman@linux.ibm.com>
        <20201120180740.87837-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 20 Nov 2020 19:07:39 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> While performing some destructive tests with vfio-ccw, where the
> paths to a device are forcible removed and thus the device itself
> is unreachable, it is rather easy to end up in an endless loop in
> vfio_del_group_dev() due to the lack of a request callback for the
> associated device.
> 
> In this example, one MDEV (77c) is used by a guest, while another
> (77b) is not. The symptom is that the iommu is detached from the
> mdev for 77b, but not 77c, until that guest is shutdown:
> 
>     [  238.794867] vfio_ccw 0.0.077b: MDEV: Unregistering
>     [  238.794996] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: Removing from iommu group 2
>     [  238.795001] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: MDEV: detaching iommu
>     [  238.795036] vfio_ccw 0.0.077c: MDEV: Unregistering
>     ...silence...
> 
> Let's wire in the request call back to the mdev device, so that a
> device being physically removed from the host can be (gracefully?)
> handled by the parent device at the time the device is removed.
> 
> Add a message when registering the device if a driver doesn't
> provide this callback, so a clue is given that this same loop
> may be encountered in a similar situation.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/vfio/mdev/mdev_core.c |  4 ++++
>  drivers/vfio/mdev/vfio_mdev.c | 10 ++++++++++
>  include/linux/mdev.h          |  4 ++++
>  3 files changed, 18 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
