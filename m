From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 08 Oct 2018 07:20:20 +0000
Subject: Re: [PULL 0/1] vfio-ccw: another bugfix
Message-Id: <20181008092020.0b86f3b2@mschwideX1>
In-Reply-To: <20181002153748.13503-1-cohuck@redhat.com>
References: <20181002153748.13503-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue,  2 Oct 2018 17:37:47 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> [Sorry about that; I don't plan to make this a daily thing...]
> 
> The following changes since commit c458dda3d07c110ce1d007998f67273325ad8662:
> 
>   Merge tag 'vfio-ccw-20181001' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes (2018-10-01 16:07:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20181002
> 
> for you to fetch changes up to 24abf2901b18bf941b9f21ea2ce5791f61097ae4:
> 
>   s390/cio: Fix how vfio-ccw checks pinned pages (2018-10-02 09:45:05 +0200)
> 
> ----------------------------------------------------------------
> Another fix for vfio-ccw: make sure it accesses the correct entries
> in the pfn_array_table arrays when checking pinned pages.
> 
> ----------------------------------------------------------------
> 
> Eric Farman (1):
>   s390/cio: Fix how vfio-ccw checks pinned pages
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pulled and push to linux-s390:fixes. I'll wait for a couple of days
before I send a please pull to Greg with the fixes.

Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
