Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727087AbgHUMF1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Aug 2020 08:05:27 -0400
Date: Fri, 21 Aug 2020 14:05:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200821140510.3849410c.cohuck@redhat.com>
In-Reply-To: <1597854198-2871-3-git-send-email-pmorel@linux.ibm.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
        <1597854198-2871-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 19 Aug 2020 18:23:18 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> If protected virtualization is active on s390, VIRTIO has retricted

s/retricted/only restricted/

> access to the guest memory.
> Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
> arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
> the case, preventing a host error on access attempt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/Kconfig   |  1 +
>  arch/s390/mm/init.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)

(...)

> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 6dc7c3b60ef6..8febd73ed6ca 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -45,6 +45,7 @@
>  #include <asm/kasan.h>
>  #include <asm/dma-mapping.h>
>  #include <asm/uv.h>
> +#include <linux/virtio_config.h>

I don't think you need this include anymore.

>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  

(...)

With the nit fixed,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
