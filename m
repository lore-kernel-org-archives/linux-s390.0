Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 19:55:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization
 support to cio
Message-ID: <20190409195548.6dea6e40.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-6-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-6-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:15 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Virtio-ccw relies on cio mechanisms for bootstrapping the ccw device.

Well, a ccw device is, by definition, using cio mechanisms ;)

Better say: "As virtio-ccw devices are channel devices, we need to use
the dma area for any communication with the hypervisor."
Or something like that.

> Thus we need to make sure any memory that is used for communication with
> the hypervisor is shared.

In this context, does 'hypervisor' always mean 'QEMU/KVM'? If Other
Hypervisors implement protected virtualization, we probably need to
make sure that all common I/O layer control blocks are in the dma area
(including e.g. QDIO), not just what virtio-ccw devices use.

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/cio/ccwreq.c        |  8 +++----
>  drivers/s390/cio/device.c        | 46 +++++++++++++++++++++++++++++++---------
>  drivers/s390/cio/device_fsm.c    | 40 +++++++++++++++++-----------------
>  drivers/s390/cio/device_id.c     | 18 ++++++++--------
>  drivers/s390/cio/device_ops.c    |  4 ++--
>  drivers/s390/cio/device_pgid.c   | 20 ++++++++---------
>  drivers/s390/cio/device_status.c | 24 ++++++++++-----------
>  drivers/s390/cio/io_sch.h        | 19 ++++++++++++-----
>  8 files changed, 107 insertions(+), 72 deletions(-)
> 

(...)

(just looking at which fields are moved for now)

> diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
> index 90e4e3a7841b..fc3220fede0f 100644
> --- a/drivers/s390/cio/io_sch.h
> +++ b/drivers/s390/cio/io_sch.h
> @@ -9,15 +9,20 @@
>  #include "css.h"
>  #include "orb.h"
>  
> +
> +struct io_subchannel_dma_area {
> +	struct ccw1 sense_ccw;	/* static ccw for sense command */

The ccw makes sense.

> +};
> +
>  struct io_subchannel_private {
>  	union orb orb;		/* operation request block */
> -	struct ccw1 sense_ccw;	/* static ccw for sense command */
>  	struct ccw_device *cdev;/* pointer to the child ccw device */
>  	struct {
>  		unsigned int suspend:1;	/* allow suspend */
>  		unsigned int prefetch:1;/* deny prefetch */
>  		unsigned int inter:1;	/* suppress intermediate interrupts */
>  	} __packed options;
> +	struct io_subchannel_dma_area *dma_area;
>  } __aligned(8);
>  
>  #define to_io_private(n) ((struct io_subchannel_private *) \
> @@ -115,6 +120,13 @@ enum cdev_todo {
>  #define FAKE_CMD_IRB	1
>  #define FAKE_TM_IRB	2
>  
> +struct ccw_device_dma_area {
> +	struct senseid senseid;	/* SenseID info */
> +	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
> +	struct irb irb;		/* device status */
> +	struct pgid pgid[8];	/* path group IDs per chpid*/

Again, ccws, and blocks that will be written by the hypervisor, which
makes sense as well.

> +};
> +
>  struct ccw_device_private {
>  	struct ccw_device *cdev;
>  	struct subchannel *sch;
> @@ -156,11 +168,7 @@ struct ccw_device_private {
>  	} __attribute__((packed)) flags;
>  	unsigned long intparm;	/* user interruption parameter */
>  	struct qdio_irq *qdio_data;
> -	struct irb irb;		/* device status */
>  	int async_kill_io_rc;
> -	struct senseid senseid;	/* SenseID info */
> -	struct pgid pgid[8];	/* path group IDs per chpid*/
> -	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
>  	struct work_struct todo_work;
>  	enum cdev_todo todo;
>  	wait_queue_head_t wait_q;
> @@ -169,6 +177,7 @@ struct ccw_device_private {
>  	struct list_head cmb_list;	/* list of measured devices */
>  	u64 cmb_start_time;		/* clock value of cmb reset */
>  	void *cmb_wait;			/* deferred cmb enable/disable */
> +	struct ccw_device_dma_area *dma_area;
>  	enum interruption_class int_class;
>  };
>  

So, this leaves some things I'm not sure about, especially as I do not
know the architecture of this new feature.

- This applies only to asynchronously handled things, it seems? So
  things like control blocks modified by stsch/msch/etc does not need
  special treatment?
- What about channel measurements? Or are they not supported?
- What about CHSCs? Or would only asynchronous commands (which we
  currently don't implement in QEMU) need special treatment?
