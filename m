From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/5] s390: Virtual channel subsystem
 support.
Date: Wed, 8 Aug 2012 10:17:50 +0200
Message-ID: <20120808101750.35800579@BR9GNB5Z>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-3-git-send-email-cornelia.huck@de.ibm.com>
	<CAAu8pHt=yf2oh4PQ8RwxkR5-mXp_EOMqAQ9pq+w54peXk_+H-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <CAAu8pHt=yf2oh4PQ8RwxkR5-mXp_EOMqAQ9pq+w54peXk_+H-g@mail.gmail.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 7 Aug 2012 21:00:59 +0000
Blue Swirl <blauwirbel@gmail.com> wrote:


> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > new file mode 100644
> > index 0000000..7941c44
> > --- /dev/null
> > +++ b/hw/s390x/css.c
> > @@ -0,0 +1,440 @@
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
> > +#include "kvm.h"
> > +#include "cpu.h"
> > +#include "ioinst.h"
> > +#include "css.h"
> > +
> > +struct chp_info {
> 
> CamelCase, please.

OK.
> 
> > +    uint8_t in_use;
> > +    uint8_t type;
> > +};
> > +
> > +static struct chp_info chpids[MAX_CSSID + 1][MAX_CHPID + 1];
> > +
> > +static css_subch_cb_func css_subch_cb;
> 
> Probably these can be put to a container structure which can be passed around.

Still trying to come up with a good model for that.

> 

> > +    case CCW_CMD_SENSE_ID:
> > +    {
> > +        uint8_t sense_bytes[256];
> > +
> > +        /* Sense ID information is device specific. */
> > +        memcpy(sense_bytes, &sch->id, sizeof(sense_bytes));
> > +        if (check_len) {
> > +            if (ccw->count != sizeof(sense_bytes)) {
> > +                ret = -EINVAL;
> > +                break;
> > +            }
> > +        }
> > +        len = MIN(ccw->count, sizeof(sense_bytes));
> > +        /*
> > +         * Only indicate 0xff in the first sense byte if we actually
> > +         * have enough place to store at least bytes 0-3.
> > +         */
> > +        if (len >= 4) {
> > +            stb_phys(ccw->cda, 0xff);
> > +        } else {
> > +            stb_phys(ccw->cda, 0);
> > +        }
> > +        i = 1;
> > +        for (i = 1; i < len - 1; i++) {
> > +            stb_phys(ccw->cda + i, sense_bytes[i]);
> > +        }
> 
> cpu_physical_memory_write()

Hm, what's wrong with storing byte-by-byte?

> 
> > +        sch->curr_status.scsw.count = ccw->count - len;
> > +        ret = 0;
> > +        break;
> > +    }
> > +    case CCW_CMD_TIC:
> > +        if (sch->last_cmd->cmd_code == CCW_CMD_TIC) {
> > +            ret = -EINVAL;
> > +            break;
> > +        }
> > +        if (ccw->flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
> > +            ret = -EINVAL;
> > +            break;
> > +        }
> > +        sch->channel_prog = qemu_get_ram_ptr(ccw->cda);
> > +        ret = sch->channel_prog ? -EAGAIN : -EFAULT;
> > +        break;
> > +    default:
> > +        if (sch->ccw_cb) {
> > +            /* Handle device specific commands. */
> > +            ret = sch->ccw_cb(sch, ccw);
> > +        } else {
> > +            ret = -EOPNOTSUPP;
> > +        }
> > +        break;
> > +    }
> > +    sch->last_cmd = ccw;
> > +    if (ret == 0) {
> > +        if (ccw->flags & CCW_FLAG_CC) {
> > +            sch->channel_prog += 8;
> > +            ret = -EAGAIN;
> > +        }
> > +    }
> > +
> > +    return ret;

> > diff --git a/hw/s390x/css.h b/hw/s390x/css.h
> > new file mode 100644
> > index 0000000..b8a95cc
> > --- /dev/null
> > +++ b/hw/s390x/css.h
> > @@ -0,0 +1,62 @@
> > +/*
> > + * Channel subsystem structures and definitions.
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > + */
> > +
> > +#ifndef CSS_H
> > +#define CSS_H
> > +
> > +#include "ioinst.h"
> > +
> > +/* Channel subsystem constants. */
> > +#define MAX_SCHID 65535
> > +#define MAX_SSID 3
> > +#define MAX_CSSID 254 /* 255 is reserved */
> > +#define MAX_CHPID 255
> > +
> > +#define MAX_CIWS 8
> > +
> > +struct senseid {
> 
> SenseID

OK.
> 
> > +    /* common part */
> > +    uint32_t  reserved:8;    /* always 0x'FF' */
> 
> The standard syntax calls for 'unsigned' instead of uint32_t for bit
> fields. But bit fields are not very well defined, it's better to avoid
> them.

Well, the equivalent Linux structure also looks like that :) But I can
switch this to a uint8_t/uint16_t structure.

> 
> > +    uint32_t  cu_type:16;    /* control unit type */
> > +    uint32_t  cu_model:8;    /* control unit model */
> > +    uint32_t  dev_type:16;   /* device type */
> > +    uint32_t  dev_model:8;   /* device model */
> > +    uint32_t  unused:8;      /* padding byte */
> > +    /* extended part */
> > +    uint32_t ciw[MAX_CIWS];  /* variable # of CIWs */
> > +};
> > +

> > diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
> > new file mode 100644
> > index 0000000..79628b4
> > --- /dev/null
> > +++ b/target-s390x/ioinst.h
> > @@ -0,0 +1,173 @@
> > +/*
> > + * S/390 channel I/O instructions
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > +*/
> > +
> > +#ifndef IOINST_S390X_H
> > +#define IOINST_S390X_H
> > +
> > +/*
> > + * Channel I/O related definitions, as defined in the Principles
> > + * Of Operation (and taken from the Linux implementation).
> 
> Is this a copy and if so, is the license of original Linux file also GPLv2+?

It's not a verbatim copy.

> 
> > + */
> > +
> > +/* subchannel status word (command mode only) */
> > +struct scsw {
> 
> Please use more descriptive names instead of acronyms, for example SubChStatus.

I'd rather leave these at the well-known scsw, pmcw, etc. names. These
have been around for decades, and somebody familiar with channel I/O
will instantly know what a struct scsw is, but will need to look hard
at the code to figure out the meaning of SubChStatus.

> 
> > +    uint32_t key:4;
> > +    uint32_t sctl:1;
> > +    uint32_t eswf:1;
> > +    uint32_t cc:2;
> > +    uint32_t fmt:1;
> > +    uint32_t pfch:1;
> > +    uint32_t isic:1;
> > +    uint32_t alcc:1;
> > +    uint32_t ssi:1;
> > +    uint32_t zcc:1;
> > +    uint32_t ectl:1;
> > +    uint32_t pno:1;
> > +    uint32_t res:1;
> > +    uint32_t fctl:3;
> > +    uint32_t actl:7;
> > +    uint32_t stctl:5;
> > +    uint32_t cpa;
> > +    uint32_t dstat:8;
> > +    uint32_t cstat:8;
> > +    uint32_t count:16;
> > +};
