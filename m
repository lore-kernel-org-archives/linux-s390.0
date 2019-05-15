Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 2/7] s390/cio: Set vfio-ccw FSM state before ioeventfd
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-3-farman@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 15 May 2019 10:36:24 -0400
MIME-Version: 1.0
In-Reply-To: <20190514234248.36203-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0b35722f-1f02-7369-cdd1-b7470144aea4@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/14/2019 07:42 PM, Eric Farman wrote:
> Otherwise, the guest can believe it's okay to start another I/O
> and bump into the non-idle state.  This results in a cc=2 (with
> the asynchronous CSCH/HSCH code) returned to the guest, which is
> unfortunate since everything is otherwise working normally.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 0b3b9de45c60..ddd21b6149fd 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -86,11 +86,11 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>   	}
>   	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>   
> -	if (private->io_trigger)
> -		eventfd_signal(private->io_trigger, 1);
> -
>   	if (private->mdev && is_final)
>   		private->state = VFIO_CCW_STATE_IDLE;
> +
> +	if (private->io_trigger)
> +		eventfd_signal(private->io_trigger, 1);
>   }
>   
>   /*
> 
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
