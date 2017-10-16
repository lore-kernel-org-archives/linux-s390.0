From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC 07/19] KVM: s390: introduce AP matrix configuration
 interface
Date: Mon, 16 Oct 2017 11:10:30 +0200
Message-ID: <20171016111030.1a955866@mschwideX1>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:52 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> This patch introduces a new compilation unit that will contain
> all of the data structures and logic for configuring AP adapters,
> usage domains and control domains for a KVM guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                       |    2 ++
>  arch/s390/include/asm/ap-config.h |   12 ++++++++++++
>  arch/s390/kvm/Makefile            |    2 +-
>  arch/s390/kvm/ap-config.c         |    9 +++++++++
>  4 files changed, 24 insertions(+), 1 deletions(-)
>  create mode 100644 arch/s390/include/asm/ap-config.h
>  create mode 100644 arch/s390/kvm/ap-config.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c8855a..4de0904 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11721,6 +11721,8 @@ F:	drivers/s390/crypto/ap_matrix_bus.c
>  F:	drivers/s390/crypto/vfio_ap_matrix_drv.c
>  F:	drivers/s390/crypto/vfio_ap_matrix_private.h
>  F:	drivers/s390/crypto/vfio_ap_matrix_ops.c
> +F:	arch/s390/include/asm/kvm/ap-config.h
> +F:	arch/s390/kvm/ap-config.c
> 
>  S390 ZFCP DRIVER
>  M:	Steffen Maier <maier@linux.vnet.ibm.com>
> diff --git a/arch/s390/include/asm/ap-config.h b/arch/s390/include/asm/ap-config.h
> new file mode 100644
> index 0000000..8491b5f
> --- /dev/null
> +++ b/arch/s390/include/asm/ap-config.h
> @@ -0,0 +1,12 @@
> +/*
> + * Adjunct Processor (AP) configuration management for KVM guests
> + *
> + * Copyright IBM Corp. 2017
> + *
> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _ASM_KVM_AP_CONFIG_H_
> +#define _ASM_KVM_AP_CONFIG_H_
> +
> +#endif /* _ASM_KVM_AP_CONFIG_H_ */
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 09a9e6d..0397b9c 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -12,6 +12,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> 
>  kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
> -kvm-objs += diag.o gaccess.o guestdbg.o sthyi.o vsie.o
> +kvm-objs += diag.o gaccess.o guestdbg.o sthyi.o vsie.o ap-config.o
> 
>  obj-$(CONFIG_KVM) += kvm.o
> diff --git a/arch/s390/kvm/ap-config.c b/arch/s390/kvm/ap-config.c
> new file mode 100644
> index 0000000..84fdf43
> --- /dev/null
> +++ b/arch/s390/kvm/ap-config.c
> @@ -0,0 +1,9 @@
> +/*
> + * Adjunct Processor (AP) configuration management for KVM guests
> + *
> + * Copyright IBM Corp. 2017
> + *
> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> + */
> +
> +#include <asm/ap-config.h>

Another patch that introduces empty files. Please don't do that. Merge
patch #7 with patch #16. With the dependency in patch #8 on the ap-config.h
header the new place for the combined patch would be prior to patch #8.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
