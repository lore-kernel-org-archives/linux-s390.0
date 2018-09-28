From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Sep 2018 08:30:50 +0000
Subject: Re: [PATCH v2 0/2] Refactor ccw_io_region
Message-Id: <20180928103050.6593f8f7.cohuck@redhat.com>
In-Reply-To: <20180924111446.4fcdf27d.cohuck@redhat.com>
References: <20180924111446.4fcdf27d.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Sep 2018 22:40:11 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Cornelia, I think you were thinking something like this?
> 
> Patch one does the refactoring to use ccw_io_region as a pointer
> rather than a struct embedded in vfio_ccw_private, while patch two
> is almost identical to the initial patch that I sent.
> 
> Obviously I had to remove references to the vfio_ccw_private struct
> since ccw_io_region is a pointer, but the concept is the same.
> 
> Eric Farman (2):
>   s390/cio: Convert ccw_io_region to pointer
>   s390/cio: Refactor alloc of ccw_io_region
> 
>  drivers/s390/cio/vfio_ccw_drv.c     | 24 +++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_fsm.c     |  6 +++---
>  drivers/s390/cio/vfio_ccw_ops.c     |  4 ++--
>  drivers/s390/cio/vfio_ccw_private.h |  2 +-
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 

Thanks, applied.
