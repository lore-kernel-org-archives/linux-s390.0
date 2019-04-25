Return-Path: <SRS0=V8Ip=S3=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 25 Apr 2019 13:47:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PULL 0/9] vfio-ccw patches for 5.2
In-Reply-To: <20190425091559.15490-1-cohuck@redhat.com>
References: <20190425091559.15490-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190425134751.086dc37b@mschwideX1>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Apr 2019 11:15:50 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 1c410fd6a561af452aba282b1cd3cabef2080d72:
> 
>   s390/cpum_cf_diag: Add support for CPU-MF SVN 6 (2019-04-23 16:30:06 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190425
> 
> for you to fetch changes up to d1ffa760d22aa1d8190478e5ef555c59a771db27:
> 
>   vfio-ccw: Prevent quiesce function going into an infinite loop (2019-04-24 14:18:51 +0200)
> 
> ----------------------------------------------------------------
> - support for sending halt/clear requests to the device
> - various bug fixes
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (6):
>   vfio-ccw: make it safe to access channel programs
>   vfio-ccw: rework ssch state handling
>   vfio-ccw: protect the I/O region
>   vfio-ccw: add capabilities chain
>   s390/cio: export hsch to modules
>   vfio-ccw: add handling for async channel instructions
> 
> Farhan Ali (3):
>   vfio-ccw: Do not call flush_workqueue while holding the spinlock
>   vfio-ccw: Release any channel program when releasing/removing vfio-ccw
>     mdev
>   vfio-ccw: Prevent quiesce function going into an infinite loop
> 
>  drivers/s390/cio/Makefile           |   3 +-
>  drivers/s390/cio/ioasm.c            |   1 +
>  drivers/s390/cio/vfio_ccw_async.c   |  88 +++++++++++
>  drivers/s390/cio/vfio_ccw_cp.c      |  21 ++-
>  drivers/s390/cio/vfio_ccw_cp.h      |   2 +
>  drivers/s390/cio/vfio_ccw_drv.c     |  81 ++++++----
>  drivers/s390/cio/vfio_ccw_fsm.c     | 143 +++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 227 ++++++++++++++++++++++++----
>  drivers/s390/cio/vfio_ccw_private.h |  48 +++++-
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_ccw.h       |  12 ++
>  11 files changed, 560 insertions(+), 70 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 

Pulled and push to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
