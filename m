Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbgGNL4J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 07:56:09 -0400
Date: Tue, 14 Jul 2020 13:55:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200714135555.2148fb83.cohuck@redhat.com>
In-Reply-To: <1594726682-12076-3-git-send-email-pmorel@linux.ibm.com>
References: <1594726682-12076-1-git-send-email-pmorel@linux.ibm.com>
        <1594726682-12076-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 14 Jul 2020 13:38:02 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated. Use the new arch_validate_virtio_features() interface to
> fail probe if that's not the case, preventing a host error on access
> attempt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/mm/init.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

(...)

> +int arch_validate_virtio_features(struct virtio_device *dev)
> +{
> +	if (!is_prot_virt_guest())
> +		return 0;
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +		dev_warn(&dev->dev,
> +			 "legacy virtio not supported with protected virtualizatio\n");

typo: s/virtualizatio/virtualization/

> +		return -ENODEV;
> +	}
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "support for limited memory access required for protected virtualization\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
