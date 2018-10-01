From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 01 Oct 2018 14:12:03 +0000
Subject: Re: [PULL 0/2] vfio-ccw: fixes
Message-Id: <20181001161203.0d9d2ff2@mschwideX1>
In-Reply-To: <20181001115358.5513-1-cohuck@redhat.com>
References: <20181001115358.5513-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  1 Oct 2018 13:53:56 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 55a5542a546238354d1f209f794414168cf8c71d:
> 
>   s390/hibernate: fix error handling when suspend cpu != resume cpu (2018-09-20 13:20:23 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20181001
> 
> for you to fetch changes up to bf42daed6bd136774415ae6d26c8475152f92b54:
> 
>   s390/cio: Refactor alloc of ccw_io_region (2018-09-27 16:33:01 +0200)
> 
> ----------------------------------------------------------------
> Change allocation of ccw_io_region so that the usercopy hardening
> code can figure out that everything is fine.
> 
> ----------------------------------------------------------------
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

Pulled & pushed to linux-s390:fixes. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
