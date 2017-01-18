From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v2 02/12] vfio: linux-headers update for vfio-ccw
Date: Wed, 18 Jan 2017 13:41:47 +0100
Message-ID: <20170118134147.5cf6beb0.cornelia.huck@de.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
        <20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
        <20170117145142.4954666f@t450s.home>
        <20170118025117.GN30301@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170118025117.GN30301@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Jan 2017 10:51:17 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:51:42 -0700]:
> 
> > On Thu, 12 Jan 2017 08:25:03 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > 
> > > This is a placeholder for a linux-headers update.
> > > 
> > > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > ---
> > >  include/standard-headers/asm-s390/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
> > >  linux-headers/linux/vfio.h                   | 17 +++++++++++++++++
> > >  2 files changed, 45 insertions(+)
> > >  create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h
> > > 
> > > diff --git a/include/standard-headers/asm-s390/vfio_ccw.h b/include/standard-headers/asm-s390/vfio_ccw.h
> > > new file mode 100644
> > > index 0000000..cddc09b
> > > --- /dev/null
> > > +++ b/include/standard-headers/asm-s390/vfio_ccw.h
> > > @@ -0,0 +1,28 @@
> > > +/*
> > > + * Interfaces for vfio-ccw
> > > + *
> > > + * Copyright IBM Corp. 2017
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License (version 2 only)
> > > + * as published by the Free Software Foundation.
> > > + *
> > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > + */
> > > +
> > > +#ifndef _VFIO_CCW_H_
> > > +#define _VFIO_CCW_H_
> > > +
> > > +#include "standard-headers/linux/types.h"
> > > +
> > > +struct ccw_io_region {
> > > +#define ORB_AREA_SIZE 12
> > > +	uint8_t  orb_area[ORB_AREA_SIZE];
> > > +#define SCSW_AREA_SIZE 12
> > > +	uint8_t  scsw_area[SCSW_AREA_SIZE];
> > > +#define IRB_AREA_SIZE 96
> > > +	uint8_t  irb_area[IRB_AREA_SIZE];
> > > +	uint32_t ret_code;
> > > +} QEMU_PACKED;
> > > +
> > > +#endif
> > 
> > This is really part of the uapi for the vfio-ccw mdev device, isn't it?
> Yes, it is.
> 
> > Should it really be buried in asm-s390 in the kernel?
> > 
> We had an internal discussion on this question before, since we think
> this interface is strongly s390 dependent, we put it here. What do you
> suggest? Thanks,

As there are already architecture-specific definitions in the common
file, having everything in the same file is probably better. I'm
certainly not against moving it out from asm-s390.
