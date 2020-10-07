Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728864AbgJGVdD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 17:33:03 -0400
Date: Wed, 7 Oct 2020 15:32:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 4/5] vfio-pci/zdev: Add zPCI capabilities to
 VFIO_DEVICE_GET_INFO
Message-ID: <20201007153255.41d2a102@w520.home>
In-Reply-To: <1602096984-13703-5-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
        <1602096984-13703-5-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: cohuck@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  7 Oct 2020 14:56:23 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 61ca8ab..9d28484 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -213,4 +213,16 @@ static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  	return -ENODEV;
>  }
>  #endif
> +
> +#ifdef CONFIG_VFIO_PCI_ZDEV
> +extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
> +				       struct vfio_info_cap *caps);
> +#else
> +static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
> +					      struct vfio_info_cap *caps);

Ooops......................................................................^

Fixed.  Thanks,

Alex
