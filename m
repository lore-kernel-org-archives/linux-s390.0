Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgFQWbB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 18:31:01 -0400
Date: Thu, 18 Jun 2020 00:29:56 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200618002956.5f179de4.pasic@linux.ibm.com>
In-Reply-To: <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
        <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Wed, 17 Jun 2020 12:43:57 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture protecting the guest memory against unauthorized host
> access may want to enforce VIRTIO I/O device protection through the
> use of VIRTIO_F_IOMMU_PLATFORM.
> 
> Let's give a chance to the architecture to accept or not devices
> without VIRTIO_F_IOMMU_PLATFORM.
> 
[..]


I'm still not really satisfied with your commit message, furthermore
I did some thinking about the abstraction you introduce here. I will
give a short analysis of that, but first things first. Your patch does
the job of preventing calamity, and the details can be changed any time,
thus: 

Acked-by: Halil Pasic <pasic@linux.ibm.com>

Regarding the interaction of architecture specific code with virtio core,
I believe we could have made the interface more generic.

One option is to introduce virtio_arch_finalize_features(), a hook that
could reject any feature that is inappropriate.

Another option would be to find a common name for is_prot_virt_guest()
(arch/s390) sev_active() (arch/x86) and is_secure_guest() (arch/powerpc)
and use that instead of arch_needs_virtio_iommu_platform() and where-ever
appropriate. Currently we seem to want this info in driver code only for
virtio, but if the virtio driver has a legitimate need to know, other
drivers may as well have a legitimate need to know. For example if we
wanted to protect ourselves in ccw device drivers from somebody
setting up a vfio-ccw device and attach it to the prot-virt guest (AFAICT
we only lack guest enablement for this) such a function could be useful.

But since this can be rewritten any time, let's go with the option
people already agree with, instead of more discussion.

Just another question. Do we want this backported? Do we need cc stable?
[..]


>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> +	if (arch_needs_virtio_iommu_platform(dev) &&
> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");

I'm not sure, divulging the current Linux name of this feature bit is a
good idea, but if everybody else is fine with this, I don't care that
much. An alternative would be:
"virtio: device falsely claims to have full access to the memory,
aborting the device"


Regards,
Halil
