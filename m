Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42616 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729881AbgC3MvA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 08:51:00 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
Date: Mon, 30 Mar 2020 14:50:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200330122035.19607-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

On 30.03.20 14:20, Janosch Frank wrote:
> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
> a bit more thorough.
>=20
> In this test we set a custom name and uuid through the QEMU command
> line. Both parameters will be passed to the guest on a stsi subcode
> 3.2.2 call and will then be checked.
>=20
> We also compare the total and configured cpu numbers against the smp
> reported numbers.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c        | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  1 +
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index e9206bca137d2edb..10e588a78cc05186 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -14,7 +14,28 @@
>  #include <asm/page.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/interrupt.h>
> +#include <smp.h>
> =20
> +struct stsi_322 {
> +    uint8_t  reserved[31];
> +    uint8_t  count;
> +    struct {
> +        uint8_t  reserved2[4];

I dislike aligning the members using double-spaces ...

> +        uint16_t total_cpus;
> +        uint16_t conf_cpus;
> +        uint16_t standby_cpus;
> +        uint16_t reserved_cpus;
> +        uint8_t  name[8];
> +        uint32_t caf;
> +        uint8_t  cpi[16];
> +        uint8_t reserved5[3];

... e.g., here it's not aligned anymore. Just use single spaces.

> +        uint8_t ext_name_encoding;
> +        uint32_t reserved3;
> +        uint8_t uuid[16];
> +    } vm[8];
> +    uint8_t reserved4[1504];
> +    uint8_t ext_names[8][256];
> +};
>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE=
 * 2)));
> =20
>  static void test_specs(void)
> @@ -76,11 +97,52 @@ static void test_fc(void)
>  	report(stsi_get_fc(pagebuf) >=3D 2, "query fc >=3D 2");
>  }
> =20
> +static void test_3_2_2(void)
> +{
> +	int rc;
> +	/* EBCDIC for "kvm-unit" */
> +	uint8_t vm_name[] =3D { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89, 0xa=
3 };
> +	uint8_t uuid[] =3D { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
> +			   0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
> +			   0x00, 0x03 };
> +	/* EBCDIC for "KVM/" */
> +	uint8_t cpi_kvm[] =3D { 0xd2, 0xe5, 0xd4, 0x61 };

All of these can be const.

> +	const char *vm_name_ext =3D "kvm-unit-test";
> +	struct stsi_322 *data =3D (void *)pagebuf;
> +
> +	/* Is the function code available at all? */
> +	if (stsi_get_fc(pagebuf) < 3)

Maybe report_skip() ?

> +		return;
> +
> +	report_prefix_push("3.2.2");
> +	rc =3D stsi(pagebuf, 3, 2, 2);
> +	report(!rc, "call");
> +
> +	/* For now we concentrate on KVM/QEMU */
> +	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm)))

Maybe report_skip() ?

> +		goto out;
> +
> +	report(data->vm[0].total_cpus =3D=3D smp_query_num_cpus(), "cpu # tot=
al");
> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # conf=
igured");
> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
> +	report(data->vm[0].reserved_cpus =3D=3D 0, "cpu # reserved");

IIRC, using -smp 1,maxcpus=3DX, you could also test the reported reserved
CPUs.


Also passes under TCG, nice :)

--=20
Thanks,

David / dhildenb
