Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgJBUS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 16:18:29 -0400
Subject: Re: [PATCH v2 0/5] Pass zPCI hardware information via VFIO
From: Matthew Rosato <mjrosato@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
Message-ID: <28d77f9a-0f73-82a8-7dc8-61451f13f375@linux.ibm.com>
Date: Fri, 2 Oct 2020 16:18:22 -0400
MIME-Version: 1.0
In-Reply-To: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/2/20 4:00 PM, Matthew Rosato wrote:
> This patchset provides a means by which hardware information about the
> underlying PCI device can be passed up to userspace (ie, QEMU) so that
> this hardware information can be used rather than previously hard-coded
> assumptions. A new VFIO region type is defined which holds this
> information.
> 
> A form of these patches saw some rounds last year but has been back-
> tabled for a while.  The original work for this feature was done by Pierre
> Morel. I'd like to refresh the discussion on this and get this finished up
> so that we can move forward with better-supporting additional types of
> PCI-attached devices.  The proposal here presents a completely different
> region mapping vs the prior approach, taking inspiration from vfio info
> capability chains to provide device CLP information in a way that allows
> for future expansion (new CLP features).
> 
> This feature is toggled via the CONFIG_VFIO_PCI_ZDEV configuration entry.
> 
> Changes from v1:
> - Added ACKs (thanks!)
> - Patch 2: Minor change:s/util_avail/util_str_avail/ per Niklas
> - Patch 3: removed __packed
> - Patch 3: rework various descriptions / comment blocks
> - New patch: MAINTAINERS hit to cover new files.
> 

Link to latest QEMU patchset:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00673.html

> Matthew Rosato (5):
>    s390/pci: stash version in the zpci_dev
>    s390/pci: track whether util_str is valid in the zpci_dev
>    vfio-pci/zdev: define the vfio_zdev header
>    vfio-pci/zdev: use a device region to retrieve zPCI information
>    MAINTAINERS: Add entry for s390 vfio-pci
> 
>   MAINTAINERS                         |   8 ++
>   arch/s390/include/asm/pci.h         |   4 +-
>   arch/s390/pci/pci_clp.c             |   2 +
>   drivers/vfio/pci/Kconfig            |  13 ++
>   drivers/vfio/pci/Makefile           |   1 +
>   drivers/vfio/pci/vfio_pci.c         |   8 ++
>   drivers/vfio/pci/vfio_pci_private.h |  10 ++
>   drivers/vfio/pci/vfio_pci_zdev.c    | 242 ++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/vfio.h           |   5 +
>   include/uapi/linux/vfio_zdev.h      | 118 ++++++++++++++++++
>   10 files changed, 410 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
>   create mode 100644 include/uapi/linux/vfio_zdev.h
> 
