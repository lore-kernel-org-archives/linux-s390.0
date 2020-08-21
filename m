Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Aug 2020 13:59:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 1/2] virtio: let arch advertise guest's memory access
 restrictions
Message-ID: <20200821135906.1c6bede3.cohuck@redhat.com>
In-Reply-To: <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
        <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 19 Aug 2020 18:23:17 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may restrict host access to guest memory.

"e.g. IBM s390 Secure Execution or AMD SEV"

Just to make clearer what you are referring to?

> 
> Provide a new Kconfig entry the architecture can select,
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
> the arch_has_restricted_virtio_memory_access callback to advertise

s/advertise/advertise to/

> VIRTIO common code when the architecture restricts memory access
> from the host.

"The common code can then fail the probe for any device where
VIRTIO_F_IOMMU_PLATFORM is required, but not set."

?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       | 15 +++++++++++++++
>  include/linux/virtio_config.h |  9 +++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..509f3b4d8ba1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected by any architecture enforcing
> +	  VIRTIO_F_IOMMU_PLATFORM

"This option is selected if the architecture may need to enforce
VIRTIO_F_IOMMU_PLATFORM."

?

> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
