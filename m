Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
 <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <5d048eb9-72e5-e713-5c1a-56a1c3d957c4@linux.ibm.com>
Date: Thu, 21 Jan 2021 11:01:37 +0100
MIME-Version: 1.0
In-Reply-To: <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com, cohuck@redhat.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/19/21 9:02 PM, Matthew Rosato wrote:
> Some s390 PCI devices (e.g. ISM) perform I/O operations that have very
> specific requirements in terms of alignment as well as the patterns in
> which the data is read/written. Allowing these to proceed through the
> typical vfio_pci_bar_rw path will cause them to be broken in up in such a
> way that these requirements can't be guaranteed. In addition, ISM devices
> do not support the MIO codepaths that might be triggered on vfio I/O coming
> from userspace; we must be able to ensure that these devices use the
> non-MIO instructions.  To facilitate this, provide a new vfio region by
> which non-MIO instructions can be passed directly to the host kernel s390
> PCI layer, to be reliably issued as non-MIO instructions.
> 
> This patch introduces the new vfio VFIO_REGION_SUBTYPE_IBM_ZPCI_IO region
> and implements the ability to pass PCISTB and PCILG instructions over it,
> as these are what is required for ISM devices.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |   8 ++
>  drivers/vfio/pci/vfio_pci_private.h |   6 ++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 158 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_zdev.h      |  33 ++++++++
>  5 files changed, 209 insertions(+)

Related to the discussion on the QEMU side, if we have a check
to make sure this is only used for ISM, then this patch should
make that clear in its wording and also in the paths
(drivers/vfio/pci/vfio_pci_ism.c instead of vfio_pci_zdev.c.)
This also has precedent with the region for IGD in
drivers/vfio/pci/vfio_pci_igd.c.
