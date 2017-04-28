From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v5 07/13] vfio/ccw: vfio based subchannel passthrough
 driver
Date: Fri, 28 Apr 2017 13:04:07 +0200
Message-ID: <20170428130407.7de89e86.cornelia.huck@de.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
        <20170412052115.101657-8-bjsdjshi@linux.vnet.ibm.com>
        <20170424164338.0250f3fa@w520.home>
        <20170424165628.631b0455@w520.home>
        <20170425051519.GH31848@bjsdjshi@linux.vnet.ibm.com>
        <20170426084920.GI31848@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170426084920.GI31848@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Apr 2017 16:49:20 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-04-25 13:15:19 +0800]:
> 
> > * Alex Williamson <alex.williamson@redhat.com> [2017-04-24 16:56:28 -0600]:
> > 
> > [...]
> > > > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > > > new file mode 100644
> > > > > index 0000000..c491bee
> > > > > --- /dev/null
> > > > > +++ b/hw/vfio/ccw.c
> > > > > @@ -0,0 +1,207 @@
> > > > > +/*
> > > > > + * vfio based subchannel assignment support
> > > > > + *
> > > > > + * Copyright 2017 IBM Corp.
> > > > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > > > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > > > + *
> > > > > + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> > > > > + * your option) any version. See the COPYING file in the top-level
> > > > > + * directory.
> > > > > + */
> > > > > +
> > > > > +#include <linux/vfio.h>
> > > > > +#include <sys/ioctl.h>
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "qapi/error.h"
> > > > > +#include "hw/sysbus.h"
> > > > > +#include "hw/vfio/vfio.h"
> > > > > +#include "hw/vfio/vfio-common.h"
> > > > > +#include "hw/s390x/s390-ccw.h"
> > > > > +#include "hw/s390x/ccw-device.h"
> > > > > +
> > > > > +#define TYPE_VFIO_CCW "vfio-ccw"
> > > > > +typedef struct VFIOCCWDevice {
> > > > > +    S390CCWDevice cdev;
> > > > > +    VFIODevice vdev;
> > > > > +} VFIOCCWDevice;
> > > > > +
> > > > > +static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > > > > +{
> > > > > +    vdev->needs_reset = false;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * We don't need vfio_hot_reset_multi and vfio_eoi operationis for
> > > 
> > > One more:
> > > 
> > > s/operationis/operations/
> > > 
> > Ok.
> > 
> 
> Hi Conny,
> 
> I have pulled your cohuck-qemu/s390-next branch, and prepared a new
> patch set with all of these problems fixed directly on the coressponding
> commits on it. Fine to send out the new version as that?
> 
> Or I should rebase them against the latest master branch?

As I currently don't have things in my next branch that should interact
with your changes, either is fine :)

[I'll take a look at the new version then]
