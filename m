Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 15 Apr 2019 18:45:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 0/3] fio-ccw fixes for kernel stacktraces
Message-ID: <20190415184515.570ed059.cohuck@redhat.com>
In-Reply-To: <cover.1554756534.git.alifm@linux.ibm.com>
References: <cover.1554756534.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 17:05:30 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> Hi,
> 
> I have recently seen some interesting kernel stacktraces while
> testing vfio-ccw mediated devices. These stack traces are seen
> when things don't go right, for example when a guest crashes or
> dies while still doing some I/O on the mediated device.
> 
> I have also come across an issue in the common vfio code as
> well which I reported upstream (https://marc.info/?l=kvm&m=155369393523503&w=2)
> and submitted a patch separately for it
> (https://marc.info/?l=kvm&m=155414703613868&w=2).
> 
> I would appreciate any review or feedback on these patches.
> 
> Thanks
> Farhan
> 
> ChangeLog
> ---------
> v1 -> v2
>    - Use the return code from cio_cancel_halt_clear to prevent
>      waiting unnecessarily (patch 2).
> 
>    - No need to reset the device on the remove path (patch 3).
> 
> Farhan Ali (3):
>   vfio-ccw: Do not call flush_workqueue while holding the spinlock
>   vfio-ccw: Prevent quiesce function going into an infinite loop
>   vfio-ccw: Release any channel program when releasing/removing vfio-ccw
>     mdev
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 27 ++++++++++++---------------
>  drivers/s390/cio/vfio_ccw_ops.c | 11 ++++++++++-
>  2 files changed, 22 insertions(+), 16 deletions(-)
> 

Thanks, queued patches 1 and 3.
