Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728282AbfLLJwA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:52:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9lJP0100939
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:51:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd25qk9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:51:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:51:56 -0000
Subject: Re: [kvm-unit-tests PATCH v4 5/9] s390x: Library resources for CSS
 tests
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-6-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-6-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dc96MCbcXyr8pnzWxZtH3l4mj9pXmphNV"
Message-Id: <dd5b82c6-f5bd-ff3d-b65f-300cacfee8a3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dc96MCbcXyr8pnzWxZtH3l4mj9pXmphNV
Content-Type: multipart/mixed; boundary="iMmnz3r5pZUe2SD6BDaEd5FGQl8CKApWQ"

--iMmnz3r5pZUe2SD6BDaEd5FGQl8CKApWQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> These are the include and library utilities for the css tests patch
> series.
>=20
> Debug function can be activated by defining DEBUG_CSS before the
> inclusion of the css.h header file.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h      | 259 +++++++++++++++++++++++++++++++++++++++++++=

>  lib/s390x/css_dump.c | 157 ++++++++++++++++++++++++++
>  2 files changed, 416 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c
>=20
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> new file mode 100644
> index 0000000..fd086aa
> --- /dev/null
> +++ b/lib/s390x/css.h
> @@ -0,0 +1,259 @@
> +/*
> + * CSS definitions
> + *
> + * Copyright IBM, Corp. 2019
> + * Author: Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +
> +#ifndef CSS_H
> +#define CSS_H
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
> +	unsigned char code;
> +	unsigned char flags;
> +	unsigned short count;
> +	uint32_t data_address;
> +} __attribute__ ((aligned(4)));
> +
> +#define ORB_M_KEY	0xf0000000
> +#define ORB_F_SUSPEND	0x08000000
> +#define ORB_F_STREAMING	0x04000000
> +#define ORB_F_MODIFCTRL	0x02000000
> +#define ORB_F_SYNC	0x01000000
> +#define ORB_F_FORMAT	0x00800000
> +#define ORB_F_PREFETCH	0x00400000
> +#define ORB_F_INIT_IRQ	0x00200000
> +#define ORB_F_ADDRLIMIT	0x00100000
> +#define ORB_F_SUSP_IRQ	0x00080000
> +#define ORB_F_TRANSPORT	0x00040000
> +#define ORB_F_IDAW2	0x00020000
> +#define ORB_F_IDAW_2K	0x00010000
> +#define ORB_M_LPM	0x0000ff00
> +#define ORB_F_LPM_DFLT	0x00008000
> +#define ORB_F_ILSM	0x00000080
> +#define ORB_F_CCW_IND	0x00000040
> +#define ORB_F_ORB_EXT	0x00000001

That looks weird.

> +
> +struct orb {
> +	uint32_t intparm;
> +	uint32_t ctrl;
> +	uint32_t cpa;
> +	uint32_t prio;
> +	uint32_t reserved[4];
> +} __attribute__ ((aligned(4)));

Are any of these ever stack allocated and therefore need alignment?

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
> +	register long long reg1 asm("1") =3D schid;
> +	int cc =3D -1;

Why is this one initialized but no other cc is?

> +
> +	asm volatile(
> +		"	   ssch	0(%2)\n"
> +		"0:	 ipm	 %0\n"
> +		"	   srl	 %0,28\n"

Formatting?

> +		"1:\n"

What do these jump labels do?

> +		: "+d" (cc)
> +		: "d" (reg1), "a" (addr), "m" (*addr)
> +		: "cc", "memory");
> +	return cc;
> +}
> +
> +static inline int stsch(unsigned long schid, struct schib *addr)
> +{
> +	register unsigned long reg1 asm ("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	   stsch	0(%3)\n"
> +		"	   ipm	 %0\n"
> +		"	   srl	 %0,28"
> +		: "=3Dd" (cc), "=3Dm" (*addr)
> +		: "d" (reg1), "a" (addr)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int msch(unsigned long schid, struct schib *addr)
> +{
> +	register unsigned long reg1 asm ("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	   msch	0(%3)\n"
> +		"	   ipm	 %0\n"
> +		"	   srl	 %0,28"
> +		: "=3Dd" (cc), "=3Dm" (*addr)
> +		: "d" (reg1), "a" (addr)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int tsch(unsigned long schid, struct irb *addr)
> +{
> +	register unsigned long reg1 asm ("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	   tsch	0(%3)\n"
> +		"	   ipm	 %0\n"
> +		"	   srl	 %0,28"
> +		: "=3Dd" (cc), "=3Dm" (*addr)
> +		: "d" (reg1), "a" (addr)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int hsch(unsigned long schid)
> +{
> +	register unsigned long reg1 asm("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	hsch\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int xsch(unsigned long schid)
> +{
> +	register unsigned long reg1 asm("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	xsch\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int csch(unsigned long schid)
> +{
> +	register unsigned long reg1 asm("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	csch\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int rsch(unsigned long schid)
> +{
> +	register unsigned long reg1 asm("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	rsch\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +static inline int rchp(unsigned long chpid)
> +{
> +	register unsigned long reg1 asm("1") =3D chpid;
> +	int cc;
> +
> +	asm volatile(
> +		"	rchp\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1)
> +		: "cc");
> +	return cc;
> +}
> +
> +/* Debug functions */
> +char *dump_pmcw_flags(uint16_t f);
> +char *dump_scsw_flags(uint32_t f);
> +
> +#ifdef DEBUG_CSS
> +void dump_scsw(struct scsw *);
> +void dump_irb(struct irb *irbp);
> +void dump_schib(struct schib *sch);
> +struct ccw *dump_ccw(struct ccw *cp);
> +#else
> +static inline void dump_scsw(struct scsw *scsw) {}
> +static inline void dump_irb(struct irb *irbp) {}
> +static inline void dump_pmcw(struct pmcw *p) {}
> +static inline void dump_schib(struct schib *sch) {}
> +static inline void dump_orb(struct orb *op) {}
> +static inline struct ccw *dump_ccw(struct ccw *cp)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +extern unsigned long stacktop;

