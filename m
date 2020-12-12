Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392765AbgLLKtd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Dec 2020 05:49:33 -0500
Date: Sat, 12 Dec 2020 09:20:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] s390/vfio-ap: No need to disable IRQ after queue
 reset
Message-ID: <X9R9TucfKMUpw9Px@kroah.com>
References: <20201211222211.20869-1-akrowiak@linux.ibm.com>
 <20201211222211.20869-2-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211222211.20869-2-akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, sashal@kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com

On Fri, Dec 11, 2020 at 05:22:10PM -0500, Tony Krowiak wrote:
> The queues assigned to a matrix mediated device are currently reset when:
> 
> * The VFIO_DEVICE_RESET ioctl is invoked
> * The mdev fd is closed by userspace (QEMU)
> * The mdev is removed from sysfs.
> 
> Immediately after the reset of a queue, a call is made to disable
> interrupts for the queue. This is entirely unnecessary because the reset of
> a queue disables interrupts, so this will be removed.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |  1 -
>  drivers/s390/crypto/vfio_ap_ops.c     | 40 +++++++++++++++++----------
>  drivers/s390/crypto/vfio_ap_private.h |  1 -
>  3 files changed, 26 insertions(+), 16 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
