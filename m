Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbfGONHx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 09:07:53 -0400
Date: Mon, 15 Jul 2019 15:07:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/5] Some vfio-ccw fixes
Message-ID: <20190715150750.6550b28c.cohuck@redhat.com>
In-Reply-To: <cover.1562854091.git.alifm@linux.ibm.com>
References: <cover.1562854091.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 11 Jul 2019 10:28:50 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> Hi,
> 
> While trying to chase down the problem regarding the stacktraces,
> I have also found some minor problems in the code.
> 
> Would appreciate any review or feedback regarding them.
> 
> Thanks
> Farhan
> 
> ChangeLog
> ---------
> v2 -> v3
>    - Minor changes as suggested by Conny
>    - Add Conny's reviewed-by tags
>    - Add fixes tag for patch 4 and patch 5
> 
> v1 -> v2
>    - Update docs for csch/hsch since we can support those
>      instructions now (patch 5)
>    - Fix the memory leak where we fail to free a ccwchain (patch 2)
>    - Add fixes tag where appropriate.
>    - Fix comment instead of the order when setting orb.cmd.c64 (patch 1)
> 
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

Thanks, did the fixup for patch 5 and queued to vfio-ccw-fixes.
