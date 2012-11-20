From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/3] s390: Virtual channel subsystem support.
Date: Tue, 20 Nov 2012 10:27:53 +0100
Message-ID: <20121120102753.4104ec05@BR9GNB5Z>
References: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
	<1351700688-42353-3-git-send-email-cornelia.huck@de.ibm.com>
	<B6F2031C-0AC3-486A-9A95-51DE66F747AA@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <B6F2031C-0AC3-486A-9A95-51DE66F747AA@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 19 Nov 2012 14:30:00 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 31.10.2012, at 17:24, Cornelia Huck wrote:
> 
> > Provide a mechanism for qemu to provide fully virtual subchannels to
> > the guest. In the KVM case, this relies on the kernel's css support
> > for I/O and machine check interrupt handling. The !KVM case handles
> > interrupts on its own.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > hw/s390x/Makefile.objs     |    1 +
> > hw/s390x/css.c             | 1209 ++++++++++++++++++++++++++++++++++++++++++++
> > hw/s390x/css.h             |   90 ++++
> > target-s390x/Makefile.objs |    2 +-
> > target-s390x/cpu.h         |  232 +++++++++
> > target-s390x/helper.c      |  146 ++++++
> > target-s390x/ioinst.c      |  737 +++++++++++++++++++++++++++
> > target-s390x/ioinst.h      |  213 ++++++++
> > target-s390x/kvm.c         |  251 ++++++++-
> > target-s390x/misc_helper.c |    6 +-
> > 10 files changed, 2872 insertions(+), 15 deletions(-)
> > create mode 100644 hw/s390x/css.c
> > create mode 100644 hw/s390x/css.h
> > create mode 100644 target-s390x/ioinst.c
> > create mode 100644 target-s390x/ioinst.h
> > 
> > diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> > index 096dfcd..378b099 100644
> > --- a/hw/s390x/Makefile.objs
> > +++ b/hw/s390x/Makefile.objs
> > @@ -4,3 +4,4 @@ obj-y := $(addprefix ../,$(obj-y))
> > obj-y += sclp.o
> > obj-y += event-facility.o
> > obj-y += sclpquiesce.o sclpconsole.o
> > +obj-y += css.o
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > new file mode 100644
> > index 0000000..9adffb3
> > --- /dev/null
> > +++ b/hw/s390x/css.c
> > @@ -0,0 +1,1209 @@
> > +/*
> > + * Channel subsystem base support.
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > + */
> > +
> > +#include "qemu-thread.h"
> > +#include "qemu-queue.h"
> > +#include <hw/qdev.h>
> > +#include "bitops.h"
> > +#include "kvm.h"
> > +#include "cpu.h"
> > +#include "ioinst.h"
> > +#include "css.h"
> > +#include "virtio-ccw.h"
> > +
> > +typedef struct CrwContainer {
> > +    CRW crw;
> > +    QTAILQ_ENTRY(CrwContainer) sibling;
> > +} CrwContainer;
> > +
> > +typedef struct ChpInfo {
> > +    uint8_t in_use;
> > +    uint8_t type;
> > +    uint8_t is_virtual;
> > +} ChpInfo;
> > +
> > +typedef struct SubchSet {
> > +    SubchDev *sch[MAX_SCHID + 1];
> > +    unsigned long schids_used[BITS_TO_LONGS(MAX_SCHID + 1)];
> > +    unsigned long devnos_used[BITS_TO_LONGS(MAX_SCHID + 1)];
> > +} SubchSet;
> > +
> > +typedef struct CssImage {
> > +    SubchSet *sch_set[MAX_SSID + 1];
> > +    ChpInfo chpids[MAX_CHPID + 1];
> > +} CssImage;
> > +
> > +typedef struct ChannelSubSys {
> > +    QTAILQ_HEAD(, CrwContainer) pending_crws;
> > +    bool do_crw_mchk;
> > +    bool crws_lost;
> > +    uint8_t max_cssid;
> > +    uint8_t max_ssid;
> > +    bool chnmon_active;
> > +    uint64_t chnmon_area;
> > +    CssImage *css[MAX_CSSID + 1];
> > +    uint8_t default_cssid;
> > +} ChannelSubSys;
> > +
> > +static ChannelSubSys *channel_subsys;
> > +
> > +int css_create_css_image(uint8_t cssid, bool default_image)
> > +{
> > +    if (cssid > MAX_CSSID) {
> > +        return -EINVAL;
> > +    }
> > +    if (channel_subsys->css[cssid]) {
> > +        return -EBUSY;
> > +    }
> > +    channel_subsys->css[cssid] = g_try_malloc0(sizeof(CssImage));
> > +    if (!channel_subsys->css[cssid]) {
> > +        return -ENOMEM;
> > +    }
> > +    if (default_image) {
> > +        channel_subsys->default_cssid = cssid;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void css_write_phys_pmcw(uint64_t addr, PMCW *pmcw)
> > +{
> > +    int i;
> > +    uint32_t offset = 0;
> > +    struct copy_pmcw {
> > +        uint32_t intparm;
> > +        uint16_t flags;
> > +        uint16_t devno;
> > +        uint8_t lpm;
> > +        uint8_t pnom;
> > +        uint8_t lpum;
> > +        uint8_t pim;
> > +        uint16_t mbi;
> > +        uint8_t pom;
> > +        uint8_t pam;
> > +        uint8_t chpid[8];
> > +        uint32_t chars;
> > +    } *copy;
> 
> This needs to be packed. Also, it might be a good idea to separate the struct definition from the actual code ;).
> 
> > +
> > +    copy = (struct copy_pmcw *)pmcw;
> 
> This will break on any system that doesn't coincidently stick to the same bitfield order as s390x. Please drop any usage of bitfields in QEMU source code :).
> 
> > +    stl_phys(addr + offset, copy->intparm);
> > +    offset += sizeof(copy->intparm);
> 
> Can't you just use cpu_physical_memory_map() and assign things left and right as you see fit? Or prepare the target endianness struct on the stack and cpu_physical_memory_read/write it from/to guest memory.

All that copying stuff (other places as well) was still on my todo list
- just wanted to get the patches out of the door so people could take a
look at the interface.

> 
> Also, please split this patch into smaller patches :). As it is now it's very hard to review. However, apart from the above issues (which may happen in other places of the code further down, I just didn't comment then) I couldn't see major problems so far. But please split it nevertheless so that I have an easier time reviewing it :)

I'll try, but I found it hard to come up with a logical split.

> 
> 
> Alex
> 
