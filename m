From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 05/26] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Date: Thu, 20 Sep 2018 17:50:41 +0200
Message-ID: <20180920175041.57ad867e.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Sep 2018 15:42:55 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Registers the matrix device created by the VFIO AP device
> driver with the VFIO mediated device framework.
> Registering the matrix device will create the sysfs
> structures needed to create mediated matrix devices
> each of which will be used to configure the AP matrix
> for a guest and connect it to the VFIO AP device driver.
> 
> Registering the matrix device with the VFIO mediated device
> framework will create the following sysfs structures:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ create
> 
> To create a mediated device for the AP matrix device, write a UUID
> to the create file:
> 
> 	uuidgen > create
> 
> A symbolic link to the mediated device's directory will be created in the
> devices subdirectory named after the generated $uuid:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ............... [$uuid]
> 
> A symbolic link to the mediated device will also be created
> in the vfio_ap matrix's directory:
> 
> /sys/devices/vfio_ap/matrix/[$uuid]
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS                           |    1 +
>  drivers/s390/crypto/Makefile          |    2 +-
>  drivers/s390/crypto/vfio_ap_drv.c     |   19 +++++
>  drivers/s390/crypto/vfio_ap_ops.c     |  126 +++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |   49 +++++++++++++
>  include/uapi/linux/vfio.h             |    1 +
>  6 files changed, 197 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/s390/crypto/vfio_ap_ops.c

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 3e635f0..75f8bdc 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -76,6 +76,16 @@ static int vfio_ap_matrix_dev_create(void)
>  		goto matrix_alloc_err;
>  	}
>  
> +	/* Test if PQAP(QCI) instruction is available */

/* Fill in config info via PQAP(QCI), if available */

?

> +	if (test_facility(12)) {
> +		ret = ap_qci(&matrix_dev->info);
> +		if (ret)
> +			goto matrix_alloc_err;
> +	}
> +
> +	mutex_init(&matrix_dev->lock);
> +	INIT_LIST_HEAD(&matrix_dev->mdev_list);
> +
>  	matrix_dev->device.type = &vfio_ap_dev_type;
>  	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>  	matrix_dev->device.parent = root_device;

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 6141420..a2eab78 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -3,6 +3,7 @@
>   * Private data and functions for adjunct processor VFIO matrix driver.
>   *
>   * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Halil Pasic <pasic@linux.ibm.com>
>   *
>   * Copyright IBM Corp. 2018
>   */
> @@ -24,11 +25,59 @@
>  /**
>   * ap_matrix_dev - the AP matrix device structure
>   * @device:	generic device structure associated with the AP matrix device
> + * @available_instances: number of mediated matrix devices that can be created
> + * @info:	the struct containing the output from the PQAP(TAPQ) instruction

Hm, isn't that rather PQAP(QCI)?

> + * mdev_list:	the list of mediated matrix devices created
> + * lock:	mutex for locking the AP matrix device. This lock will be
> + *		taken every time we fiddle with state managed by the vfio_ap
> + *		driver, be it using @mdev_list or writing the state of a
> + *		single ap_matrix_mdev device. It's quite coarse but we don't
> + *		expect much contention.
>   */
>  struct ap_matrix_dev {
>  	struct device device;
> +	atomic_t available_instances;
> +	struct ap_config_info info;
> +	struct list_head mdev_list;
> +	struct mutex lock;
>  };

Otherwise:
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
