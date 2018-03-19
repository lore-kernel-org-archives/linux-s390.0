From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PULL 0/2] vfio-ccw patches for 4.17
Date: Mon, 19 Mar 2018 07:11:26 +0100
Message-ID: <20180319071126.2ecaa081@mschwideX1>
References: <20180305123116.4301-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305123116.4301-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  5 Mar 2018 13:31:14 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 5628683cf77bc8dad3336a9b254e55f728f7c70e:
> 
>   s390/dasd: set timestamps unconditionally (2018-02-27 08:05:29 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180305
> 
> for you to fetch changes up to 9851bc77e62499957567e7c39a5beba7d6de6296:
> 
>   vfio-ccw: fence off transport mode (2018-03-01 17:35:50 +0100)
> 
> ----------------------------------------------------------------
> A small documentation update, and reject transport mode requests
> (which we don't support).
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (2):
>   vfio-ccw: update documentation
>   vfio-ccw: fence off transport mode
> 
>  Documentation/s390/vfio-ccw.txt | 79 ++++++++++++++++++++---------------------
>  drivers/s390/cio/vfio_ccw_fsm.c |  5 +++
>  2 files changed, 43 insertions(+), 41 deletions(-)
 
This is now merged into s390/linux:features for the next merge window. Thanks Conny.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
