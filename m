From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 27 Feb 2019 12:22:06 +0000
Subject: Re: [PULL 0/2] vfio-ccw: further patches for 5.1
Message-Id: <20190227132206.71623e28@mschwideX1>
In-Reply-To: <20190227105710.20030-1-cohuck@redhat.com>
References: <20190227105710.20030-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Feb 2019 11:57:08 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 36360658eb5a6cf04bb9f2704d1e4ce54037ec99:
> 
>   s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem (2019-02-22 09:20:01 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190227
> 
> for you to fetch changes up to 2904337fd981217784c2820abdee537aa0c70330:
> 
>   s390/cio: Use cpa range elsewhere within vfio-ccw (2019-02-26 18:30:13 +0100)
> 
> ----------------------------------------------------------------
> Further fixes in TIC handling.
> 
> ----------------------------------------------------------------
> 
> Eric Farman (2):
>   s390/cio: Fix vfio-ccw handling of recursive TICs
>   s390/cio: Use cpa range elsewhere within vfio-ccw
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 55 ++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 

Pull and pushed to s390/linux:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
