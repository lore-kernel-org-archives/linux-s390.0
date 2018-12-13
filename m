From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 13 Dec 2018 09:59:13 +0000
Subject: Re: [PULL 0/2] vfio-ccw changes for 4.21
Message-Id: <20181213105913.0aacaf99@mschwideX1>
In-Reply-To: <20181213085527.26540-1-cohuck@redhat.com>
References: <20181213085527.26540-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 13 Dec 2018 09:55:25 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 5b39fc049ce1232a56628408058ae04f353ac705:
> 
>   s390: use common bust_spinlocks() (2018-11-30 07:22:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20181213
> 
> for you to fetch changes up to 4868d2b662f55ff2e27e92c44b14016531a022a0:
> 
>   MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil Reviewer (2018-12-12 16:47:51 +0100)
> 
> ----------------------------------------------------------------
> vfio-ccw update:
> - remove unneeded BOXED state
> - maintainership changes
> 
> ----------------------------------------------------------------
> 
> Christian Borntraeger (1):
>   MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil Reviewer
> 
> Pierre Morel (1):
>   vfio: ccw: Merge BUSY and BOXED states
> 
>  MAINTAINERS                         | 4 +++-
>  drivers/s390/cio/vfio_ccw_fsm.c     | 7 +------
>  drivers/s390/cio/vfio_ccw_private.h | 1 -
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 

Pulled and push to s390/linux:features for the 4.21 merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
