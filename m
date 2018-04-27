From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PULL 0/1] vfio-ccw: another bugfix
Date: Fri, 27 Apr 2018 07:24:14 +0200
Message-ID: <20180427072414.22118caa@mschwideX1>
References: <20180424112656.10243-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424112656.10243-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 Apr 2018 13:26:55 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 6cf09958f32b9667bb3ebadf74367c791112771b:
> 
>   s390: correct module section names for expoline code revert (2018-04-23 07:57:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180424
> 
> for you to fetch changes up to 427e522fc72395a4571b8dd7fe6d116927496bf7:
> 
>   vfio: ccw: fix cleanup if cp_prefetch fails (2018-04-23 14:11:20 +0200)
> 
> ----------------------------------------------------------------
> Another vfio-ccw bug fix: Don't clean up things on error that were
> never translated in the first place.
> 
> ----------------------------------------------------------------
> 
> Halil Pasic (1):
>   vfio: ccw: fix cleanup if cp_prefetch fails
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Now added the s390/linux:fixes. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
