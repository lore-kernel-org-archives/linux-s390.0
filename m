Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387628AbgLCXtl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 18:49:41 -0500
Date: Thu, 3 Dec 2020 16:48:07 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 0/2] Connect request callback to mdev and vfio-ccw
Message-ID: <20201203164807.5a87776f@w520.home>
In-Reply-To: <20201203213512.49357-1-farman@linux.ibm.com>
References: <20201203213512.49357-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  3 Dec 2020 22:35:10 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Alex,
> 
> As promised, here is a v3 with a message indicating a request is blocked
> until a user releases the device in question and a corresponding tweak to
> the commit message describing this change (and Conny's r-b). The remainder
> of the patches are otherwise identical.
> 
> v2      : https://lore.kernel.org/kvm/20201120180740.87837-1-farman@linux.ibm.com/
> v1(RFC) : https://lore.kernel.org/kvm/20201117032139.50988-1-farman@linux.ibm.com/
> 
> Eric Farman (2):
>   vfio-mdev: Wire in a request handler for mdev parent
>   vfio-ccw: Wire in the request callback
> 
>  drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>  drivers/vfio/mdev/mdev_core.c       |  4 ++++
>  drivers/vfio/mdev/vfio_mdev.c       | 13 +++++++++++++
>  include/linux/mdev.h                |  4 ++++
>  include/uapi/linux/vfio.h           |  1 +
>  6 files changed, 52 insertions(+)
> 

Thanks!  Applied to vfio next branch for v5.11.

Alex
