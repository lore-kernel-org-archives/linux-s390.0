From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/4] vfio: ccw: error handling fixes and improvements
Date: Mon, 26 Mar 2018 11:02:24 +0200
Message-ID: <20180326110224.1af0ad13.cohuck@redhat.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 21 Mar 2018 03:08:18 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Hi Conny,
> 
> Halil reported a host crash when using vfio-ccw. The root cause of the problem
> is that vfio_pin_pages fails with EINVAL for reasons unknown. He has
> experienced such failures after online-ing a dasd in the guest (the dasd has 3
> partitions, hat may or may not have any significance). The problem isn't
> experienced on every attempt to online the dasd, and breaking at css_do_ssch
> seems to make things work.
> 
> One thing is sure: the host kernel should not crash under the described
> circumstances.
> 
> To fix the problem, the first patch of this series fixes the cleanup when
> cp_prefetch fails in the higher level. The 2nd and the 3rd patches provide
> correctness and denfensive actions for the interfaces in the lower level.

So, is the first patch stable material?

> 
> The 4th patch is trying to add tracepoints for vfio-ccw, so that we can debug
> such issue easier in future.

Tracepoints are nice :)

> 
> For details see the commit message portions of the inividual patches.

Still digging through the post-vacation mail pile, will do more looking
later.

 
> Thanks.
> 
> Dong Jia Shi (2):
>   vfio: ccw: refactor and improve pfn_array_alloc_pin()
>   vfio: ccw: set ccw->cda to NULL defensively
> 
> Halil Pasic (2):
>   vfio: ccw: fix cleanup if cp_prefetch fails
>   vfio: ccw: add traceponits for interesting error paths
> 
>  drivers/s390/cio/Makefile         |   1 +
>  drivers/s390/cio/vfio_ccw_cp.c    | 121 ++++++++++++++++++++------------------
>  drivers/s390/cio/vfio_ccw_fsm.c   |  13 ++++
>  drivers/s390/cio/vfio_ccw_trace.h |  86 +++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_trace.h
> 
