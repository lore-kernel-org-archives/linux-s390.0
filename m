Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43151 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440804AbgJ0NCJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Oct 2020 09:02:09 -0400
Date: Tue, 27 Oct 2020 14:01:57 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 04/14] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20201027140157.0b510450.pasic@linux.ibm.com>
In-Reply-To: <20201022171209.19494-5-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-5-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 22 Oct 2020 13:11:59 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Introduces a new driver callback to prevent a root user from unbinding
> an AP queue from its device driver if the queue is in use. The callback
> will be invoked whenever a change to the AP bus's sysfs apmask or aqmask
> attributes would result in one or more AP queues being removed from its
> driver. If the callback responds in the affirmative for any driver
> queried, the change to the apmask or aqmask will be rejected with a device
> in use error.

Like discussed last time, there seems to be nothing, that would prevent
a resource becoming in use between the in_use() callback returned false
and the resource being removed as a result of ap_bus_revise_bindings().

Another thing that may be of interest, is that now we hold the
ap_perms_mutex for the in_use() checks. The ap_perms_mutex is used
in ap_device_probe() and I don't quite understand some
usages of in zcrypt_api.c My feeling is that the extra pressure on that
lock should not be a problem, except if in_use() were to not return
because of some deadlock.

With all that said if Harald is fine with it, so am I.

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> 
> For this patch, only non-default drivers will be queried. Currently,
> there is only one non-default driver, the vfio_ap device driver. The
> vfio_ap device driver facilitates pass-through of an AP queue to a
> guest. The idea here is that a guest may be administered by a different
> sysadmin than the host and we don't want AP resources to unexpectedly
> disappear from a guest's AP configuration (i.e., adapters and domains
> assigned to the matrix mdev). This will enforce the proper procedure for
> removing AP resources intended for guest usage which is to
> first unassign them from the matrix mdev, then unbind them from the
> vfio_ap device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>
