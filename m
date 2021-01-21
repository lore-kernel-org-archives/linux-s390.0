Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbhAUUvy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 15:51:54 -0500
Date: Thu, 21 Jan 2021 13:50:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
Message-ID: <20210121135021.0eb7e873@omen.home.shazbot.org>
In-Reply-To: <90d99da8-02cf-e051-314b-2ab192f8fd57@linux.ibm.com>
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
        <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
        <90d99da8-02cf-e051-314b-2ab192f8fd57@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, cohuck@redhat.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 14:21:59 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On 1/19/21 9:02 PM, Matthew Rosato wrote:
> > Some s390 PCI devices (e.g. ISM) perform I/O operations that have very  
> .. snip ...
> > +
> > +static size_t vfio_pci_zdev_io_rw(struct vfio_pci_device *vdev,
> > +				  char __user *buf, size_t count,
> > +				  loff_t *ppos, bool iswrite)
> > +{  
> ... snip ...
> > +	/*
> > +	 * For now, the largest allowed block I/O is advertised as PAGE_SIZE,
> > +	 * and cannot exceed a page boundary - so a single page is enough.  The
> > +	 * guest should have validated this but let's double-check that the
> > +	 * request will not cross a page boundary.
> > +	 */
> > +	if (((region->req.gaddr & ~PAGE_MASK)
> > +			+ region->req.len - 1) & PAGE_MASK) {
> > +		return -EIO;
> > +	}
> > +
> > +	mutex_lock(&zdev->lock);  
> 
> I plan on using the zdev->lock for preventing concurrent zPCI devices
> removal/configuration state changes between zPCI availability/error
> events and enable_slot()/disable_slot() and /sys/bus/pci/devices/<dev>/recover.
> 
> With that use in place using it here causes a deadlock when doing 
> "echo 0 > /sys/bus/pci/slots/<fid>/power from the host for an ISM device
> attached to a guest.
> 
> This is because the (soft) hot unplug will cause vfio to notify QEMU, which
> sends a deconfiguration request to the guest, which then tries to
> gracefully shutdown the device. During that shutdown the device will
> be accessed, running into this code path which then blocks on
> the lock held by the disable_slot() code which waits on vfio
> releasing the device.
> 
> Alex may correct me if I'm wrong but I think instead vfio should
> be holding the PCI device lock via pci_device_lock(pdev).

There be dragons in device_lock, which is why we have all the crude
try-lock semantics in reset paths.  Don't use it trivially.  Device
lock is not necessary here otherwise, the device is bound to a driver
and has an open userspace file descriptor through which the user is
performing this access.  The device can't be removed without unbinding
the driver, which can't happen while the user still has open files to
it.  Thanks,

Alex
