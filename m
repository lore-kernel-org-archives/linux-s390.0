Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390489AbfJWMsg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 08:48:36 -0400
Date: Wed, 23 Oct 2019 08:48:33 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1189848719.8181299.1571834913066.JavaMail.zimbra@redhat.com>
In-Reply-To: <1571741584-17621-6-git-send-email-imbrenda@linux.ibm.com>
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com> <1571741584-17621-6-git-send-email-imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v1 5/5] s390x: SCLP unit test
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

----- Original Message -----
> From: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
> Sent: Tuesday, October 22, 2019 12:53:04 PM
>=20
> SCLP unit test. Testing the following:
>=20
> * Correctly ignoring instruction bits that should be ignored
> * Privileged instruction check
> * Check for addressing exceptions
> * Specification exceptions:
>   - SCCB size less than 8
>   - SCCB unaligned
>   - SCCB overlaps prefix or lowcore
>   - SCCB address higher than 2GB
> * Return codes for
>   - Invalid command
>   - SCCB too short (but at least 8)
>   - SCCB page boundary violation
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sclp.c        | 373
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   3 +
>  3 files changed, 377 insertions(+)
>  create mode 100644 s390x/sclp.c
>=20
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 3744372..ddb4b48 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -16,6 +16,7 @@ tests +=3D $(TEST_DIR)/diag288.elf
>  tests +=3D $(TEST_DIR)/stsi.elf
>  tests +=3D $(TEST_DIR)/skrf.elf
>  tests +=3D $(TEST_DIR)/smp.elf
> +tests +=3D $(TEST_DIR)/sclp.elf
>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
> =20
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/sclp.c b/s390x/sclp.c
> new file mode 100644
> index 0000000..d7a9212
> --- /dev/null
> +++ b/s390x/sclp.c
> @@ -0,0 +1,373 @@
> +/*
> + * Store System Information tests

Copy-n-paste from stsi.c ?

> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Claudio Imbrenda <imbrenda@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <asm/page.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/interrupt.h>
> +#include <sclp.h>
[...]
> +static int test_one_run(uint32_t cmd, uint64_t addr, uint16_t len,
> +=09=09=09uint16_t clear, uint64_t exp_pgm, uint16_t exp_rc)
> +{
> +=09char sccb[4096];
> +=09void *p =3D sccb;
> +
> +=09if (!len && !clear)
> +=09=09p =3D NULL;
> +=09else
> +=09=09memset(sccb, 0, sizeof(sccb));
> +=09((SCCBHeader *)sccb)->length =3D len;
> +=09if (clear && (clear < 8))

Please remove the parentheses around "clear < 8".

> +=09=09clear =3D 8;
> +=09return test_one_sccb(cmd, addr, clear, p, exp_pgm, exp_rc);
> +}
> +
> +#define PGM_BIT_SPEC=09(1ULL << PGM_INT_CODE_SPECIFICATION)
> +#define PGM_BIT_ADDR=09(1ULL << PGM_INT_CODE_ADDRESSING)
> +#define PGM_BIT_PRIV=09(1ULL << PGM_INT_CODE_PRIVILEGED_OPERATION)
> +
> +#define PGBUF=09((uintptr_t)pagebuf)
> +#define VALID=09(valid_sclp_code)
> +
> +static void test_sccb_too_short(void)
> +{
> +=09int cx;
> +
> +=09for (cx =3D 0; cx < 8; cx++)
> +=09=09if (!test_one_run(VALID, PGBUF, cx, 8, PGM_BIT_SPEC, 0))
> +=09=09=09break;
> +
> +=09report("SCCB too short", cx =3D=3D 8);
> +}
> +
> +static void test_sccb_unaligned(void)
> +{
> +=09int cx;
> +
> +=09for (cx =3D 1; cx < 8; cx++)
> +=09=09if (!test_one_run(VALID, cx + PGBUF, 8, 8, PGM_BIT_SPEC, 0))
> +=09=09=09break;
> +=09report("SCCB unaligned", cx =3D=3D 8);
> +}
> +
> +static void test_sccb_prefix(void)
> +{
> +=09uint32_t prefix, new_prefix;
> +=09int cx;
> +
> +=09for (cx =3D 0; cx < 8192; cx +=3D 8)
> +=09=09if (!test_one_run(VALID, cx, 0, 0, PGM_BIT_SPEC, 0))
> +=09=09=09break;
> +=09report("SCCB low pages", cx =3D=3D 8192);
> +
> +=09new_prefix =3D (uint32_t)(intptr_t)prefix_buf;
> +=09memcpy(prefix_buf, 0, 8192);
> +=09asm volatile("stpx %0": "+Q"(prefix));

Isn't "=3DQ" sufficient enough here?

> +=09asm volatile("spx %0": "+Q"(new_prefix));

Shouldn't that be just an input parameter instead? ... and maybe also bette=
r add "memory" to the clobber list, since the memory layout has changed.

> +=09for (cx =3D 0; cx < 8192; cx +=3D 8)
> +=09=09if (!test_one_run(VALID, new_prefix + cx, 8, 8, PGM_BIT_SPEC, 0))
> +=09=09=09break;
> +=09report("SCCB prefix pages", cx =3D=3D 8192);
> +
> +=09memcpy(prefix_buf, 0, 8192);
> +=09asm volatile("spx %0": "+Q"(prefix));

dito?

> +}

 Thomas
