From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
Date: Mon, 16 Apr 2018 17:59:36 +0200
Message-ID: <83bd1b8f-f3c0-328f-4b3d-6972d82b3662@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/04/2018 23:22, Tony Krowiak wrote:
> If the AP instructions are not available on the linux host, then
> AP devices can not be interpreted by the SIE. The AP bus has a
> function it uses to determine if the AP instructions are
> available. This patch provides a new function that wraps the
> AP bus's function to externalize it for use by KVM.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
> ---
>   arch/s390/include/asm/ap.h     |    7 +++++++
>   arch/s390/include/asm/kvm-ap.h |   23 +++++++++++++++++++++++
>   arch/s390/kvm/Makefile         |    2 +-
>   arch/s390/kvm/kvm-ap.c         |   21 +++++++++++++++++++++
>   drivers/s390/crypto/ap_bus.c   |    6 ++++++
>   5 files changed, 58 insertions(+), 1 deletions(-)
>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>   create mode 100644 arch/s390/kvm/kvm-ap.c
>
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c1bedb4..7773bfd 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -120,4 +120,11 @@ struct ap_queue_status ap_queue_irq_ctrl(ap_qid_t qid,
>   					 struct ap_qirq_ctrl qirqctrl,
>   					 void *ind);
>
> +/**
> + * ap_instructions_installed() - Tests whether AP instructions are installed
> + *
> + * Returns 1 if the AP instructions are installed, otherwise; returns 0
> + */
> +int ap_instructions_installed(void);
> +
>   #endif /* _ASM_S390_AP_H_ */
> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
> new file mode 100644
> index 0000000..84412a9
> --- /dev/null
> +++ b/arch/s390/include/asm/kvm-ap.h
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct Processor (AP) configuration management for KVM guests
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _ASM_KVM_AP
> +#define _ASM_KVM_AP
> +
> +/**
> + * kvm_ap_instructions_installed()
> + *
> + * Tests whether AP instructions are installed on the linux host
> + *
> + * Returns 1 if the AP instructions are installed on the host, otherwise;
> + * returns 0
> + */
> +int kvm_ap_instructions_installed(void);
> +
> +#endif /* _ASM_KVM_AP */
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 05ee90a..1876bfe 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -9,6 +9,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
>   ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>
>   kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
> -kvm-objs += diag.o gaccess.o guestdbg.o vsie.o
> +kvm-objs += diag.o gaccess.o guestdbg.o vsie.o kvm-ap.o
>
>   obj-$(CONFIG_KVM) += kvm.o
> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> new file mode 100644
> index 0000000..1267588
> --- /dev/null
> +++ b/arch/s390/kvm/kvm-ap.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct Processor (AP) configuration management for KVM guests
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> + */
> +#include <linux/kernel.h>
> +#include <asm/kvm-ap.h>
> +#include <asm/ap.h>
> +
> +int kvm_ap_instructions_installed(void)
> +{
> +#ifdef CONFIG_ZCRYPT

if you do this take care that ZCRYPT may be a module ;)

> +	return ap_instructions_installed();
> +#else
> +	return 0;
> +#endif
> +}
> +EXPORT_SYMBOL(kvm_ap_instructions_installed);
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 35a0c2b..9d108b6 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -210,6 +210,12 @@ int ap_query_configuration(struct ap_config_info *info)
>   }
>   EXPORT_SYMBOL(ap_query_configuration);
>
> +int ap_instructions_installed(void)
> +{
> +	return (ap_instructions_available() == 0);
> +}
> +EXPORT_SYMBOL(ap_instructions_installed);
> +
>   /**
>    * ap_init_configuration(): Allocate and query configuration array.
>    */


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
