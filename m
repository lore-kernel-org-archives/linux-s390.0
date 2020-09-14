Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Sep 2020 17:31:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 05/16] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
Message-ID: <20200914173149.70fa59d9.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-6-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-6-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:05 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Let's implement the callback to indicate when an APQN
> is in use by the vfio_ap device driver. The callback is
> invoked whenever a change to the apmask or aqmask would
> result in one or more queue devices being removed from the driver. The
> vfio_ap device driver will indicate a resource is in use
> if the APQN of any of the queue devices to be removed are assigned to
> any of the matrix mdevs under the driver's control.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>  drivers/s390/crypto/vfio_ap_ops.c     | 68 ++++++++++++++++++++-------
>  drivers/s390/crypto/vfio_ap_private.h |  2 +
>  3 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 24cdef60039a..aae5b3d8e3fa 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -175,6 +175,7 @@ static int __init vfio_ap_init(void)
>  	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
>  	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
>  	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
> +	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
>  	vfio_ap_drv.ids = ap_queue_ids;
>  
>  	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 2e37ee82e422..fc1aa6f947eb 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -515,18 +515,36 @@ vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
>  	return 0;
>  }
>  
> +#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
> +			 "already assigned to %s"

Ah, I spoke too soon; this is what I had been looking for :)
