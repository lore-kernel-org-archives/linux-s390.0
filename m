Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgFVJfi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 05:35:38 -0400
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for CSS
 tests
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <55412942-21fb-817b-8645-4711a985f068@linux.ibm.com>
Date: Mon, 22 Jun 2020 11:35:28 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lxSYNQElsvrCqU8I4g5tCJtptKzt3pUBO"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lxSYNQElsvrCqU8I4g5tCJtptKzt3pUBO
Content-Type: multipart/mixed; boundary="ETJjmlxEB98Y5rkSJ1ENhzLVYDDRs99wo"

--ETJjmlxEB98Y5rkSJ1ENhzLVYDDRs99wo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/15/20 11:31 AM, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Acked-by: Janosch Frank <frankja@de.ibm.com>

> ---
>  lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++=

>  lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>  s390x/Makefile       |   1 +
>  3 files changed, 410 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c
>=20
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> new file mode 100644
> index 0000000..0ddceb1
> --- /dev/null
> +++ b/lib/s390x/css.h
> @@ -0,0 +1,256 @@
> +/*
> + * CSS definitions
> + *
> + * Copyright IBM, Corp. 2020
> + * Author: Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
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
> +	register long long reg1 asm("1") =3D schid;
> +	int cc;
> +
> +	asm volatile(
> +		"	ssch	0(%2)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28\n"
> +		: "=3Dd" (cc)
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
> +		"	stsch	0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
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
> +		"	msch	0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
> +		: "=3Dd" (cc)
> +		: "d" (reg1), "m" (*addr), "a" (addr)
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
> +		"	tsch	0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28"
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
> +void dump_scsw(struct scsw *scsw);
> +void dump_irb(struct irb *irbp);
> +void dump_schib(struct schib *sch);
> +struct ccw1 *dump_ccw(struct ccw1 *cp);
> +void dump_irb(struct irb *irbp);
> +void dump_pmcw(struct pmcw *p);
> +void dump_orb(struct orb *op);
> +
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
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + *
> + * Description:
> + * Provides the dumping functions for various structures used by subch=
annels:
> + * - ORB  : Operation request block, describes the I/O operation and p=
oints to
> + *          a CCW chain
> + * - CCW  : Channel Command Word, describes the command, data and flow=
 control
> + * - IRB  : Interuption response Block, describes the result of an ope=
ration;
> + *          holds a SCSW and model-dependent data.
> + * - SCHIB: SubCHannel Information Block composed of:
> + *   - SCSW: SubChannel Status Word, status of the channel.
> + *   - PMCW: Path Management Control Word
> + * You need the QEMU ccw-pong device in QEMU to answer the I/O transfe=
rs.
> + */
> +
> +#include <libcflat.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <css.h>
> +
> +/*
> + * Try to have a more human representation of the SCSW flags:
> + * each letter in the two strings represents the first
> + * letter of the associated bit in the flag fields.
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
> + * Try to have a more human representation of the PMCW flags
> + * each letter in the string represents the first
> + * letter of the associated bit in the flag fields.
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
> +void dump_scsw(struct scsw *s)
> +{
> +	dump_scsw_flags(s->ctrl);
> +	printf("scsw->flags: %s\n", scsw_line);
> +	printf("scsw->addr : %08x\n", s->ccw_addr);
> +	printf("scsw->devs : %02x\n", s->dev_stat);
> +	printf("scsw->schs : %02x\n", s->sch_stat);
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
> +struct ccw1 *dump_ccw(struct ccw1 *cp)
> +{
> +	printf("CCW: code: %02x flags: %02x count: %04x data: %08x\n", cp->co=
de,
> +	    cp->flags, cp->count, cp->data_address);
> +
> +	if (cp->code =3D=3D CCW_C_TIC)
> +		return (struct ccw1 *)(long)cp->data_address;
> +
> +	return (cp->flags & CCW_F_CC) ? cp + 1 : NULL;
> +}
> +
> +void dump_orb(struct orb *op)
> +{
> +	struct ccw1 *cp;
> +
> +	printf("ORB: intparm : %08x\n", op->intparm);
> +	printf("ORB: ctrl    : %08x\n", op->ctrl);
> +	printf("ORB: prio    : %08x\n", op->prio);
> +	cp =3D (struct ccw1 *)(long) (op->cpa);
> +	while (cp)
> +		cp =3D dump_ccw(cp);
> +}
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 47a94cc..3cb97da 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -52,6 +52,7 @@ cflatobjs +=3D lib/s390x/interrupt.o
>  cflatobjs +=3D lib/s390x/mmu.o
>  cflatobjs +=3D lib/s390x/smp.o
>  cflatobjs +=3D lib/s390x/kernel-args.o
> +cflatobjs +=3D lib/s390x/css_dump.o
> =20
>  OBJDIRS +=3D lib/s390x
> =20
>=20



--ETJjmlxEB98Y5rkSJ1ENhzLVYDDRs99wo--

--lxSYNQElsvrCqU8I4g5tCJtptKzt3pUBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7we2EACgkQ41TmuOI4
ufi+Cg/+M3TeMUHNyCqeAeOpSbQBCmuWdk+tLbQEE9DnkIA3n9r7nFa3D/Me6mJ8
P8sQgQHPp9U463lK+8dD0jyIMplKHUCrrwnAZjS4uqejaxjAqmr7WvBBGZGwF6QP
U6dVRLjaGiw5wkXrf2EZNmVu1Lz4ZKEt67RGYLwS/Jb8jN8bXxm7q4zTPZKp3yET
o/Uz5r8WgI99ghhO8yym2ZKE1xt2qz5tofuvFYiej+W3OZfXByCOWndKZ/cUJeTE
gM8aPlCVd6K/lb3bHg7EozVa7F2WHn9Db6g2RG6stt0fpAGnBEvv1XSEUiW5B/W4
FzsvPLWgOT+t3bJ5PdTTA6ID7WvjF8XP7YEaZ5IydnMjat6A7opfapi7xgGNSKE3
PgYXPo86OvW+oQ8VNUssFIMV6ZWr+lyDHRUfkmuu5KQFDMtPla5yFrKvtGNk3hPx
ADFrsf66/EGeR3D+MHrNwr+v0PLUPlBfJcNVU2sZGg8NQ0djo9tbGUcsy9PpaCq2
s62IRgdOu113m6hL2pnNjJvcWgHftIVbFrBBSXyL+pc6VmzEACi1vy4QWi4uV7M/
545Zm/mkS62/tG0/4pEVWtkyKbqZSPFV5gpS9D50kK+U7VVo8thK0C8H4c0OAuE3
Z8rXbNXHd+fHjJcNT6D2gf5PAhmzm5KGqv1kGbwndO0HLX50FAo=
=kAWt
-----END PGP SIGNATURE-----

--lxSYNQElsvrCqU8I4g5tCJtptKzt3pUBO--
