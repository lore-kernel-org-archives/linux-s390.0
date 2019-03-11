From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 11 Mar 2019 17:24:21 +0000
Subject: Re: [PULL 0/1] vfio-ccw: fix for 5.1
Message-Id: <20190311102421.45dd499a@mschwideX1>
In-Reply-To: <20190311162656.10067-1-cohuck@redhat.com>
References: <20190311162656.10067-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 11 Mar 2019 17:26:55 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 152e9b8676c6e788c6bff095c1eaae7b86df5003:
> 
>   s390/vtime: steal time exponential moving average (2019-03-06 14:59:50 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190311
> 
> for you to fetch changes up to 50b7f1b7236bab08ebbbecf90521e84b068d7a17:
> 
>   vfio: ccw: only free cp on final interrupt (2019-03-11 12:06:50 +0100)
> 
> ----------------------------------------------------------------
> Fix a host crash triggerable by the guest via a channel program.
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (1):
>   vfio: ccw: only free cp on final interrupt
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Pulled & pushed to s390/linux:fixes. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
