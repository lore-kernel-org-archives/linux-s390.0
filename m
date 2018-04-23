From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PULL 0/1] vfio-ccw: bug fix
Date: Mon, 23 Apr 2018 09:32:09 +0200
Message-ID: <20180423093209.77edeed4@mschwideX1>
References: <20180420082404.13949-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420082404.13949-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Apr 2018 10:24:03 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit fae764912153065ea55eda47f834e0764a54df94:
> 
>   s390/signal: cleanup uapi struct sigaction (2018-04-17 10:36:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180420
> 
> for you to fetch changes up to c25e3c8e91318ddc17261c7dff053e00a213f176:
> 
>   vfio: ccw: process ssch with interrupts disabled (2018-04-19 17:29:31 +0200)
> 
> ----------------------------------------------------------------
> A vfio-ccw bug fix (call ssch with interrupts disabled).
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (1):
>   vfio: ccw: process ssch with interrupts disabled
> 
>  drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

This is now queued in s390/linux:fixes for the next please-pull.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
