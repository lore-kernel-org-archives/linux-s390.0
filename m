Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Aug 2020 19:22:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200818192233.6c80798e.cohuck@redhat.com>
In-Reply-To: <1597762711-3550-3-git-send-email-pmorel@linux.ibm.com>
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
        <1597762711-3550-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 18 Aug 2020 16:58:31 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated.
> Define CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS and export
> arch_has_restricted_memory_access to fail probe if that's
> not the case, preventing a host error on access attempt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/Kconfig   |  1 +
>  arch/s390/mm/init.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9cfd8de907cb..d4a3ef4fa27b 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -820,6 +820,7 @@ menu "Virtualization"
>  config PROTECTED_VIRTUALIZATION_GUEST
>  	def_bool n
>  	prompt "Protected virtualization guest support"
> +	select ARCH_HAS_RESTRICTED_MEMORY_ACCESS
>  	help
>  	  Select this option, if you want to be able to run this
>  	  kernel as a protected virtualization KVM guest.
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 6dc7c3b60ef6..aec04d7dd089 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -45,6 +45,7 @@
>  #include <asm/kasan.h>
>  #include <asm/dma-mapping.h>
>  #include <asm/uv.h>
> +#include <linux/virtio_config.h>
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  
> @@ -161,6 +162,35 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> +/*
> + * arch_has_restricted_memory_access
> + * @dev: the VIRTIO device being added
> + *
> + * Return an error if required features are missing on a guest running
> + * with protected virtualization.
> + */
> +int arch_has_restricted_memory_access(struct virtio_device *dev)
> +{
> +	if (!is_prot_virt_guest())
> +		return 0;

If you just did a

return is_prot_virt_guest();

and did the virtio feature stuff in the virtio core, this function
would be short and sweet :)

> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(arch_has_restricted_memory_access);
> +#endif
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
