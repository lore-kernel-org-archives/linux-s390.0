Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730008AbfJHKsQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Oct 2019 06:48:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x98AkWkP005822
        for <linux-s390@vger.kernel.org>; Tue, 8 Oct 2019 06:48:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgnkwqyfw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 08 Oct 2019 06:48:15 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 8 Oct 2019 11:48:13 +0100
Date: Tue, 8 Oct 2019 12:48:07 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 00/10] s390: vfio-ap: dynamic configuration support
In-Reply-To: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20191008124807.49022238.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com

On Fri, 13 Sep 2019 17:26:48 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current design for AP pass-through does not support making dynamic
> changes to the AP matrix of a running guest resulting in three deficiencies
> this patch series is intended to mitigate:
> 
> 1. Adapters, domains and control domains can not be added to or removed
>    from a running guest. In order to modify a guest's AP configuration,
>    the guest must be terminated; only then can AP resources be assigned
>    to or unassigned from the guest's matrix mdev. The new AP configuration
>    becomes available to the guest when it is subsequently restarted.
> 
> 2. The AP bus's /sys/bus/ap/apmask and /sys/bus/ap/aqmask interfaces can
>    be modified by a root user without any restrictions. A change to either
>    mask can result in AP queue devices being unbound from the vfio_ap
>    device driver and bound to a zcrypt device driver even if a guest is
>    using the queues, thus giving the host access to the guest's private
>    crypto data and vice versa.
> 
> 3. The APQNs derived from the Cartesian product of the APIDs of the
>    adapters and APQIs of the domains assigned to a matrix mdev must
>    reference an AP queue device bound to the vfio_ap device driver. 
> 
> This patch series introduces the following changes to the current design
> to alleviate the shortcomings described above as well as to implement more
> of the AP architecture:
> 
> 1. A root user will be prevented from making changes to the AP bus's
>    /sys/bus/ap/apmask or /sys/bus/ap/aqmask if the ownership of an APQN
>    changes from the vfio_ap device driver to a zcrypt driver when the APQN
>    is assigned to a matrix mdev.
> 
> 2. The sysfs bind/unbind interfaces will be disabled for the vfio_ap
>    device driver.
> 

Doesn't this have the potential of breaking some userspace stuff that
might be out there?

> 3. Allow AP resources to be assigned to or removed from a matrix mdev
>    while a guest is using it and hot plug the resource into or hot unplug
>    the resource from the running guest.

This looks like a natural extension of the interface -- i.e. should not
break any userspace.

> 
> 4. Allow assignment of an AP adapter or domain to a matrix mdev even if it
>    results in assignment of an APQN that does not reference an AP queue
>    device bound to the vfio_ap device driver, as long as the APQN is owned
>    by the vfio_ap driver. Allowing over-provisioning of AP resources
>    better models the architecture which does not preclude assigning AP
>    resources that are not yet available in the system. If/when the queue
>    becomes available to the host, it will immediately also become available
>    to the guest.

Same here -- I don't think this change breaks any userspace.

> 
> 1. Rationale for changes to AP bus's apmask/aqmask interfaces:
> ----------------------------------------------------------
> Due to the extremely sensitive nature of cryptographic data, it is
> imperative that great care be taken to ensure that such data is secured.
> Allowing a root user, either inadvertently or maliciously, to configure
> these masks such that a queue is shared between the host and a guest is
> not only avoidable, it is advisable. It was suggested that this scenario
> is better handled in user space with management software, but that does
> not preclude a malicious administrator from using the sysfs interfaces
> to gain access to a guest's crypto data. It was also suggested that this
> scenario could be avoided by taking access to the adapter away from the
> guest and zeroing out the queues prior to the vfio_ap driver releasing the
> device; however, stealing an adapter in use from a guest as a by-product
> of an operation is bad and will likely cause problems for the guest
> unnecessarily. It was decided that the most effective solution with the
> least number of negative side effects is to prevent the situation at the
> source.
> 
> 2. Rationale for disabling bind/unbind interfaces for vfio_ap driver:
> -----------------------------------------------------------------
> By disabling the bind/unbind interfaces for the vfio_ap device driver, 
> the user is forced to use the AP bus's apmask/aqmask interfaces to control
> the probing and removing of AP queues. There are two primary reasons for
> disabling the bind/unbind interfaces for the vfio_ap device driver:
> 
> * The device architecture does not provide a means to prevent unbinding
>   a device from a device driver, so an AP queue device can be unbound
>   from the vfio_ap driver even when the queue is in use by a guest. By
>   disabling the unbind interface, the user is forced to use the AP bus's
>   apmask/aqmask interfaces which will prevent this.
> 

Isn't this fixed by your filtering (if implemented correctly)? BTW I believe
it solves the problem regardless whether the unbind was triggered by the
drivers unbind attribute or by a[pq]mask.

> * Binding of AP queues is controlled by the AP bus /sys/bus/ap/apmask and
>   /sys/bus/ap/aqmask interfaces. If the masks indicate that an APQN is
>   owned by zcrypt, trying to bind it to the vfio_ap device driver will
>   fail; therefore, the bind interface is somewhat redundant and certainly
>   unnecessary.        
>   

[..]

> Tony Krowiak (10):
>   s390: vfio-ap: Refactor vfio_ap driver probe and remove callbacks
>   s390: vfio-ap: allow assignment of unavailable AP resources to mdev
>     device
>   s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
>   s390: vfio-ap: filter CRYCB bits for unavailable queue devices
>   s390: vfio-ap: sysfs attribute to display the guest CRYCB
>   s390: vfio-ap: update guest CRYCB in vfio_ap probe and remove
>     callbacks
>   s390: zcrypt: driver callback to indicate resource in use
>   s390: vfio-ap: implement in-use callback for vfio_ap driver
>   s390: vfio-ap: added versioning to vfio_ap module
>   s390: vfio-ap: update documentation

I believe it would be worthwhile to reorder the patches (fixes and
re-factoring first, the features).

Regards,
Halil

> 
>  Documentation/s390/vfio-ap.rst        | 899 +++++++++++++++++++++++++---------
>  drivers/s390/crypto/ap_bus.c          | 144 +++++-
>  drivers/s390/crypto/ap_bus.h          |   4 +
>  drivers/s390/crypto/vfio_ap_drv.c     |  27 +-
>  drivers/s390/crypto/vfio_ap_ops.c     | 610 ++++++++++++++---------
>  drivers/s390/crypto/vfio_ap_private.h |  12 +-
>  6 files changed, 1200 insertions(+), 496 deletions(-)
> 
