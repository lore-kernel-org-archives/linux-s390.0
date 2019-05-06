Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 6 May 2019 16:51:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/7] s390/cio: Set vfio-ccw FSM state before ioeventfd
Message-ID: <20190506165158.5da82576.cohuck@redhat.com>
In-Reply-To: <20190503134912.39756-3-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri,  3 May 2019 15:49:07 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Otherwise, the guest can believe it's okay to start another I/O
> and bump into the non-idle state.  This results in a cc=3
> (or cc=2 with the pending async CSCH/HSCH code [1]) to the guest,

I think you can now refer to cc=2, as the csch/hsch is on its way in :)

> which is unfortunate since everything is otherwise working normally.
> 
> [1] https://patchwork.kernel.org/comment/22588563/
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> 
> ---
> 
> I think this might've been part of Pierre's FSM cleanup?

Not sure if I saw this before, but there have been quite a number of
patches going around...

> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 0b3b9de45c60..ddd21b6149fd 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -86,11 +86,11 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>  	}
>  	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>  
> -	if (private->io_trigger)
> -		eventfd_signal(private->io_trigger, 1);
> -
>  	if (private->mdev && is_final)
>  		private->state = VFIO_CCW_STATE_IDLE;
> +
> +	if (private->io_trigger)
> +		eventfd_signal(private->io_trigger, 1);
>  }
>  
>  /*
