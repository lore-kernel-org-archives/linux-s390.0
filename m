Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 6 Aug 2020 17:47:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device
 protection
Message-ID: <20200806174744.595b9c8c.cohuck@redhat.com>
In-Reply-To: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

On Thu,  6 Aug 2020 16:23:01 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> In another series I proposed to add an architecture specific
> callback to fail feature negociation on architecture need.
> 
> In VIRTIO, we already have an entry to reject the features on the
> transport basis.
> 
> Transport is not architecture so I send a separate series in which
> we fail the feature negociation inside virtio_ccw_finalize_features,
> the virtio_config_ops.finalize_features for S390 CCW transport,
> when the device do not propose the VIRTIO_F_IOMMU_PLATFORM.
> 
> This solves the problem of crashing QEMU when this one is not using
> a CCW device with iommu_platform=on in S390.

This does work, and I'm tempted to queue this patch, but I'm wondering
whether we need to give up on a cross-architecture solution already
(especially keeping in mind that ccw is the only transport that is
really architecture-specific).

I know that we've gone through a few rounds already, and I'm not sure
whether we've been there already, but:

Could virtio_finalize_features() call an optional
arch_has_restricted_memory_access() function and do the enforcing of
IOMMU_PLATFORM? That would catch all transports, and things should work
once an architecture opts in. That direction also shouldn't be a
problem if virtio is a module.

> 
> Regards,
> Pierre
> 
> Regards,
> Pierre
> 
> Pierre Morel (1):
>   s390: virtio-ccw: PV needs VIRTIO I/O device protection
> 
>  drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
