Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgJGTjw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 15:39:52 -0400
Date: Wed, 7 Oct 2020 13:39:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 0/5] Pass zPCI hardware information via VFIO
Message-ID: <20201007133944.52782a7e@w520.home>
In-Reply-To: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: cohuck@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  7 Oct 2020 14:56:19 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> This patchset provides a means by which hardware information about the
> underlying PCI device can be passed up to userspace (ie, QEMU) so that
> this hardware information can be used rather than previously hard-coded
> assumptions. The VFIO_DEVICE_GET_INFO ioctl is extended to allow capability
> chains and zPCI devices provide the hardware information via capabilities.
> 
> A form of these patches saw some rounds last year but has been back-
> tabled for a while.  The original work for this feature was done by Pierre
> Morel. I'd like to refresh the discussion on this and get this finished up
> so that we can move forward with better-supporting additional types of
> PCI-attached devices.  
> 
> This feature is toggled via the CONFIG_VFIO_PCI_ZDEV configuration entry. 
> 
> Changes since v2:
> - Added ACKs (thanks!)
> - Patch 3+4: Re-write to use VFIO_DEVICE_GET_INFO capabilities rather than
>   a vfio device region.

Looks good to me, I'll let Connie and others double check and throw in
their reviews, but I'll plan to include this for v5.10.  Thanks,

Alex
 
> Matthew Rosato (5):
>   s390/pci: stash version in the zpci_dev
>   s390/pci: track whether util_str is valid in the zpci_dev
>   vfio: Introduce capability definitions for VFIO_DEVICE_GET_INFO
>   vfio-pci/zdev: Add zPCI capabilities to VFIO_DEVICE_GET_INFO
>   MAINTAINERS: Add entry for s390 vfio-pci
> 
>  MAINTAINERS                         |   8 ++
>  arch/s390/include/asm/pci.h         |   4 +-
>  arch/s390/pci/pci_clp.c             |   2 +
>  drivers/vfio/pci/Kconfig            |  13 ++++
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/vfio_pci.c         |  37 ++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  12 +++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 143 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h           |  11 +++
>  include/uapi/linux/vfio_zdev.h      |  78 ++++++++++++++++++++
>  10 files changed, 308 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
>  create mode 100644 include/uapi/linux/vfio_zdev.h
> 
