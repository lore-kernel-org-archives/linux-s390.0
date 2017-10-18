From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 04/19] s390/zcrypt: create an AP matrix device on the AP
 matrix bus
Date: Wed, 18 Oct 2017 18:20:45 +0200
Message-ID: <20171018182045.292bc5fd.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:49 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

[Please take with a grain of salt as I did not yet have time to take
more than a very superficial glance at the whole structure.]

> Creates a single AP matrix device on the AP matrix bus.
> The matrix device will be created as part of the AP matrix bus
> initialization. The matrix device will hold the AP queues that
> have been reserved for use by KVM guests. Mediated matrix devices
> can then be created for each guest. The mediated matrix devices can
> then be configured with a matrix of AP adapters, usage and
> control domains that will be made accessible to the guest.
> 
> The sysfs location of the matrix device is:
> 
> /sys/bus/ap_matrix
> ... [devices]
> ...... [matrix]

Also /sys/devices/ap_matrix/matrix, isn't it?

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  drivers/s390/crypto/ap_matrix_bus.c |   54 +++++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/ap_matrix_bus.h |    6 ++++
>  2 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
> index fbae175..4eb1e3c 100644
> --- a/drivers/s390/crypto/ap_matrix_bus.c
> +++ b/drivers/s390/crypto/ap_matrix_bus.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/slab.h>
>  #include <asm/ap.h>
>  
>  #include "ap_matrix_bus.h"
> @@ -21,13 +22,59 @@
>  MODULE_LICENSE("GPL v2");
>  
>  #define AP_MATRIX_BUS_NAME "ap_matrix"
> +#define AP_MATRIX_DEV_TYPE_NAME "ap_matrix"
> +#define AP_MATRIX_DEV_NAME "matrix"
>  
>  static struct device *ap_matrix_root_device;
> +static struct ap_matrix *matrix;
>  
>  static struct bus_type ap_matrix_bus_type = {
>  	.name = AP_MATRIX_BUS_NAME,
>  };
>  
> +static struct device_type ap_matrix_type = {
> +	.name = AP_MATRIX_DEV_TYPE_NAME,
> +};
> +
> +static void ap_matrix_dev_release(struct device *dev)
> +{
> +	struct ap_matrix *ap_matrix;
> +
> +	ap_matrix = container_of(dev, struct ap_matrix, device);
> +
> +	if (matrix == ap_matrix)
> +		kfree(matrix);
> +
> +	matrix = NULL;

This looks very, very odd. Refcounting should take care that the
release function is only invoked if the device is really gone.

Also, I don't think you need to keep a pointer to the device as it is a
singleton: It's simply the only device on the list and you should be
able to easily pick it that way. If your code does not register further
devices on the bus, there won't be ambiguities.

> +}
> +
> +static int ap_matrix_dev_create(void)
> +{
> +	int ret;
> +
> +	matrix = kzalloc(sizeof(*matrix), GFP_KERNEL);
> +	if (!matrix)
> +		return -ENOMEM;
> +
> +	matrix->device.type = &ap_matrix_type;
> +	dev_set_name(&matrix->device, "%s", AP_MATRIX_DEV_NAME);
> +	matrix->device.bus = &ap_matrix_bus_type;
> +	matrix->device.parent = ap_matrix_root_device;
> +	matrix->device.release = ap_matrix_dev_release;
> +
> +	ret = device_register(&matrix->device);
> +	if (ret) {
> +		put_device(&matrix->device);
> +		kfree(matrix);
> +		matrix = NULL;

That's wrong. The release function needs to clean up the embedding
structure, so that kfree is at best useless and at worst wrong, if
something else grabbed a reference.

> +		return ret;
> +	}
> +
> +	get_device(&matrix->device);

Why should you need an extra reference here? I'd expect the code
hanging devices off this one to properly grab a reference, so you
should be all good?

> +
> +	return 0;
> +}
> +
>  int __init ap_matrix_init(void)
>  {
>  	int ret;
> @@ -41,8 +88,15 @@ int __init ap_matrix_init(void)
>  	if (ret)
>  		goto bus_reg_err;
>  
> +	ret = ap_matrix_dev_create();
> +	if (ret)
> +		goto matrix_create_err;
> +
>  	return 0;
>  
> +matrix_create_err:
> +	bus_unregister(&ap_matrix_bus_type);
> +
>  bus_reg_err:
>  	root_device_unregister(ap_matrix_root_device);
