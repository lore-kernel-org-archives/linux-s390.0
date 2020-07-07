Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727886AbgGGLPA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:15:00 -0400
Received: by mail-wr1-f69.google.com with SMTP id d11so30858681wrw.12
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2020 04:14:56 -0700 (PDT)
Date: Tue, 7 Jul 2020 07:14:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200707060838-mutt-send-email-mst@kernel.org>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
 <20200707114633.68122a00.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114633.68122a00.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Tue, Jul 07, 2020 at 11:46:33AM +0200, Cornelia Huck wrote:
> On Tue,  7 Jul 2020 10:44:37 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > S390, protecting the guest memory against unauthorized host access
> > needs to enforce VIRTIO I/O device protection through the use of
> > VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.
> 
> Hm... what about:
> 
> "If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated. Use the new arch_validate_virtio_features() interface to
> enforce this."

s/enforce this/fail probe if that's not the case, preventing a host error on access attempt/



> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index c296e5c8dbf9..106330f6eda1 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/swap.h>
> > +#include <linux/virtio_config.h>
> >  #include <asm/facility.h>
> >  #include <asm/sections.h>
> >  #include <asm/uv.h>
> > @@ -413,3 +414,27 @@ static int __init uv_info_init(void)
> >  }
> >  device_initcall(uv_info_init);
> >  #endif
> > +
> > +/*
> > + * arch_validate_virtio_iommu_platform
> 
> s/arch_validate_virtio_iommu_platform/arch_validate_virtio_features/
> 
> > + * @dev: the VIRTIO device being added
> > + *
> > + * Return value: returns -ENODEV if any features of the
> > + *               device breaks the protected virtualization
> > + *               0 otherwise.
> 
> I don't think you need to specify the contract here: that belongs to
> the definition in the virtio core. What about simply adding a sentence
> "Return an error if required features are missing on a guest running
> with protected virtualization." ?
> 
> > + */
> > +int arch_validate_virtio_features(struct virtio_device *dev)
> > +{
> 
> Maybe jump out immediately if the guest is not protected?
> 
> > +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> > +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> > +
> > +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +		dev_warn(&dev->dev,
> > +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> 
> if (!is_prot_virt_guest())
> 	return 0;
> 
> if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> 	dev_warn(&dev->dev,
>                  "legacy virtio is incompatible with protected guests");
> 	return -ENODEV;
> }
> 
> if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> 	dev_warn(&dev->dev,
> 		 "device does not work with limited memory access in protected guests");
> 	return -ENODEV;
> }
> 
> > +
> > +	return 0;
> > +}
