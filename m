Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26280 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgIJJKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 05:10:04 -0400
Subject: Re: [PATCH v12 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
 <1599728030-17085-3-git-send-email-pmorel@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <696a5887-e0d9-dc03-6204-e0f6464f3929@de.ibm.com>
Date: Thu, 10 Sep 2020 11:09:51 +0200
MIME-Version: 1.0
In-Reply-To: <1599728030-17085-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10.09.20 10:53, Pierre Morel wrote:
> If protected virtualization is active on s390, VIRTIO has only retricted
> access to the guest memory.
> Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
> arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
> the case.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Michael, I am fine if this patch goes via the virtio tree.


> ---
>  arch/s390/Kconfig   |  1 +
>  arch/s390/mm/init.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index b29fcc66ec39..938246200d39 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -820,6 +820,7 @@ menu "Virtualization"
>  config PROTECTED_VIRTUALIZATION_GUEST
>  	def_bool n
>  	prompt "Protected virtualization guest support"
> +	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	help
>  	  Select this option, if you want to be able to run this
>  	  kernel as a protected virtualization KVM guest.
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 0d282081dc1f..e27f050cb516 100644
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
> @@ -160,6 +161,16 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +
> +int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return is_prot_virt_guest();
> +}
> +EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
> +
> +#endif
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
> 
