Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgD0NG4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 09:06:56 -0400
Subject: Re: [kvm-unit-tests PATCH v6 06/10] s390x: css: stsch, enumeration
 test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <2f1e27a9-1cb2-79b2-b655-6f170431a14f@linux.ibm.com>
Date: Mon, 27 Apr 2020 15:06:48 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Aq0bUnkXJUTuQNnQsgaJGCELpHbwGkafP"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aq0bUnkXJUTuQNnQsgaJGCELpHbwGkafP
Content-Type: multipart/mixed; boundary="Y95dPwLfgyXzPR3Grej7fTOORbhD9gPwz"

--Y95dPwLfgyXzPR3Grej7fTOORbhD9gPwz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:45 PM, Pierre Morel wrote:
> First step for testing the channel subsystem is to enumerate the css an=
d
> retrieve the css devices.
>=20
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  1 +
>  s390x/Makefile      |  2 +
>  s390x/css.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++=

>  s390x/unittests.cfg |  4 ++
>  4 files changed, 99 insertions(+)
>  create mode 100644 s390x/css.c
>=20
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> index bab0dd5..9417541 100644
> --- a/lib/s390x/css.h
> +++ b/lib/s390x/css.h
> @@ -82,6 +82,7 @@ struct pmcw {
>  	uint8_t  chpid[8];
>  	uint32_t flags2;
>  };
> +#define PMCW_CHANNEL_TYPE(pmcw) (pmcw->flags2 >> 21)

Why isn't this in the library patch?

> =20
>  struct schib {
>  	struct pmcw pmcw;
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ddb4b48..baebf18 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -17,6 +17,7 @@ tests +=3D $(TEST_DIR)/stsi.elf
>  tests +=3D $(TEST_DIR)/skrf.elf
>  tests +=3D $(TEST_DIR)/smp.elf
>  tests +=3D $(TEST_DIR)/sclp.elf
> +tests +=3D $(TEST_DIR)/css.elf
>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
> =20
>  all: directories test_cases test_cases_binary
> @@ -51,6 +52,7 @@ cflatobjs +=3D lib/s390x/sclp-console.o
>  cflatobjs +=3D lib/s390x/interrupt.o
>  cflatobjs +=3D lib/s390x/mmu.o
>  cflatobjs +=3D lib/s390x/smp.o
> +cflatobjs +=3D lib/s390x/css_dump.o

Why isn't this in the library patch?

> =20
>  OBJDIRS +=3D lib/s390x
> =20
> diff --git a/s390x/css.c b/s390x/css.c
> new file mode 100644
> index 0000000..cc97e79
> --- /dev/null
> +++ b/s390x/css.c
> @@ -0,0 +1,92 @@
> +/*
> + * Channel Subsystem tests
> + *
> + * Copyright (c) 2020 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <alloc_phys.h>
> +#include <asm/page.h>
> +#include <string.h>
> +#include <interrupt.h>
> +#include <asm/arch_def.h>
> +
> +#include <css.h>
> +
> +#define SID_ONE		0x00010000

Why isn't this in the library patch?

> +
> +static struct schib schib;
> +static int test_device_sid;
> +
> +static void test_enumerate(void)
> +{
> +	struct pmcw *pmcw =3D &schib.pmcw;
> +	int cc;
> +	int scn;
> +	int scn_found =3D 0;
> +	int dev_found =3D 0;
> +
> +	for (scn =3D 0; scn < 0xffff; scn++) {
> +		cc =3D stsch(scn|SID_ONE, &schib);
> +		switch (cc) {
> +		case 0:		/* 0 means SCHIB stored */
> +			break;
> +		case 3:		/* 3 means no more channels */
> +			goto out;
> +		default:	/* 1 or 2 should never happened for STSCH */
> +			report(0, "Unexpected cc=3D%d on subchannel number 0x%x",
> +			       cc, scn);
> +			return;
> +		}
> +		/* We currently only support type 0, a.k.a. I/O channels */
> +		if (PMCW_CHANNEL_TYPE(pmcw) !=3D 0)
> +			continue;
> +		/* We ignore I/O channels without valid devices */
> +		scn_found++;
> +		if (!(pmcw->flags & PMCW_DNV))
> +			continue;
> +		/* We keep track of the first device as our test device */
> +		if (!test_device_sid)
> +			test_device_sid =3D scn|SID_ONE;

