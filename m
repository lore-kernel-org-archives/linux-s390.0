Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728199AbgLJMeo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 07:34:44 -0500
Date: Thu, 10 Dec 2020 13:33:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
Message-ID: <20201210133306.70d1a556.cohuck@redhat.com>
In-Reply-To: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  9 Dec 2020 15:27:46 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Today, ISM devices are completely disallowed for vfio-pci passthrough as
> QEMU will reject the device due to an (inappropriate) MSI-X check.
> However, in an effort to enable ISM device passthrough, I realized that the
> manner in which ISM performs block write operations is highly incompatible
> with the way that QEMU s390 PCI instruction interception and
> vfio_pci_bar_rw break up I/O operations into 8B and 4B operations -- ISM
> devices have particular requirements in regards to the alignment, size and
> order of writes performed.  Furthermore, they require that legacy/non-MIO
> s390 PCI instructions are used, which is also not guaranteed when the I/O
> is passed through the typical userspace channels.

The part about the non-MIO instructions confuses me. How can MIO
instructions be generated with the current code, and why does changing
the write pattern help?

> 
> As a result, this patchset proposes a new VFIO region to allow a guest to
> pass certain PCI instruction intercepts directly to the s390 host kernel
> PCI layer for exeuction, pinning the guest buffer in memory briefly in
> order to execute the requested PCI instruction.
> 
> Matthew Rosato (4):
>   s390/pci: track alignment/length strictness for zpci_dev
>   vfio-pci/zdev: Pass the relaxed alignment flag
>   s390/pci: Get hardware-reported max store block length
>   vfio-pci/zdev: Introduce the zPCI I/O vfio region
> 
>  arch/s390/include/asm/pci.h         |   4 +-
>  arch/s390/include/asm/pci_clp.h     |   7 +-
>  arch/s390/pci/pci_clp.c             |   2 +
>  drivers/vfio/pci/vfio_pci.c         |   8 ++
>  drivers/vfio/pci/vfio_pci_private.h |   6 ++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 160 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_zdev.h      |  33 ++++++++
>  8 files changed, 221 insertions(+), 3 deletions(-)
> 
