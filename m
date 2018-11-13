From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 13 Nov 2018 15:06:02 +0000
Subject: Re: [PULL 0/4] vfio-ccw fixes for 4.20
Message-Id: <20181113160602.7a1d8ee0@mschwideX1>
In-Reply-To: <20181113124755.4798-1-cohuck@redhat.com>
References: <20181113124755.4798-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 13 Nov 2018 13:47:51 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> 
>   Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20181113
> 
> for you to fetch changes up to b89e242eee8d4cd8261d8d821c62c5d1efc454d0:
> 
>   s390/cio: Fix cleanup when unsupported IDA format is used (2018-11-13 11:45:17 +0100)
> 
> ----------------------------------------------------------------
> several bugfixes for vfio-ccw
> 
> ----------------------------------------------------------------
> 
> Eric Farman (2):
>   s390/cio: Fix cleanup of pfn_array alloc failure
>   s390/cio: Fix cleanup when unsupported IDA format is used
> 
> Pierre Morel (1):
>   vfio: ccw: Register mediated device once all structures are
>     initialized
> 
> Sebastian Ott (1):
>   s390/cio: make vfio_ccw_io_region static
> 
>  drivers/s390/cio/vfio_ccw_cp.c  |  6 ++++--
>  drivers/s390/cio/vfio_ccw_drv.c | 10 +++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 

Pulled and push to s390/linux:fixes. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
