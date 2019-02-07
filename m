From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 07 Feb 2019 16:29:06 +0000
Subject: Re: [PULL 0/1] vfio-ccw: bugfix for 5.1
Message-Id: <20190207172906.2b709b1e@mschwideX1>
In-Reply-To: <20190204170643.7521-1-cohuck@redhat.com>
References: <20190204170643.7521-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  4 Feb 2019 18:06:42 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [Had hoped there would be more, but let's get at least that one queued.]
> 
> The following changes since commit 7dd541a3fb34b34f0f25154dd0d24d0d9b1ca0f3:
> 
>   s390: no need to check return value of debugfs_create functions (2019-01-28 15:58:55 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190204
> 
> for you to fetch changes up to 405d566f98ae19ccf624b31b6eccd6039d9cbc39:
> 
>   vfio-ccw: Don't assume there are more ccws after a TIC (2019-02-04 16:41:04 +0100)
> 
> ----------------------------------------------------------------
> A fix in ccw chain processing.
> 
> ----------------------------------------------------------------
> 
> Farhan Ali (1):
>   vfio-ccw: Don't assume there are more ccws after a TIC
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pulled and pushed to s390/features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
