Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 19 Feb 2019 10:22:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190219102204.5e050b76.cohuck@redhat.com>
In-Reply-To: <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
        <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
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

s/suppress/remove/ ?

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

(...)

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

I don't think you need this (the important function is the match
function of the bus).

> +
> +static struct device_driver matrix_driver = {
> +	.name = "vfio_ap",
> +	.bus = &matrix_bus,
> +	.probe = matrix_probe,
> +};
> +
>  static int vfio_ap_matrix_dev_create(void)
>  {
>  	int ret;

It's a bit annoying that we need to introduce a bus that basically does
nothing, but I think this looks sane.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
