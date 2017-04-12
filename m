From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] vfio: ccw: code cleanup and bugfix
Date: Wed, 12 Apr 2017 12:47:26 +0200
Message-ID: <20170412124726.2c687a55.cornelia.huck@de.ibm.com>
References: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, dan.carpenter@oracle.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Apr 2017 11:08:14 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> This series have two bugfix patches.
> 
> Patch #1 fixes a bug that was pointed out by Dan Carpenter:
> [bug report] vfio: ccw: introduce a finite state machine
> Message-ID: <20170404120223.GA8525@mwanda>
> 
> Patch #2 fixes another bug that was noticed by Cornelia Huck during the
> discussion on the above thread.
> 
> The code base is:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-v0
> 
> Dong Jia Shi (2):
>   vfio: ccw: remove unnecessary NULL checks of a pointer
>   vfio: ccw: improve error handling for vfio_ccw_mdev_remove
> 
>  drivers/s390/cio/vfio_ccw_fsm.c |  6 +-----
>  drivers/s390/cio/vfio_ccw_ops.c | 34 ++++++----------------------------
>  2 files changed, 7 insertions(+), 33 deletions(-)
> 

Thanks, applied.
