Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 19 Feb 2019 18:45:43 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
In-Reply-To: <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
        <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190219184543.25391a2b@oc2783563651>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 18 Feb 2019 19:08:48 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> bus subsytem, and make the matrix device reside within it.
> 
> Doing this we need to suppress the forced link from the matrix device to
> the vfio_ap driver and we suppress the device_type we do not need
> anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 48 +++++++++++++++++++++++++++++------
>  drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>  drivers/s390/crypto/vfio_ap_private.h |  1 +
>  3 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 31c6c84..8e45559 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
>  
>  static struct ap_driver vfio_ap_drv;
>  
> -static struct device_type vfio_ap_dev_type = {
> -	.name = VFIO_AP_DEV_TYPE_NAME,
> -};
> -

Would have been nice had you mentioned this in the commit message --
vfio_ap_dev_type was useless. And you should have removed
the define of VFIO_AP_DEV_TYPE_NAME a couple of lines above this.

>  struct ap_matrix_dev *matrix_dev;
>  
>  /* Only type 10 adapters (CEX4 and later) are supported
> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>  	kfree(matrix_dev);
>  }
>  
> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	return 1;
> +}
> +
> +static struct bus_type matrix_bus = {
> +	.name = "vfio_ap",
> +	.match = &matrix_bus_match,
> +};
> +
> +static int matrix_probe(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static struct device_driver matrix_driver = {
> +	.name = "vfio_ap",
> +	.bus = &matrix_bus,
> +	.probe = matrix_probe,
> +};
> +

With the changes suggested by Christian:

Acked-by: Halil Pasic <pasic@linux.ibm.com>

[..]
