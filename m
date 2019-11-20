Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727656AbfKTSQP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Nov 2019 13:16:15 -0500
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: SCLP unit test
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
 <1574157219-22052-4-git-send-email-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ed24d20-9c77-7f18-203b-b28a38b5e07f@redhat.com>
Date: Wed, 20 Nov 2019 19:16:03 +0100
MIME-Version: 1.0
In-Reply-To: <1574157219-22052-4-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 19/11/2019 10.53, Claudio Imbrenda wrote:
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
>  s390x/sclp.c        | 465 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  s390x/unittests.cfg |   3 +
>  3 files changed, 469 insertions(+)
>  create mode 100644 s390x/sclp.c
[...]
> +/**
> + * Test SCCB page boundary violations.
> + */
> +static void test_boundary(void)
> +{
> +=09const uint32_t cmd =3D SCLP_CMD_WRITE_EVENT_DATA;
> +=09const uint16_t res =3D SCLP_RC_SCCB_BOUNDARY_VIOLATION;
> +=09WriteEventData *sccb =3D (WriteEventData *)sccb_template;
> +=09int len, offset;
> +
> +=09memset(sccb_template, 0, sizeof(sccb_template));
> +=09sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
> +=09for (len =3D 32; len <=3D 4096; len++) {
> +=09=09offset =3D len & 7 ? len & ~7 : len - 8;

I needed some time to understand that line. I think it would be easier
that way:

=09=09offset =3D (len - 1) & ~7;

?

Anyway, no need to respin just because of that line ... the rest of the
patch looks ok to me.

> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index f1b07cd..75e3d37 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -75,3 +75,6 @@ file =3D stsi.elf
>  [smp]
>  file =3D smp.elf
>  extra_params =3D-smp 2
> +
> +[sclp]
> +file =3D sclp.elf

It's a little bit sad that some of the tests require < 2G of RAM while
other tests should (also) be done with > 2G if I understood that
correctly. So currently not all tests can be run automatically but just
starting the "run_tests.sh" script, right?

It does not have to be right now (i.e. could also be a follow-up patch
later), but what about adding two sections to the unittests.cfg file,
one with less and one with more than 2G of RAM? E.g.:

[sclp-1g]
file =3D sclp.elf
extra_params =3D -m 1G

[sclp-3g]
file =3D sclp.elf
extra_params =3D -m 3G -append "somemagicparametertoonlyrunthebigmemtest"

?

 Thomas
