Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/1] vfio-ccw: fence off transport mode
References: <20180222153959.31272-1-cohuck@redhat.com>
 <20180222153959.31272-2-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 15:51:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180222153959.31272-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <95c1554e-ada3-f6db-62aa-f04e42a0ae09@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/22/2018 04:39 PM, Cornelia Huck wrote:
> vfio-ccw only supports command mode for channel programs, not transport
> mode. User space is supposed to already take care of that and pass us
> command-mode ORBs only, but better make sure and return an error to
> the caller instead of trying to process tcws as ccws.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index c30420c517b1..ff6963ad6e39 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -124,6 +124,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>  		orb = (union orb *)io_region->orb_area;
> 
> +		/* Don't try to build a cp if transport mode is specified. */
> +		if (orb->tm.b) {
> +			io_region->ret_code = -EOPNOTSUPP;

I guess now we communicate this as appropriately as possible.

> +			goto err_out;
> +		}
>  		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
>  					      orb);
>  		if (io_region->ret_code)
> 