That should be exported somewhere else, we also use it in
lib/s390x/sclp.c. Btw. why is it in here at all?

> +#endif
> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
> new file mode 100644
> index 0000000..ff1a812
> --- /dev/null
> +++ b/lib/s390x/css_dump.c
> @@ -0,0 +1,157 @@
> +/*
> + * Channel subsystem structures dumping
> + *
> + * Copyright (c) 2019 IBM Corp.
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU Library General Public License version 2=
=2E
> + *
> + * Description:
> + * Provides the dumping functions for various structures used by subch=
annels:
> + * - ORB  : Operation request block, describes the I/O operation and p=
oints to
> + *          a CCW chain
> + * - CCW  : Channel Command Word, describes the data and flow control
> + * - IRB  : Interuption response Block, describes the result of an ope=
ration
> + *          holds a SCSW and model-dependent data.
> + * - SCHIB: SubCHannel Information Block composed of:
> + *   - SCSW: SubChannel Status Word, status of the channel.
> + *   - PMCW: Path Management Control Word
> + * You need the QEMU ccw-pong device in QEMU to answer the I/O transfe=
rs.
> + */
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#undef DEBUG_CSS
> +#include <css.h>
> +
> +/*
> + * Try to have a more human representation of the SCSW flags:
> + * each letter in the two strings he under represent the first

s/he under//

> + * letter of the associated bit in the flag.

in the flag fields?

> + */
> +static const char *scsw_str =3D "kkkkslccfpixuzen";
> +static const char *scsw_str2 =3D "1SHCrshcsdsAIPSs";
> +static char scsw_line[64] =3D {};
> +
> +char *dump_scsw_flags(uint32_t f)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 16; i++) {
> +		if ((f << i) & 0x80000000)
> +			scsw_line[i] =3D scsw_str[i];
> +		else
> +			scsw_line[i] =3D '_';
> +	}
> +	scsw_line[i] =3D ' ';
> +	for (; i < 32; i++) {
> +		if ((f << i) & 0x80000000)
> +			scsw_line[i + 1] =3D scsw_str2[i - 16];
> +		else
> +			scsw_line[i + 1] =3D '_';
> +	}
> +	return scsw_line;
> +}
> +
> +/*
> + * Try o have a more human representation of the PMCW flags
> + * each letter in the two strings he under represent the first
> + * letter of the associated bit in the flag.

Please rephrase

> + */
> +static const char *pmcw_str =3D "11iii111ellmmdtv";
> +static char pcmw_line[32] =3D {};
> +char *dump_pmcw_flags(uint16_t f)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 16; i++) {
> +		if ((f << i) & 0x8000)
> +			pcmw_line[i] =3D pmcw_str[i];
> +		else
> +			pcmw_line[i] =3D '_';
> +	}
> +	return pcmw_line;
> +}
> +
> +#ifdef DEBUG_CSS
> +void dump_scsw(struct scsw *s)
> +{
> +	dump_scsw_flags(s->ctrl);
> +	printf("scsw->flags: %s\n", line);
> +	printf("scsw->addr : %08x\n", s->addr);
> +	printf("scsw->devs : %02x\n", s->devs);
> +	printf("scsw->schs : %02x\n", s->schs);
> +	printf("scsw->count: %04x\n", s->count);
> +}
> +
> +void dump_irb(struct irb *irbp)
> +{
> +	int i;
> +	uint32_t *p =3D (uint32_t *)irbp;
> +
> +	dump_scsw(&irbp->scsw);
> +	for (i =3D 0; i < sizeof(*irbp)/sizeof(*p); i++, p++)
> +		printf("irb[%02x] : %08x\n", i, *p);
> +}
> +
> +void dump_pmcw(struct pmcw *p)
> +{
> +	int i;
> +
> +	printf("pmcw->intparm  : %08x\n", p->intparm);
> +	printf("pmcw->flags    : %04x\n", p->flags);
> +	dump_pmcw_flags(p->flags);
> +	printf("pmcw->devnum   : %04x\n", p->devnum);
> +	printf("pmcw->lpm      : %02x\n", p->lpm);
> +	printf("pmcw->pnom     : %02x\n", p->pnom);
> +	printf("pmcw->lpum     : %02x\n", p->lpum);
> +	printf("pmcw->pim      : %02x\n", p->pim);
> +	printf("pmcw->mbi      : %04x\n", p->mbi);
> +	printf("pmcw->pom      : %02x\n", p->pom);
> +	printf("pmcw->pam      : %02x\n", p->pam);
> +	printf("pmcw->mbi      : %04x\n", p->mbi);
> +	for (i =3D 0; i < 8; i++)
> +		printf("pmcw->chpid[%d]: %02x\n", i, p->chpid[i]);
> +	printf("pmcw->flags2  : %08x\n", p->flags2);
> +}
> +
> +void dump_schib(struct schib *sch)
> +{
> +	struct pmcw *p =3D &sch->pmcw;
> +	struct scsw *s =3D &sch->scsw;
> +
> +	printf("--SCHIB--\n");
> +	dump_pmcw(p);
> +	dump_scsw(s);
> +}
> +
> +struct ccw *dump_ccw(struct ccw *cp)
> +{
> +	printf("CCW: code: %02x flags: %02x count: %04x data: %08x\n", cp->co=
de,
> +	    cp->flags, cp->count, cp->data);
> +
> +	if (cp->code =3D=3D CCW_C_TIC)
> +		return (struct ccw *)(long)cp->data;
> +
> +	return (cp->flags & CCW_F_CC) ? cp + 1 : NULL;
> +}
> +
> +void dump_orb(struct orb *op)
> +{
> +	struct ccw *cp;
> +
> +	printf("ORB: intparm : %08x\n", op->intparm);
> +	printf("ORB: ctrl    : %08x\n", op->ctrl);
> +	printf("ORB: prio    : %08x\n", op->prio);
> +	cp =3D (struct ccw *)(long) (op->cpa);
> +	while (cp)
> +		cp =3D dump_ccw(cp);
> +}
> +
> +#endif
>=20



