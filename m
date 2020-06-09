Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49745 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgFIHJM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 03:09:12 -0400
Subject: Re: [kvm-unit-tests PATCH v8 09/12] s390x: Library resources for CSS
 tests
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-10-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef5e71b6-9c4d-ac3f-7946-f67db73d740b@redhat.com>
Date: Tue, 9 Jun 2020 09:09:00 +0200
MIME-Version: 1.0
In-Reply-To: <1591603981-16879-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 08/06/2020 10.12, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
> 
> Debug function can be activated by defining DEBUG_CSS before the
> inclusion of the css.h header file.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h      | 257 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>  s390x/Makefile       |   1 +
>  3 files changed, 411 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c
> 
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> new file mode 100644
> index 0000000..33caaa0
> --- /dev/null
> +++ b/lib/s390x/css.h
> @@ -0,0 +1,257 @@
> +/*
> + * CSS definitions
> + *
> + * Copyright IBM, Corp. 2020
> + * Author: Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef CSS_H
> +#define CSS_H
> +
> +/* subchannel ID bit 16 must always be one */
> +#define SCHID_ONE	0x00010000
> +
> +#define CCW_F_CD	0x80
> +#define CCW_F_CC	0x40
> +#define CCW_F_SLI	0x20
> +#define CCW_F_SKP	0x10
> +#define CCW_F_PCI	0x08
> +#define CCW_F_IDA	0x04
> +#define CCW_F_S		0x02
> +#define CCW_F_MIDA	0x01
> +
> +#define CCW_C_NOP	0x03
> +#define CCW_C_TIC	0x08
> +
> +struct ccw1 {
> +	uint8_t code;
> +	uint8_t flags;
> +	uint16_t count;
> +	uint32_t data_address;
> +} __attribute__ ((aligned(8)));
> +
> +#define ORB_CTRL_KEY	0xf0000000
> +#define ORB_CTRL_SPND	0x08000000
> +#define ORB_CTRL_STR	0x04000000
> +#define ORB_CTRL_MOD	0x02000000
> +#define ORB_CTRL_SYNC	0x01000000
> +#define ORB_CTRL_FMT	0x00800000
> +#define ORB_CTRL_PFCH	0x00400000
> +#define ORB_CTRL_ISIC	0x00200000
> +#define ORB_CTRL_ALCC	0x00100000
> +#define ORB_CTRL_SSIC	0x00080000
> +#define ORB_CTRL_CPTC	0x00040000
> +#define ORB_CTRL_C64	0x00020000
> +#define ORB_CTRL_I2K	0x00010000
> +#define ORB_CTRL_LPM	0x0000ff00
> +#define ORB_CTRL_ILS	0x00000080
> +#define ORB_CTRL_MIDAW	0x00000040
> +#define ORB_CTRL_ORBX	0x00000001
> +
> +#define ORB_LPM_DFLT	0x00008000
> +
> +struct orb {
> +	uint32_t intparm;
> +	uint32_t ctrl;
> +	uint32_t cpa;
> +	uint32_t prio;
> +	uint32_t reserved[4];
> +} __attribute__ ((aligned(4)));
> +
> +struct scsw {
> +	uint32_t ctrl;
> +	uint32_t ccw_addr;
> +	uint8_t  dev_stat;
> +	uint8_t  sch_stat;
> +	uint16_t count;
> +};
> +
> +struct pmcw {
> +	uint32_t intparm;
> +#define PMCW_DNV        0x0001
> +#define PMCW_ENABLE     0x0080
> +	uint16_t flags;
> +	uint16_t devnum;
> +	uint8_t  lpm;
> +	uint8_t  pnom;
> +	uint8_t  lpum;
> +	uint8_t  pim;
> +	uint16_t mbi;
> +	uint8_t  pom;
> +	uint8_t  pam;
> +	uint8_t  chpid[8];
> +	uint32_t flags2;
> +};
> +#define PMCW_CHANNEL_TYPE(pmcw) (pmcw->flags2 >> 21)
> +
> +struct schib {
> +	struct pmcw pmcw;
> +	struct scsw scsw;
> +	uint8_t  md[12];
> +} __attribute__ ((aligned(4)));
> +
> +struct irb {
> +	struct scsw scsw;
> +	uint32_t esw[5];
> +	uint32_t ecw[8];
> +	uint32_t emw[8];
> +} __attribute__ ((aligned(4)));
> +
> +/* CSS low level access functions */
> +
> +static inline int ssch(unsigned long schid, struct orb *addr)
> +{
> +	register long long reg1 asm("1") = schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	ssch	0(%2)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28\n"
> +		: "=d" (cc)
> +		: "d" (reg1), "a" (addr), "m" (*addr)

Hmm... What's the "m" (*addr) here good for? %3 is not used in the
assembly code?

> +		: "cc", "memory");

Why "memory" ? Can this instruction also change the orb?

> +	return cc;
> +}
> +
> +static inline int stsch(unsigned long schid, struct schib *addr)
> +{
> +	register unsigned long reg1 asm ("1") = schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	stsch	0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=d" (cc), "=m" (*addr)
> +		: "d" (reg1), "a" (addr)
> +		: "cc");

I'm surprised that this does not use "memory" in the clobber list ... I
guess that's what the "=m" (*addr) is good for?

> +	return cc;
> +}
> +
> +static inline int msch(unsigned long schid, struct schib *addr)
> +{
> +	register unsigned long reg1 asm ("1") = schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	msch	0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=d" (cc), "=m" (*addr)
> +		: "d" (reg1), "a" (addr)

I'm not an expert with these IO instructions, but this looks wrong to me
... Is MSCH reading or writing the SCHIB data?

> +		: "cc");
> +	return cc;
> +}
[...]
> +static inline int rchp(unsigned long chpid)
> +{
> +	register unsigned long reg1 asm("1") = chpid;
> +	int cc;
> +
> +	asm volatile(
> +		"	rchp\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=d" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +/* Debug functions */
> +char *dump_pmcw_flags(uint16_t f);
> +char *dump_scsw_flags(uint32_t f);
> +
> +void dump_scsw(struct scsw *);
> +void dump_irb(struct irb *irbp);
> +void dump_schib(struct schib *sch);
> +struct ccw1 *dump_ccw(struct ccw1 *cp);
> +void dump_irb(struct irb *irbp);
> +void dump_pmcw(struct pmcw *p);
> +void dump_orb(struct orb *op);

In the patch description, you said that DEBUG_CSS needs to be defined
for these - but now DEBUG_CSS is not used in this header... does the
patch description need to be changed?

> +int css_enumerate(void);
> +#define MAX_ENABLE_RETRIES      5
> +int css_enable(int schid);
> +
> +#endif
> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
> new file mode 100644
> index 0000000..0c2b64e
> --- /dev/null
> +++ b/lib/s390x/css_dump.c
> @@ -0,0 +1,153 @@
> +/*
> + * Channel subsystem structures dumping
> + *
> + * Copyright (c) 2020 IBM Corp.
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.

In the header you used "or any later version" - here it's version 2
only. Maybe you want to standardize one one of the two flavors?

 Thomas
