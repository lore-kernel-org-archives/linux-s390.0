Return-Path: <SRS0=OpZk=S2=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 24 Apr 2019 18:35:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
Message-ID: <20190424183512.0d384ee2.cohuck@redhat.com>
In-Reply-To: <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Apr 2019 17:23:14 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> The quiesce function calls cio_cancel_halt_clear() and if we
> get an -EBUSY we go into a loop where we:
> 	- wait for any interrupts
> 	- flush all I/O in the workqueue
> 	- retry cio_cancel_halt_clear
> 
> During the period where we are waiting for interrupts or
> flushing all I/O, the channel subsystem could have completed
> a halt/clear action and turned off the corresponding activity
> control bits in the subchannel status word. This means the next
> time we call cio_cancel_halt_clear(), we will again start by
> calling cancel subchannel and so we can be stuck between calling
> cancel and halt forever.
> 
> Rather than calling cio_cancel_halt_clear() immediately after
> waiting, let's try to disable the subchannel. If we succeed in
> disabling the subchannel then we know nothing else can happen
> with the device.
> 
> Suggested-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
> ChangeLog:
> v2 -> v3
>    - Log an error message when cio_cancel_halt_clear
>      returns EIO and break out of the loop.
>    
>    - Did not include past change log as the other patches
>      of the original series have been queued by Conny.
>      Old series (v2) can be found here:
>      https://marc.info/?l=kvm&m=155475754101769&w=2
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Thanks, applied.