--iMmnz3r5pZUe2SD6BDaEd5FGQl8CKApWQ--

--dc96MCbcXyr8pnzWxZtH3l4mj9pXmphNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yDbcACgkQ41TmuOI4
ufjXwhAAhmKJNnuLdw3JLHhpsDuab6cxfiI16QY+8+oKZVOq7/6jJamB8BUN6k73
Vn7iKEdHyy8wQuAeXeVXaaJiJT1zOfN326/iY01eSHeuUkJ9EzZK/bG75/VRosvR
AekvpSfA0Puki1lpf89AqDOzWVvwd3MX1mfGYC9ZLY6PFhYS9l0bsVdLcuxPDpjA
1GZMj5mmb903OBI0aACxqSmtAlgtgU/np8v+zLmT05hgsrnWElleR24AimGaKz98
GhVB1YQ1jhIcQ/de63bZkLpWcP5qyxMb81YpZ7BHCd0Y4w268ZZM2MheRo8Or3pV
3mvRq230ZmCnZwiv8IgxZIbWzX4h2A2fcixIZwoJsHtqgzsJsGQcggdqG8/sHq8R
ETuHnEn7VbYev1waGvzp9e1H9k8V3zc7ypS12RuFMg/5TWHV43SZ4TCScKkQ0Hby
VR1spXLplDXH5dljTXlamO/N1pYCvSqTPOsJb1sxTbiLyR+KCxlJHdZMdTOA7NxO
4sUcZwlgOKDY9me0g0gqRpQFVqm4OnQugtQ7jFA6PnvLmUhEUYqWA7mbKpFwMXUm
6qcjZYosxzsqlfD6KKZCUm6pWJJkz5EYY16q6KLysnvbE6/jZMJYYMpuDwok0x8b
zCtIp5BXVYf0slltBtp3pjiHt9yTkkM6hCurGpSvO9mYM+ZehAE=
=szOv
-----END PGP SIGNATURE-----

--dc96MCbcXyr8pnzWxZtH3l4mj9pXmphNV--
