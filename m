Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 21 Feb 2019 16:09:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190221160910.5bf34f04.cohuck@redhat.com>
In-Reply-To: <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
References: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
        <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Feb 2019 15:14:54 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a matrix bus and with it the matrix
> bus subsytem. Also make the matrix device reside within the matrix
> bus.
> 
> Doing this we remove the forced link from the matrix device to the
> vfio_ap driver and the device_type we do not need anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> 
> Cc: stable@vger.kernel.org
> 

I'd kill the two empty lines.

> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
>  drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
>  drivers/s390/crypto/vfio_ap_private.h |  1 +
>  3 files changed, 38 insertions(+), 11 deletions(-)

Otherwise, still looks good.
