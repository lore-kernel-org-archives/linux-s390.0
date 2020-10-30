Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Oct 2020 18:27:55 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20201030182755.433e3e2d.pasic@linux.ibm.com>
In-Reply-To: <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-2-akrowiak@linux.ibm.com>
        <20201027074846.30ee0ddc.pasic@linux.ibm.com>
        <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 29 Oct 2020 19:29:35 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 10/27/20 2:48 AM, Halil Pasic wrote:
> > On Thu, 22 Oct 2020 13:11:56 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> The queues assigned to a matrix mediated device are currently reset when:
> >>
> >> * The VFIO_DEVICE_RESET ioctl is invoked
> >> * The mdev fd is closed by userspace (QEMU)
> >> * The mdev is removed from sysfs.  
> > What about the situation when vfio_ap_mdev_group_notifier() is called to
> > tell us that our pointer to KVM is about to become invalid? Do we need to
> > clean up the IRQ stuff there?  
> 
> After reading this question, I decided to do some tracing using
> printk's and learned that the vfio_ap_mdev_group_notifier()
> function does not get called when the guest is shutdown. The reason
> for this is because the vfio_ap_mdev_release() function, which is called
> before the KVM pointer is invalidated, unregisters the group notifier.
> 
> I took a look at some of the other drivers that register a group
> notifier in the mdev_parent_ops.open callback and each unregistered
> the notifier in the mdev_parent_ops.release callback.
> 
> So, to answer your question, there is no need to cleanup the IRQ
> stuff in the vfio_ap_mdev_group_notifier() function since it will
> not get called when the KVM pointer is invalidated. The cleanup
> should be done in the vfio_ap_mdev_release() function that gets
> called when the mdev fd is closed.

You say if vfio_ap_mdev_group_notifier() is called to tell us
that KVM going away, then it is a bug?

If that is the case, I would like that reflected in the code! By that I
mean at logging an error at least (if not BUG_ON).

Regards,
Halil
