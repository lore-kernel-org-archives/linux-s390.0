From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 00/11] basic channel IO passthrough infrastructure
 based on vfio
Date: Tue, 11 Apr 2017 11:06:58 +0200
Message-ID: <20170411110658.2bf778e3.cornelia.huck@de.ibm.com>
References: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Mar 2017 04:19:17 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The patch series introduce a basic channel I/O passthrough
> infrastructure based on vfio.

I think this is basically ready for 2.10, once the kernel changes hit
master (they are queued in the s390 tree).

(...)

>  default-configs/s390x-softmmu.mak  |   1 +
>  hw/s390x/Makefile.objs             |   1 +
>  hw/s390x/css-bridge.c              |   2 +
>  hw/s390x/css.c                     | 290 ++++++++++++++++++++++--
>  hw/s390x/s390-ccw.c                | 137 ++++++++++++
>  hw/s390x/s390-ccw.h                |  39 ++++
>  hw/s390x/s390-virtio-ccw.c         |  35 ++-
>  hw/s390x/virtio-ccw.c              |   7 +-
>  hw/vfio/Makefile.objs              |   1 +
>  hw/vfio/ccw.c                      | 442 +++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/css-bridge.h      |   1 +
>  include/hw/s390x/css.h             |  67 +++---
>  include/hw/s390x/s390-virtio-ccw.h |   1 +
>  include/hw/vfio/vfio-common.h      |   1 +
>  linux-headers/linux/vfio.h         |  17 ++
>  linux-headers/linux/vfio_ccw.h     |  28 +++
>  qemu-options.hx                    |   6 +-
>  target/s390x/cpu.h                 |  10 +
>  target/s390x/ioinst.c              |   9 +
>  19 files changed, 1047 insertions(+), 48 deletions(-)
>  create mode 100644 hw/s390x/s390-ccw.c
>  create mode 100644 hw/s390x/s390-ccw.h
>  create mode 100644 hw/vfio/ccw.c
>  create mode 100644 linux-headers/linux/vfio_ccw.h

It's probably best to take this through my tree (pending acks of the
vfio parts from Alex W.). It probably also would be good to add an s390
maintainer for  hw/vfio/ccw.c (I'd be willing to do that).

Could you please resend on top of git://github.com/cohuck/qemu s390-next
and add a MAINTAINERS patch as well?
