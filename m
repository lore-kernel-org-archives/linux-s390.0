Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgJIJok (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 05:44:40 -0400
Date: Fri, 9 Oct 2020 11:44:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 4/5] vfio-pci/zdev: Add zPCI capabilities to
 VFIO_DEVICE_GET_INFO
Message-ID: <20201009114427.41f96cc6.cohuck@redhat.com>
In-Reply-To: <1602096984-13703-5-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
        <1602096984-13703-5-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  7 Oct 2020 14:56:23 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Define a new configuration entry VFIO_PCI_ZDEV for VFIO/PCI.
> 
> When this s390-only feature is configured we add capabilities to the
> VFIO_DEVICE_GET_INFO ioctl that describe features of the associated
> zPCI device and its underlying hardware.
> 
> This patch is based on work previously done by Pierre Morel.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig            |  13 ++++
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/vfio_pci.c         |  37 ++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  12 +++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 143 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 206 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c

With the compilation fix,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