Give the pipe some space :)

> +		dev_found++;

Newlines would make this more readable.

> +	}
> +out:

We can report dev_found instead of 0/1 and a if/else

report(dev_found,
	"Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d",
                    scn, scn_found, dev_found);=09

> +	if (!dev_found) {
> +		report(0,
> +		       "Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d=
",
> +		       scn, scn_found, dev_found);
> +		return;
> +	}
> +	report(1,
> +	       "Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d"=
,
> +	       scn, scn_found, dev_found);
> +}
> +
> +static struct {
> +	const char *name;
> +	void (*func)(void);
> +} tests[] =3D {
> +	{ "enumerate (stsch)", test_enumerate },
> +	{ NULL, NULL }
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	int i;
> +
> +	report_prefix_push("Channel Subsystem");
> +	for (i =3D 0; tests[i].name; i++) {
> +		report_prefix_push(tests[i].name);
> +		tests[i].func();
> +		report_prefix_pop();
> +	}
> +	report_prefix_pop();
> +
> +	return report_summary();
> +}
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index 07013b2..a436ec0 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -83,3 +83,7 @@ extra_params =3D -m 1G
>  [sclp-3g]
>  file =3D sclp.elf
>  extra_params =3D -m 3G
> +
> +[css]
> +file =3D css.elf
> +extra_params =3D-device ccw-pong
>=20



--Y95dPwLfgyXzPR3Grej7fTOORbhD9gPwz--

--Aq0bUnkXJUTuQNnQsgaJGCELpHbwGkafP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6m2OgACgkQ41TmuOI4
ufimLg/+Kt1j5l3VyTURlS5kWRzPhJf4kcLS79Xdj/b/Wdmny6e62anAuEptD+5A
aRinGtalQ5UC1EebK7U+k8bsmeuwoU4J/h2ZSqDmcvKEj8xAp/SkMKWggOvJNveI
ojjLnt0313WCFn7i6oYZqkCdqOYraNg8rBQHfuoejOoNHJqITiV33m94U7P/71ZW
HIzKtAE1WpTe5dt/8mxzpbJT2GNiDb1AlqmBwSh84qrgWEtmpw7f0dx3TlL5mqzi
DGo8+r51mpaWHndSu0TIHbwF6HBYT/T5jmCabAE0NtGAhOCe23xQdiX2H92/8LYI
xY35YGVwjfDcSGX0v2RUq6uUKl4tJlG3+TG5O0rEJmJ6FYmVYstCIVfN6FJI5CSP
YBqqHZO7z8+3wRMCL6HloiS4O3VADLL/YbwmSKVGDBhoxtEvhZk7PmlBf69NqKDn
Zxsy8ocILtuExcOlRAhtGyEcbksK4Gsk3q4t00r2OocsgGG+1bFEd0o6NrAmasCV
x4ADyumzf1ymWmZiHKePbN30mx2F6YdOPmj5CYib/ALBkaoy7V0R6+959v/jmEvw
i88JnT7zMr9GKlW0HSdkxhCE/Xnt2BxVHZ45fdMs6fk/8gddifKewwPNsy8D/bqk
N19IQlc+UrY0+q36CEFhPd1U1qPJPl5LODWZ8svHtRJ3HDpeGy4=
=tLCB
-----END PGP SIGNATURE-----

--Aq0bUnkXJUTuQNnQsgaJGCELpHbwGkafP--
