Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgJGTSa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 15:18:30 -0400
Subject: Re: [PATCH v3 0/5] Pass zPCI hardware information via VFIO
From: Matthew Rosato <mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
Message-ID: <7bff9eac-2704-438a-89e8-f2f4cca60757@linux.ibm.com>
Date: Wed, 7 Oct 2020 15:18:23 -0400
MIME-Version: 1.0
In-Reply-To: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/7/20 2:56 PM, Matthew Rosato wrote:
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
>    a vfio device region.

Link to latest QEMU patch set:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01948.html

> 
> Matthew Rosato (5):
>    s390/pci: stash version in the zpci_dev
>    s390/pci: track whether util_str is valid in the zpci_dev
>    vfio: Introduce capability definitions for VFIO_DEVICE_GET_INFO
>    vfio-pci/zdev: Add zPCI capabilities to VFIO_DEVICE_GET_INFO
>    MAINTAINERS: Add entry for s390 vfio-pci
> 
>   MAINTAINERS                         |   8 ++
>   arch/s390/include/asm/pci.h         |   4 +-
>   arch/s390/pci/pci_clp.c             |   2 +
>   drivers/vfio/pci/Kconfig            |  13 ++++
>   drivers/vfio/pci/Makefile           |   1 +
>   drivers/vfio/pci/vfio_pci.c         |  37 ++++++++++
>   drivers/vfio/pci/vfio_pci_private.h |  12 +++
>   drivers/vfio/pci/vfio_pci_zdev.c    | 143 ++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/vfio.h           |  11 +++
>   include/uapi/linux/vfio_zdev.h      |  78 ++++++++++++++++++++
>   10 files changed, 308 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
>   create mode 100644 include/uapi/linux/vfio_zdev.h
> 
