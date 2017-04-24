From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PULL 0/2] Fixes for vfio-ccw
Date: Mon, 24 Apr 2017 10:53:34 +0200
Message-ID: <20170424105334.7e1e37b9.cornelia.huck@de.ibm.com>
References: <20170413105748.24092-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170413105748.24092-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 13 Apr 2017 12:57:46 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> The following changes since commit 1877888d0ad21858693d8a5594734b125a068638:
> 
>   MAINTAINERS: Add vfio-ccw maintainers (2017-03-31 12:55:12 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20170413
> 
> for you to fetch changes up to 129cc19a94513081e9250323cd57e12ed48b3613:
> 
>   vfio: ccw: improve error handling for vfio_ccw_mdev_remove (2017-04-12 12:34:17 +0200)
> 
> ----------------------------------------------------------------
> Two fixes for the new vfio-ccw support.
> 
> ----------------------------------------------------------------
> 
> Dong Jia Shi (2):
>   vfio: ccw: remove unnecessary NULL checks of a pointer
>   vfio: ccw: improve error handling for vfio_ccw_mdev_remove
> 
>  drivers/s390/cio/vfio_ccw_fsm.c |  6 +-----
>  drivers/s390/cio/vfio_ccw_ops.c | 34 ++++++----------------------------
>  2 files changed, 7 insertions(+), 33 deletions(-)
> 

ping
