Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQJnP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 05:43:15 -0400
Date: Wed, 17 Jul 2019 11:43:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/5] vfio-ccw fixes for 5.3
Message-ID: <20190717114311.75414e41.cohuck@redhat.com>
In-Reply-To: <20190716100908.3460-1-cohuck@redhat.com>
References: <20190716100908.3460-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 16 Jul 2019 12:09:03 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 9a159190414d461fdac7ae5bb749c2d532b35419:
> 
>   s390/unwind: avoid int overflow in outside_of_stack (2019-07-11 20:40:02 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190716
> 
> for you to fetch changes up to 127e62174041496b383f82d696e1592ce6838604:
> 
>   vfio-ccw: Update documentation for csch/hsch (2019-07-15 14:22:57 +0200)
> 
> ----------------------------------------------------------------
> Fixes in vfio-ccw for older and newer issues.
> 
> ----------------------------------------------------------------
> 
> Farhan Ali (5):
>   vfio-ccw: Fix misleading comment when setting orb.cmd.c64
>   vfio-ccw: Fix memory leak and don't call cp_free in cp_init
>   vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
>   vfio-ccw: Don't call cp_free if we are processing a channel program
>   vfio-ccw: Update documentation for csch/hsch
> 
>  Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
>  drivers/s390/cio/vfio_ccw_cp.c  | 28 +++++++++++++++++-----------
>  drivers/s390/cio/vfio_ccw_drv.c |  2 +-
>  3 files changed, 46 insertions(+), 15 deletions(-)
> 

Argh, please disregard this one. New one incoming.

/me needs more sleep...
