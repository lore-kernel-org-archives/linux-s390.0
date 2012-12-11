From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/8] s390: Channel I/O basic defintions.
Date: Tue, 11 Dec 2012 13:48:10 +0100
Message-ID: <20121211134810.1a36d4b5@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-3-git-send-email-cornelia.huck@de.ibm.com>
	<413896B0-480D-4113-99FC-6432847ADD9F@suse.de>
	<20121210111834.42d25bcb@BR9GNB5Z>
	<B18B4650-430D-4E1A-AA3A-186383886D39@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <B18B4650-430D-4E1A-AA3A-186383886D39@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Dec 2012 11:27:05 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 10.12.2012, at 11:18, Cornelia Huck wrote:
> 
> > On Mon, 10 Dec 2012 09:07:57 +0100
> > Alexander Graf <agraf@suse.de> wrote:
> > 
> >> 
> >> On 07.12.2012, at 13:50, Cornelia Huck wrote:
> >> 
> >>> Basic channel I/O structures and helper function.
> >>> 
> >>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >>> ---
> >>> target-s390x/Makefile.objs |   2 +-
> >>> target-s390x/ioinst.c      |  46 ++++++++++
> >>> target-s390x/ioinst.h      | 207 +++++++++++++++++++++++++++++++++++++++++++++
> >>> 3 files changed, 254 insertions(+), 1 deletion(-)
> >>> create mode 100644 target-s390x/ioinst.c
> >>> create mode 100644 target-s390x/ioinst.h
> >>> 
> >>> diff --git a/target-s390x/Makefile.objs b/target-s390x/Makefile.objs
> >>> index e728abf..3afb0b7 100644
> >>> --- a/target-s390x/Makefile.objs
> >>> +++ b/target-s390x/Makefile.objs
> >>> @@ -1,4 +1,4 @@
> >>> obj-y += translate.o helper.o cpu.o interrupt.o
> >>> obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
> >>> -obj-$(CONFIG_SOFTMMU) += machine.o
> >>> +obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o
> >>> obj-$(CONFIG_KVM) += kvm.o
> >>> diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
> >>> new file mode 100644
> >>> index 0000000..8577b2c
> >>> --- /dev/null
> >>> +++ b/target-s390x/ioinst.c
> >>> @@ -0,0 +1,46 @@
> >>> +/*
> >>> + * I/O instructions for S/390
> >>> + *
> >>> + * Copyright 2012 IBM Corp.
> >>> + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> >>> + * your option) any later version. See the COPYING file in the top-level
> >>> + * directory.
> >>> + */
> >>> +
> >>> +#include <sys/types.h>
> >>> +#include <sys/ioctl.h>
> >>> +#include <sys/mman.h>
> >>> +
> >>> +#include "cpu.h"
> >>> +#include "ioinst.h"
> >>> +
> >>> +#ifdef DEBUG_IOINST
> >>> +#define dprintf(fmt, ...) \
> >>> +    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> >>> +#else
> >>> +#define dprintf(fmt, ...) \
> >>> +    do { } while (0)
> >>> +#endif
> >>> +
> >>> +int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
> >>> +                                 int *schid)
> >>> +{
> >>> +    if (!(value & IOINST_SCHID_ONE)) {
> >>> +        return -EINVAL;
> >>> +    }
> >>> +    if (!(value & IOINST_SCHID_M)) {
> >>> +        if (value & IOINST_SCHID_CSSID) {
> >>> +            return -EINVAL;
> >>> +        }
> >>> +        *cssid = 0;
> >>> +        *m = 0;
> >>> +    } else {
> >>> +        *cssid = (value & IOINST_SCHID_CSSID) >> 24;
> >> 
> >> (value & IOINST_SCHID_CSSID_MASK) >> IOINST_SCHID_CSSID_SHIFT
> > 
> > I think that actually decreases readability.
> 
> I'm fine with doing it Jocelyn-style too:
> 
> #define IOINST_SCHID_CSSID(x) ((x & 0x...) >> 24)
> 
> if you prefer that for readability :)

It's worth a try.
