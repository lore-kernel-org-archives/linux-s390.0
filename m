From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC 03/19] s390/zcrypt: new AP matrix bus
Date: Mon, 16 Oct 2017 10:47:23 +0200
Message-ID: <20171016104723.71b683c3@mschwideX1>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:48 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces an AP matrix bus. The sysfs location of the
> AP matrix bus is:
> 
> /sys/bus/ap_matrix
> 
> The AP matrix bus will create an AP matrix device that will
> hold the AP queues reserved for use by KVM guests.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                         |    8 +++++
>  drivers/s390/crypto/Makefile        |    4 +-
>  drivers/s390/crypto/ap_matrix_bus.c |   52 +++++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/ap_matrix_bus.h |   15 ++++++++++
>  4 files changed, 77 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/s390/crypto/ap_matrix_bus.c
>  create mode 100644 drivers/s390/crypto/ap_matrix_bus.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef23cf5..cbd6f7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11711,6 +11711,14 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>  S:	Supported
>  F:	drivers/s390/crypto/
> 
> +S390 VFIO AP MATRIX DRIVER
> +M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +W:	http://www.ibm.com/developerworks/linux/linux390/
> +S:	Supported
> +F:	drivers/s390/crypto/ap_matrix_bus.h
> +F:	drivers/s390/crypto/ap_matrix_bus.c
> +
>  S390 ZFCP DRIVER
>  M:	Steffen Maier <maier@linux.vnet.ibm.com>
>  M:	Benjamin Block <bblock@linux.vnet.ibm.com>
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index be36f10..87646ca 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -2,7 +2,7 @@
>  # S/390 crypto devices
>  #
> 
> -ap-objs := ap_bus.o ap_card.o ap_queue.o
> +ap-objs := ap_bus.o ap_card.o ap_queue.o ap_matrix_bus.o
>  obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
>  # zcrypt_api.o and zcrypt_msgtype*.o depend on ap.o
>  zcrypt-objs := zcrypt_api.o zcrypt_card.o zcrypt_queue.o
> @@ -13,4 +13,4 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
> 
>  # pkey kernel module
>  pkey-objs := pkey_api.o
> -obj-$(CONFIG_PKEY) += pkey.o
> +obj-$(CONFIG_PKEY) += pkey.o
> \ No newline at end of file

Try to avoid this newline hunk please. It is removed again with patch #5.

> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
> new file mode 100644
> index 0000000..fbae175
> --- /dev/null
> +++ b/drivers/s390/crypto/ap_matrix_bus.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright IBM Corp. 2017
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * Adjunct processor matrix bus.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <asm/ap.h>
> +
> +#include "ap_matrix_bus.h"
> +
> +MODULE_AUTHOR("Tony Krowiak <akrowiak@linux.vnet.ibm.com");
> +MODULE_DESCRIPTION("AP Matrix, Copyright IBM Corp. 2017");
> +MODULE_LICENSE("GPL v2");
> +
> +#define AP_MATRIX_BUS_NAME "ap_matrix"
> +
> +static struct device *ap_matrix_root_device;
> +
> +static struct bus_type ap_matrix_bus_type = {
> +	.name = AP_MATRIX_BUS_NAME,
> +};
> +
> +int __init ap_matrix_init(void)
> +{
> +	int ret;
> +
> +	ap_matrix_root_device = root_device_register(AP_MATRIX_BUS_NAME);
> +	ret = PTR_RET(ap_matrix_root_device);
> +	if (ret)
> +		goto done;
> +
> +	ret = bus_register(&ap_matrix_bus_type);
> +	if (ret)
> +		goto bus_reg_err;
> +
> +	return 0;
> +
> +bus_reg_err:
> +	root_device_unregister(ap_matrix_root_device);
> +
> +done:
> +	return ret;
> +}
> +device_initcall(ap_matrix_init);
> diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
> new file mode 100644
> index 0000000..58e116f
> --- /dev/null
> +++ b/drivers/s390/crypto/ap_matrix_bus.h
> @@ -0,0 +1,15 @@
> +/*
> + * Adjunct processor matrix bus header file
> + *
> + * Copyright IBM Corp. 2017
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * Adjunct processor bus header file.
> + */
> +
> +#ifndef _AP_MATRIX_BUS_H_
> +#define _AP_MATRIX_BUS_H_
> +
> +int ap_matrix_init(void);
> +
> +#endif /* _AP_MATRIX_BUS_H_ */

While I understand the approach to split the patches into meaningful
parts, there is always a balance between too coarse and too fine granular.

I would merge patch #3, patch #4 and parts of patch #5 that affect
ap_matrix_bus.c & ap_matrix_bus.h.


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
